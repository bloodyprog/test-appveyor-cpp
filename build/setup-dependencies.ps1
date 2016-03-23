# setup-dependencies

$script_file = $MyInvocation.MyCommand.Path
$script_path = Split-Path $script_file

Push-Location $script_path
if (-not (Test-Path "dependencies")) { New-Item -ItemType directory "dependencies" }
Push-Location "dependencies"

function Download([string]$url, [string]$file)
{
    Write-Output "Download $file"
    $start_time = Get-Date
    Invoke-WebRequest -Uri $url -OutFile $file
    Write-Output "Download time : $((Get-Date).Subtract($start_time).Seconds) second(s)"
}

# setup premake

$premake_url  = "https://github.com/premake/premake-core/releases/download/v5.0.0-alpha8/premake-5.0.0-alpha8-windows.zip"
$premake_dir  = "premake"
$premake_file = "premake.zip"


if (-not (Test-Path $premake_file))
{
    Download $premake_url $premake_file
}

if (-not (Test-Path $premake_dir))
{
    7z x -r -opremake $premake_file
}

Pop-Location
Pop-Location
