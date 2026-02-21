# PowerShell script to POST sd_payload_4k.json to AUTOMATIC1111 WebUI API and save first image
# Usage: Open PowerShell, ensure WebUI is running at http://127.0.0.1:7860, then run:
#   .\run_generate.ps1

$payloadPath = Join-Path $PSScriptRoot 'sd_payload_4k.json'
if (-not (Test-Path $payloadPath)) { Write-Error "Payload not found: $payloadPath"; exit 1 }
$payload = Get-Content $payloadPath -Raw

$uri = 'http://127.0.0.1:7860/sdapi/v1/txt2img'
Write-Host "Posting to $uri..."
try {
    $response = Invoke-RestMethod -Method Post -ContentType 'application/json' -Body $payload -Uri $uri -ErrorAction Stop
} catch {
    Write-Error "API request failed: $_"
    exit 2
}

if ($null -eq $response.images -or $response.images.Count -eq 0) { Write-Error 'No images returned by API.'; exit 3 }

# Save first image returned (base64)
$outName = Join-Path $PSScriptRoot 'vortex_3840x2160_v1.png'
[IO.File]::WriteAllBytes($outName, [Convert]::FromBase64String($response.images[0]))
Write-Host "Saved image to: $outName"

# If WebUI saved files to disk and returned filenames instead, check response.info or outputs folder.
