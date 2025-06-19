# Advanced Shell Scripting - Pokemon API Tasks

This repository contains solutions for advanced shell scripting tasks involving the Pokemon API. The tasks demonstrate various shell scripting concepts including API automation, data extraction, batch processing, error handling, and parallel processing.

## Project Structure

```
Advanced_shell/
├── README.md
├── apiAutomation-0x00              # Bash version (Task 0)
├── apiAutomation-0x00.ps1          # PowerShell version (Task 0)
├── data_extraction_automation-0x01  # Bash version (Task 1)
├── data_extraction_automation-0x01.ps1  # PowerShell version (Task 1)
├── batchProcessing-0x02            # Bash version (Task 2)
├── batchProcessing-0x02.ps1        # PowerShell version (Task 2)
├── summaryData-0x03                # Bash version (Task 3)
├── summaryData-0x03.ps1            # PowerShell version (Task 3)
├── batchProcessing-0x04            # Bash version (Task 5)
├── batchProcessing-0x04.ps1        # PowerShell version (Task 5)
├── data.json                       # Pikachu data from Task 0
├── pokemon_data/                   # Directory with batch-fetched Pokemon data
├── pokemon_data_parallel/          # Directory for parallel processing output
└── pokemon_report.csv              # CSV report generated in Task 3
```

## Tasks Overview

### Task 0: API Request Automation
**File**: `apiAutomation-0x00` / `apiAutomation-0x00.ps1`

**Objective**: Automate the process of making API requests to the Pokémon API and save the results to a file.

**Features**:
- Fetches Pikachu data from `https://pokeapi.co/api/v2/pokemon/pikachu`
- Saves response to `data.json`
- Error handling with logging to `errors.txt`

**Usage**:
```bash
# Bash version
./apiAutomation-0x00

# PowerShell version
.\apiAutomation-0x00.ps1
```

### Task 1: Extract Pokémon Data
**File**: `data_extraction_automation-0x01` / `data_extraction_automation-0x01.ps1`

**Objective**: Use advanced text manipulation tools to extract specific data from the API response.

**Features**:
- Extracts name, height, weight, and type from JSON
- Formats output in human-readable format
- Uses jq, awk, sed (bash) or native PowerShell JSON parsing

**Output**: "Pikachu is of type Electric, weighs 6kg, and is 0.4m tall."

**Usage**:
```bash
# Bash version (requires jq)
./data_extraction_automation-0x01

# PowerShell version
.\data_extraction_automation-0x01.ps1
```

### Task 2: Batch Pokémon Data Retrieval
**File**: `batchProcessing-0x02` / `batchProcessing-0x02.ps1`

**Objective**: Automate the retrieval of data for multiple Pokémon and store in separate files.

**Features**:
- Fetches data for: Bulbasaur, Ivysaur, Venusaur, Charmander, Charmeleon
- Rate limiting with 1-second delay between requests
- Retry logic (up to 3 attempts per Pokemon)
- Error handling and logging
- Saves to `pokemon_data/` directory

**Usage**:
```bash
# Bash version
./batchProcessing-0x02

# PowerShell version
.\batchProcessing-0x02.ps1
```

### Task 3: Summarize Pokémon Data
**File**: `summaryData-0x03` / `summaryData-0x03.ps1`

**Objective**: Create a report that summarizes data for multiple Pokémon.

**Features**:
- Reads all JSON files from Task 2
- Generates CSV report with name, height, weight
- Calculates average height and weight using awk (bash) or PowerShell
- Outputs to `pokemon_report.csv`

**Sample Output**:
```
Name,Height (m),Weight (kg)
Bulbasaur,0.7,6.9
Charmander,0.6,8.5
Charmeleon,1.1,19.0
Ivysaur,1.0,13.0
Venusaur,2.0,100.0

Average Height: 1.08 m
Average Weight: 29.48 kg
```

**Usage**:
```bash
# Bash version
./summaryData-0x03

# PowerShell version
.\summaryData-0x03.ps1
```

