# Pokemon Data Summary Script (PowerShell)
# Generate CSV report and calculate averages

$DATA_DIR = "pokemon_data"
$CSV_FILE = "pokemon_report.csv"

# Check if data directory exists
if (-not (Test-Path $DATA_DIR)) {
    Write-Host "Error: $DATA_DIR directory not found. Please run batch processing script first."
    exit 1
}

# Create CSV header
"Name,Height (m),Weight (kg)" | Out-File -FilePath $CSV_FILE -Encoding UTF8

# Initialize arrays for calculations
$heights = @()
$weights = @()

# Process each JSON file and extract data
$jsonFiles = Get-ChildItem -Path $DATA_DIR -Filter "*.json"

foreach ($jsonFile in $jsonFiles) {
    try {
        $pokemonData = Get-Content $jsonFile.FullName | ConvertFrom-Json
        
        $name = (Get-Culture).TextInfo.ToTitleCase($pokemonData.name.ToLower())
        $height = [math]::Round($pokemonData.height / 10, 1)
        $weight = [math]::Round($pokemonData.weight / 10, 1)
        
        # Add to CSV
        "$name,$height,$weight" | Add-Content -Path $CSV_FILE
        
        # Store for average calculation
        $heights += $height
        $weights += $weight
    }
    catch {
        Write-Host "Error processing $($jsonFile.Name): $($_.Exception.Message)"
    }
}

Write-Host "CSV Report generated at: $CSV_FILE"
Write-Host ""

# Display the CSV content
Get-Content $CSV_FILE
Write-Host ""

# Calculate averages
if ($heights.Count -gt 0) {
    $avgHeight = ($heights | Measure-Object -Average).Average
    $avgWeight = ($weights | Measure-Object -Average).Average
    
    Write-Host "Average Height: $([math]::Round($avgHeight, 2)) m"
    Write-Host "Average Weight: $([math]::Round($avgWeight, 2)) kg"
} else {
    Write-Host "No data found for average calculation."
}

