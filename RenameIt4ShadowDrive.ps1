# Define the starting folder path
$folderPath = "C:\Users\myuserfoldere\ShadowDrive"

# Define the error log file path
$errorLogPath = "C:\Users\myuserfoldere\error_log.txt"

# Check if the error log file exists, if not, create it
if (-Not (Test-Path -Path $errorLogPath)) {
    New-Item -Path $errorLogPath -ItemType File
} else {
    Clear-Content -Path $errorLogPath
}

# Function to get all files while handling errors
function Get-AllFiles($path) {
    $items = @()
    try {
        $items = Get-ChildItem -Path $path -Recurse -File -ErrorAction Stop
    } catch {
        $errorMessage = "Error accessing directory: $path -> $_"
        Write-Output $errorMessage
        Add-Content -Path $errorLogPath -Value $errorMessage
    }
    return $items
}

# Retrieve all files in the folder and subfolders
$files = Get-AllFiles -path $folderPath

foreach ($file in $files) {
    # Check that the file is not null and the full path is valid
    if ($null -ne $file -and $null -ne $file.FullName -and [System.IO.File]::Exists($file.FullName)) {
        try {
            # Get the full path of the file
            $fullPath = $file.FullName

            # Replace invalid characters with '-'
            $newName = $file.Name -replace '[\|\:\*\&\?,;\/\\~<>]', '-'

            # Create the new full path
            $newFullPath = Join-Path -Path $file.DirectoryName -ChildPath $newName

            # Check if the new full path is different from the old one
            if ($fullPath -ne $newFullPath) {
                try {
                    # Rename the file
                    Rename-Item -Path $fullPath -NewName $newName -ErrorAction Stop
                    Write-Output "Renamed: $fullPath -> $newFullPath"
                } catch {
                    $errorMessage = "Failed to rename: $fullPath -> $_"
                    Write-Output $errorMessage
                    Add-Content -Path $errorLogPath -Value $errorMessage
                }
            }
        } catch {
            $errorMessage = "Error processing file: $($file.FullName) -> $_"
            Write-Output $errorMessage
            Add-Content -Path $errorLogPath -Value $errorMessage
        }
    } else {
        $errorMessage = "Invalid file or path: $($file.FullName)"
        Write-Output $errorMessage
        Add-Content -Path $errorLogPath -Value $errorMessage
    }
}

Write-Output "Renaming complete."