### Task 4: Error Handling and Retry Logic
**Objective**: Add robust error handling and retry logic for API requests.

This functionality is already implemented in the `batchProcessing-0x02` script with:
- Up to 3 retry attempts per Pokemon
- Error logging to `errors.txt`
- Graceful handling of network issues
- Continuation processing even if some Pokemon fail

### Task 5: Parallel Data Fetching
**File**: `batchProcessing-0x04` / `batchProcessing-0x04.ps1`

**Objective**: Speed up data retrieval using parallel processing.

**Features**:
- Fetches multiple Pokemon data simultaneously
- Uses background processes (bash) or PowerShell jobs
- Proper process management and cleanup
- Waits for all processes to complete
- Summary reporting of successes/failures

**Usage**:
```bash
# Bash version
./batchProcessing-0x04

# PowerShell version
.\batchProcessing-0x04.ps1
```

## Requirements

### For Bash Scripts:
- `curl` - for making HTTP requests
- `jq` - for JSON parsing
- `awk` - for text processing
- `sed` - for text manipulation

### For PowerShell Scripts:
- PowerShell 5.1 or later
- Internet connection for API requests

## Installation and Setup

1. Clone the repository:
```bash
git clone <repository-url>
cd Advanced_shell
```

2. Make bash scripts executable (Unix/Linux):
```bash
chmod +x apiAutomation-0x00 data_extraction_automation-0x01 batchProcessing-0x02 summaryData-0x03 batchProcessing-0x04
```

3. Install dependencies (for bash scripts):
```bash
# Ubuntu/Debian
sudo apt-get install curl jq gawk sed

# macOS (with Homebrew)
brew install curl jq gawk gnu-sed
```

## Running the Complete Workflow

### Bash Version:
```bash
# Step 1: Fetch Pikachu data
./apiAutomation-0x00

# Step 2: Extract and display Pikachu info
./data_extraction_automation-0x01

# Step 3: Fetch multiple Pokemon data
./batchProcessing-0x02

# Step 4: Generate summary report
./summaryData-0x03

# Step 5: Fetch data in parallel
./batchProcessing-0x04
```

### PowerShell Version:
```powershell
# Step 1: Fetch Pikachu data
.\apiAutomation-0x00.ps1

# Step 2: Extract and display Pikachu info
.\data_extraction_automation-0x01.ps1

# Step 3: Fetch multiple Pokemon data
.\batchProcessing-0x02.ps1

# Step 4: Generate summary report
.\summaryData-0x03.ps1

# Step 5: Fetch data in parallel
.\batchProcessing-0x04.ps1
```

## Key Features Demonstrated

1. **API Integration**: Making HTTP requests to REST APIs
2. **JSON Processing**: Parsing and extracting data from JSON responses
3. **Error Handling**: Robust error handling with retry logic
4. **File I/O**: Reading from and writing to various file formats
5. **Text Processing**: Advanced text manipulation and formatting
6. **Batch Processing**: Handling multiple items with rate limiting
7. **Parallel Processing**: Concurrent execution for improved performance
8. **Data Aggregation**: Summarizing and calculating statistics
9. **Cross-platform Compatibility**: Both Bash and PowerShell implementations

## Pokemon API Reference

The scripts use the free Pokemon API (https://pokeapi.co/) which provides:
- No authentication required
- Rate limiting (be respectful)
- Comprehensive Pokemon data including stats, types, abilities, etc.

Example API endpoint: `https://pokeapi.co/api/v2/pokemon/pikachu`

## Troubleshooting

### Common Issues:

1. **Network Connectivity**: Ensure internet connection for API requests
2. **Rate Limiting**: The API may rate-limit requests; scripts include delays
3. **Dependencies**: Ensure jq, curl, awk are installed for bash scripts
4. **Permissions**: Make sure bash scripts are executable
5. **PowerShell Execution Policy**: May need to set execution policy for .ps1 files

### Error Logs:
- Check `errors.txt` for API request failures
- Check `errors_parallel.txt` for parallel processing issues

## Author

Created for ALX ProDev Advanced Shell Scripting project.

