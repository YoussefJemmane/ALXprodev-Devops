# API Request Automation Script (PowerShell)
# Fetch Pikachu data from Pokemon API

$API_URL = "https://pokeapi.co/api/v2/pokemon/pikachu"
$OUTPUT_FILE = "data.json"
$ERROR_FILE = "errors.txt"

Write-Host "Fetching Pikachu data from Pokemon API..."

try {
    # Make API request using Invoke-RestMethod
    $response = Invoke-RestMethod -Uri $API_URL -Method Get
    $response | ConvertTo-Json -Depth 10 | Out-File -FilePath $OUTPUT_FILE -Encoding UTF8
    Write-Host "Successfully fetched Pikachu data and saved to $OUTPUT_FILE"
}
catch {
    $errorMessage = "$(Get-Date): Failed to fetch data from $API_URL - $($_.Exception.Message)"
    Add-Content -Path $ERROR_FILE -Value $errorMessage
    Write-Host "Error: Failed to fetch Pikachu data. Check $ERROR_FILE for details."
    exit 1
}

