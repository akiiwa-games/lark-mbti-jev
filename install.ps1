$ErrorActionPreference = 'Stop'
Set-Location -LiteralPath $PSScriptRoot
python -c "import sys; sys.exit(0 if sys.version_info >= (3, 11) else 1)"
if ($LASTEXITCODE -ne 0) { throw 'Python 3.11+ is required. Install it and make python available on PATH.' }
if (-not (Test-Path -LiteralPath (Join-Path $PSScriptRoot '.venv/Scripts/python.exe'))) {
    python -m venv .venv
    if ($LASTEXITCODE -ne 0) { throw 'Python 3.11+ is required.' }
}
& (Join-Path $PSScriptRoot '.venv/Scripts/python.exe') -c "import sys; sys.exit(0 if sys.version_info >= (3, 11) else 1)"
if ($LASTEXITCODE -ne 0) { throw 'The existing .venv needs Python 3.11+. Recreate it with a supported Python version.' }
& (Join-Path $PSScriptRoot '.venv/Scripts/python.exe') -m pip install -r requirements.txt
if ($LASTEXITCODE -ne 0) { throw 'Dependency installation failed.' }
Write-Output 'Ready. Double-click the VBS launcher in this folder.'
