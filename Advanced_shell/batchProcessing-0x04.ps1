# Parallel Pokemon Data Fetching Script (PowerShell)
# Fetch multiple Pokemon data simultaneously using background jobs

$POKEMON_LIST = @("bulbasaur", "ivysaur", "venusaur", "charmander", "charmeleon")
$DATA_DIR = "pokemon_data_parallel"
$BASE_URL = "https://pokeapi.co/api/v2/pokemon"
$MAX_RETRIES = 3

# Create data directory if it doesn't exist
if (-not (Test-Path $DATA_DIR)) {
    New-Item -ItemType Directory -Path $DATA_DIR | Out-Null
}

# Start parallel jobs using Start-Job
Write-Host "Starting parallel data fetching for $($POKEMON_LIST.Count) Pokemon..."
$jobs = @()

foreach ($pokemon in $POKEMON_LIST) {
    $job = Start-Job -ScriptBlock {
        param($Pokemon, $DataDir, $BaseUrl, $MaxRetries)
        
        $outputFile = Join-Path $DataDir "$Pokemon.json"
        $url = "$BaseUrl/$Pokemon"
        $retries = 0
        $success = $false
        
        "Starting parallel fetch for $Pokemon..." | Write-Output
        
        while ($retries -lt $MaxRetries -and -not $success) {
            try {
                $response = Invoke-RestMethod -Uri $url -Method Get
                $response | ConvertTo-Json -Depth 10 | Out-File -FilePath $outputFile -Encoding UTF8
                "✅ Successfully fetched data for $Pokemon -> $outputFile" | Write-Output
                $success = $true
            }
            catch {
                $retries++
                if ($retries -lt $MaxRetries) {
                    "Retry $retries/$MaxRetries for $Pokemon..." | Write-Output
                    Start-Sleep -Seconds 1
                }
            }
        }
        
        if (-not $success) {
            $errorMessage = "$(Get-Date): Failed to fetch data for $Pokemon after $MaxRetries attempts"
            Add-Content -Path "errors_parallel.txt" -Value $errorMessage
            "❌ Failed to fetch data for $Pokemon after $MaxRetries attempts" | Write-Output
        }
        
        return $success
    } -ArgumentList $pokemon, $DATA_DIR, $BASE_URL, $MAX_RETRIES
    
    $jobs += @{
        Job = $job
        Pokemon = $pokemon
    }
}

# Wait for all jobs to complete and collect results
Write-Host "Waiting for all parallel processes to complete..."
$failedCount = 0

foreach ($jobInfo in $jobs) {
    $job = $jobInfo.Job
    $pokemon = $jobInfo.Pokemon
    
    # Wait for job to complete
    $job | Wait-Job | Out-Null
    
    # Get job output
    $output = Receive-Job -Job $job
    
    # Display output (excluding the boolean return value)
    $output | Where-Object { $_ -is [string] } | ForEach-Object { Write-Host $_ }
    
    # Check if job failed (last output should be boolean)
    $success = $output | Where-Object { $_ -is [bool] } | Select-Object -Last 1
    if (-not $success) {
        $failedCount++
    }
    
    # Clean up job
    Remove-Job -Job $job
}

# Summary
$totalPokemon = $POKEMON_LIST.Count
$successfulCount = $totalPokemon - $failedCount

Write-Host ""
Write-Host "=== Parallel Fetching Summary ==="
Write-Host "Total Pokemon: $totalPokemon"
Write-Host "Successful: $successfulCount"
Write-Host "Failed: $failedCount"
Write-Host ""

if ($failedCount -eq 0) {
    Write-Host "🎉 All Pokemon data fetched successfully!"
} else {
    Write-Host "⚠️  Some Pokemon data failed to fetch. Check errors_parallel.txt for details."
}

# List downloaded files
Write-Host ""
Write-Host "Downloaded files:"
$downloadedFiles = Get-ChildItem -Path $DATA_DIR -Filter "*.json" -ErrorAction SilentlyContinue
if ($downloadedFiles) {
    $downloadedFiles | ForEach-Object { Write-Host "  $($_.Name)" }
} else {
    Write-Host "  No files downloaded."
}

