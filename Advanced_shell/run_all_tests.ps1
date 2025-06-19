# Run All Advanced Shell Scripting Tasks
# This script executes all tasks in sequence to demonstrate the complete workflow

Write-Host "===========================================" -ForegroundColor Cyan
Write-Host "Advanced Shell Scripting - Pokemon API Tasks" -ForegroundColor Cyan
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host ""

# Task 0: API Request Automation
Write-Host "Task 0: API Request Automation" -ForegroundColor Yellow
Write-Host "------------------------------" -ForegroundColor Yellow
.\apiAutomation-0x00.ps1
Write-Host ""

# Task 1: Extract Pokemon Data
Write-Host "Task 1: Extract Pokemon Data" -ForegroundColor Yellow
Write-Host "-----------------------------" -ForegroundColor Yellow
.\data_extraction_automation-0x01.ps1
Write-Host ""

# Task 2: Batch Pokemon Data Retrieval
Write-Host "Task 2: Batch Pokemon Data Retrieval" -ForegroundColor Yellow
Write-Host "-------------------------------------" -ForegroundColor Yellow
.\batchProcessing-0x02.ps1
Write-Host ""

# Task 3: Summarize Pokemon Data
Write-Host "Task 3: Summarize Pokemon Data" -ForegroundColor Yellow
Write-Host "-------------------------------" -ForegroundColor Yellow
.\summaryData-0x03.ps1
Write-Host ""

# Task 5: Parallel Data Fetching
Write-Host "Task 5: Parallel Data Fetching" -ForegroundColor Yellow
Write-Host "-------------------------------" -ForegroundColor Yellow
.\batchProcessing-0x04.ps1
Write-Host ""

Write-Host "===========================================" -ForegroundColor Green
Write-Host "All tasks completed successfully!" -ForegroundColor Green
Write-Host "===========================================" -ForegroundColor Green

# Show final file structure
Write-Host ""
Write-Host "Generated Files:" -ForegroundColor Cyan
Get-ChildItem -Name | Where-Object { $_ -match "\.(json|csv|txt)$" } | ForEach-Object { Write-Host "  $_" -ForegroundColor White }

Write-Host ""
Write-Host "Directories:" -ForegroundColor Cyan
Get-ChildItem -Directory | ForEach-Object { 
    Write-Host "  $($_.Name)/" -ForegroundColor White
    $fileCount = (Get-ChildItem $_.FullName -File).Count
    Write-Host "    ($fileCount files)" -ForegroundColor Gray
}

