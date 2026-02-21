# Example PowerShell helper to upscale the generated PNG to 8K with real-esrgan-ncnn-vulkan
# EDIT the path to your real-esrgan executable below before running.

$exe = 'C:\tools\real-esrgan-ncnn-vulkan\real-esrgan-ncnn-vulkan.exe'  # <- update this path
$input = Join-Path $PSScriptRoot 'vortex_3840x2160_v1.png'
$output = Join-Path $PSScriptRoot 'vortex_7680x4320_upscaled.png'

if (-not (Test-Path $exe)) { Write-Error "Real-ESRGAN exe not found at $exe. Edit this script to point to your executable."; exit 1 }
if (-not (Test-Path $input)) { Write-Error "Input file not found: $input. Run run_generate.ps1 first."; exit 2 }

Write-Host "Upscaling $input -> $output using real-esrgan (2x)..."
& $exe -i $input -o $output -s 2

if (Test-Path $output) { Write-Host "Upscale complete: $output" } else { Write-Error "Upscale failed or output not found." }
