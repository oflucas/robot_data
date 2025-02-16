# powershell.exe -ExecutionPolicy Bypass -File

$base = $env:ROBOT_WORKSPACE
$data_repo = "robot"
$dist_repo = "dist_robot"
$dist_dir = Join-Path -Path $base -ChildPath $dist_repo

# Define the URL of the zip file and the target directory


$url = "https://raw.githubusercontent.com/oflucas/robot_data/robot_app.zip"
$targetDir = "xxx"
$zipFilePath = Join-Path -Path $targetDir -ChildPath "app.zip"
$extractPath = Join-Path -Path $targetDir -ChildPath "app"

# Create the target directory if it doesn't exist
if (-not (Test-Path -Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir | Out-Null
}

# Download the zip file
Invoke-WebRequest -Uri $url -OutFile $zipFilePath

# Check if the zip file was downloaded successfully
if (Test-Path -Path $zipFilePath) {
    # Remove the existing 'app' directory if it exists
    if (Test-Path -Path $extractPath) {
        Remove-Item -Path $extractPath -Recurse -Force
    }

    # Extract the zip file to the 'app' subdirectory
    Expand-Archive -Path $zipFilePath -DestinationPath $extractPath -Force

    # Optionally, remove the zip file after extraction
    Remove-Item -Path $zipFilePath -Force
} else {
    Write-Host "Failed to download the zip file."
}