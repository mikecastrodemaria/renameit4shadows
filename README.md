# RenameIt4ShadowsDrive a PowerShell Script for Bulk Renaming Files

This PowerShell script recursively reads all files in a specified folder and its subfolders, replacing invalid characters in the filenames with a hyphen (`-`). The script also logs any errors encountered during the process.

## Features

- Recursively searches through directories.
- Replaces the following invalid characters in filenames: `|`, `:`, `*`, `&`, `?`, `,`, `;`, `/`, `\`, `~`, `<`, `>`.
- Logs any errors encountered during the renaming process to a specified log file.

## Prerequisites

- PowerShell 5.0 or higher
- Permissions to read and write in the specified directories and log file location

## Usage

1. **Set the starting folder path and log file path:**

   Modify the `$folderPath` and `$errorLogPath` variables in the script to point to your desired directory and log file location.

   ```powershell
   # Define the starting folder path
   $folderPath = "C:\Users\myhomepath\ShadowDrive"

   # Define the error log file path
   $errorLogPath = "C:\Users\myhomepath\error_log.txt"
   ```

2. **Run the script:**

   Open PowerShell and run the script:

   ```powershell
   .\path\to\your\script.ps1
   ```

3. **Check the log file:**

   If there are any errors during the renaming process, they will be logged in the specified log file. Check this file to see which files encountered issues.


## Error Handling

The script includes comprehensive error handling to ensure that:
- Errors accessing directories are logged.
- Null or invalid file paths are handled gracefully.
- Errors during the renaming process are logged with detailed messages.

All error messages are appended to the specified log file (`$errorLogPath`).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
