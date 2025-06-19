# Data Extraction Script (PowerShell)
# Extract specific Pokemon data from JSON and format it

$JSON_FILE = "data.json"

if (-not (Test-Path $JSON_FILE)) {
    Write-Host "Error: $JSON_FILE not found. Please run the API automation script first."
    exit 1
}

try {
    # Read and parse JSON data
    $pokemonData = Get-Content $JSON_FILE | ConvertFrom-Json
    
    # Extract data
    $name = (Get-Culture).TextInfo.ToTitleCase($pokemonData.name.ToLower())
    $height = [math]::Round($pokemonData.height / 10, 1)
    $weight = [math]::Round($pokemonData.weight / 10, 0)
    $type = (Get-Culture).TextInfo.ToTitleCase($pokemonData.types[0].type.name.ToLower())
    
    # Format the output
    Write-Host "$name is of type $type, weighs ${weight}kg, and is ${height}m tall."
}
catch {
    Write-Host "Error processing JSON data: $($_.Exception.Message)"
    exit 1
}

