# Verification Script for Advanced Shell Scripting Requirements
# This script checks that all required elements are present in the bash scripts

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "Verifying Advanced Shell Scripting Requirements" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

# Function to check if pattern exists in file
function Test-Pattern {
    param($FilePath, $Pattern, $Description)
    
    if (Test-Path $FilePath) {
        $matches = Select-String -Pattern $Pattern -Path $FilePath -SimpleMatch
        if ($matches) {
            Write-Host "✅ $Description" -ForegroundColor Green
            return $true
        } else {
            Write-Host "❌ $Description" -ForegroundColor Red
            return $false
        }
    } else {
        Write-Host "❌ File not found: $FilePath" -ForegroundColor Red
        return $false
    }
}

# Check batchProcessing-0x04 for parallel processing requirements
Write-Host "Checking batchProcessing-0x04:" -ForegroundColor Yellow
Test-Pattern "batchProcessing-0x04" "jobs" "Contains 'jobs' command for process management"
Test-Pattern "batchProcessing-0x04" "kill" "Contains 'kill' command for process checking"
Test-Pattern "batchProcessing-0x04" "wait" "Contains 'wait' for process synchronization"
Test-Pattern "batchProcessing-0x04" "&" "Uses background processes (&)"
Write-Host ""

# Check summaryData-0x03 for text processing requirements
Write-Host "Checking summaryData-0x03:" -ForegroundColor Yellow
Test-Pattern "summaryData-0x03" "awk" "Uses 'awk' for calculations"
Test-Pattern "summaryData-0x03" "sed" "Uses 'sed' for text manipulation"
Test-Pattern "summaryData-0x03" "Average" "Calculates averages"
Write-Host ""

# Check data_extraction_automation-0x01 for formatting requirements
Write-Host "Checking data_extraction_automation-0x01:" -ForegroundColor Yellow
Test-Pattern "data_extraction_automation-0x01" "formatted_weight" "Uses formatted_weight variable"
Test-Pattern "data_extraction_automation-0x01" "formatted_height" "Uses formatted_height variable"
Test-Pattern "data_extraction_automation-0x01" "is of type" "Contains required output format"
Write-Host ""

# Display the actual output format from the script
Write-Host "Actual output format in data_extraction_automation-0x01:" -ForegroundColor Cyan
$formatLine = Select-String -Pattern "echo.*is of type" -Path "data_extraction_automation-0x01"
if ($formatLine) {
    Write-Host "  $($formatLine.Line.Trim())" -ForegroundColor White
}
Write-Host ""

Write-Host "=========================================" -ForegroundColor Green
Write-Host "Verification Complete!" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Green

