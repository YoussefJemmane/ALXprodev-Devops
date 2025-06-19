# Batch Pokemon Data Retrieval Script (PowerShell)
# Fetch data for multiple Pokemon with retry logic

$POKEMON_LIST = @("bulbasaur", "ivysaur", "venusaur", "charmander", "charmeleon")
$DATA_DIR = "pokemon_data"
$BASE_URL = "https://pokeapi.co/api/v2/pokemon"
$DELAY = 1  # Delay between requests in seconds
$MAX_RETRIES = 3

# Create data directory if it doesn't exist
if (-not (Test-Path $DATA_DIR)) {
    New-Item -ItemType Directory -Path $DATA_DIR | Out-Null
}

# Function to fetch Pokemon data with retry logic
function Fetch-PokemonData {
    param(
        [string]$Pokemon
    )
    
    $outputFile = Join-Path $DATA_DIR "$Pokemon.json"
    $url = "$BASE_URL/$Pokemon"
    $retries = 0
    
    Write-Host "Fetching data for $Pokemon..."
    
    while ($retries -lt $MAX_RETRIES) {
        try {
            $response = Invoke-RestMethod -Uri $url -Method Get
            $response | ConvertTo-Json -Depth 10 | Out-File -FilePath $outputFile -Encoding UTF8
            Write-Host "Saved data to $outputFile ✅"
            return $true
        }
        catch {
            $retries++
            if ($retries -lt $MAX_RETRIES) {
                Write-Host "Retry $retries/$MAX_RETRIES for $Pokemon..."
                Start-Sleep -Seconds $DELAY
            }
        }
    }
    
    $errorMessage = "$(Get-Date): Failed to fetch data for $Pokemon after $MAX_RETRIES attempts"
    Add-Content -Path "errors.txt" -Value $errorMessage
    Write-Host "❌ Failed to fetch data for $Pokemon after $MAX_RETRIES attempts"
    return $false
}

# Fetch data for each Pokemon
foreach ($pokemon in $POKEMON_LIST) {
    Fetch-PokemonData -Pokemon $pokemon
    
    # Add delay between requests to handle rate limiting
    if ($pokemon -ne $POKEMON_LIST[-1]) {
        Start-Sleep -Seconds $DELAY
    }
}

Write-Host "Batch processing completed!"

