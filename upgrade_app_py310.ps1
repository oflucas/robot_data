# powershell.exe -ExecutionPolicy Bypass -File

$base = $env:ROBOT_WORKSPACE
$data_repo = "robot_data"
$dist_repo = "dist_robot_py310"
$data_dir = Join-Path -Path $base -ChildPath $data_repo
$dist_dir = Join-Path -Path $base -ChildPath $dist_repo

# Define the URL of the zip file and the target directory
$url = "https://raw.githubusercontent.com/oflucas/robot_data/main/dist_robot_py310.zip"
$zipFilePath = Join-Path -Path $data_dir -ChildPath "dist_robot_py310.zip"

# Download the zip file
if (Test-Path -Path $zipFilePath) {
    Remove-Item -Path $zipFilePath -Recurse -Force
}
Invoke-WebRequest -Uri $url -OutFile $zipFilePath

# Check if the zip file was downloaded successfully
if (Test-Path -Path $zipFilePath) {
    # Remove the existing directory if it exists
    if (Test-Path -Path $dist_dir) {
        Remove-Item -Path $dist_dir -Recurse -Force
    }

    # Extract the zip file
    Expand-Archive -Path $zipFilePath -DestinationPath $base -Force

    # Optionally, remove the zip file after extraction
    # Remove-Item -Path $zipFilePath -Force
} else {
    Write-Host "Failed to download the zip file."
}

$name = Read-Host "Press Any Keys"