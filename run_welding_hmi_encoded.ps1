Write-Host "Current Directory: $(Get-Location)"
$base = $env:ROBOT_WORKSPACE
$dev_repo = "robot"
$dist = "dist_robot"
$exec_path = Join-Path -Path $base -ChildPath $dist
Write-Host $exec_path

Set-Location -Path $exec_path
Write-Host "cd Directory: $(Get-Location)"

# Force UTF-8 as default file encoding (Chinese Windows defaults to GBK).
$env:PYTHONUTF8 = "1"

python --version
python -m robot.welding_hmi
$name = Read-Host "Press Any Keys"