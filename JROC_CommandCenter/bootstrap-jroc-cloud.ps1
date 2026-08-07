run it in a Windows terminal (pwsh or PowerShell).

powershell
<# 
    JROC OS Cloud Edition Bootstrap Script (Windows)
    File: bootstrap-jroc-cloud.ps1
#>

param(
    [string]$RepoUrl = "https://github.com/your-org/jroc-os.git",
    [string]$InstallDir = "$env:USERPROFILE\jroc-os",
    [string]$ClusterName = "cloud-dev-cluster",
    [string]$Region = "us-east",
    [string]$Plan = "free"
)

Write-Host "=== JROC OS Cloud Edition Bootstrap (Windows) ===" -ForegroundColor Cyan

# 1. Check for Git
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "[!] Git not found. Please install Git for Windows and re-run." -ForegroundColor Red
    exit 1
}

# 2. Check for Node.js
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "[!] Node.js not found. Please install Node.js (LTS) and re-run." -ForegroundColor Red
    exit 1
}

# 3. Create install directory
Write-Host "[*] Using install directory: $InstallDir" -ForegroundColor Yellow
if (-not (Test-Path $InstallDir)) {
    New-Item -ItemType Directory -Path $InstallDir | Out-Null
}

# 4. Clone repo (if not already)
if (-not (Test-Path (Join-Path $InstallDir ".git"))) {
    Write-Host "[*] Cloning JROC OS repo from $RepoUrl ..." -ForegroundColor Yellow
    git clone $RepoUrl $InstallDir
} else {
    Write-Host "[*] Repo already present, pulling latest..." -ForegroundColor Yellow
    Set-Location $InstallDir
    git pull
}

Set-Location $InstallDir

# 5. Install dependencies (assuming root package.json)
if (Test-Path "package.json") {
    Write-Host "[*] Installing Node dependencies..." -ForegroundColor Yellow
    npm install
}

# 6. Create Cloud Edition config
$cloudConfigDir = Join-Path $InstallDir "config"
if (-not (Test-Path $cloudConfigDir)) {
    New-Item -ItemType Directory -Path $cloudConfigDir | Out-Null
}

$cloudConfigFile = Join-Path $cloudConfigDir "cloud-edition.json"

$cloudConfig = @{
    edition      = "cloud"
    region       = $Region
    plan         = $Plan
    cluster_name = $ClusterName
    api_base     = "https://api.jroc-cloud.local/$Region/$ClusterName"
    dashboard    = "https://dashboard.jroc-cloud.local/$Region/$ClusterName"
    cli_profile  = "jroc-cloud-$ClusterName"
}

$cloudConfig | ConvertTo-Json -Depth 5 | Set-Content -Path $cloudConfigFile -Encoding UTF8

Write-Host "[*] Cloud Edition config written to: $cloudConfigFile" -ForegroundColor Green

# 7. Generate CLI profile (simple JSON)
$cliDir = Join-Path $InstallDir "cli"
if (-not (Test-Path $cliDir)) {
    New-Item -ItemType Directory -Path $cliDir | Out-Null
}

$cliProfileFile = Join-Path $cliDir "profile-$ClusterName.json"

$cliProfile = @{
    profile_name = "jroc-cloud-$ClusterName"
    api_base     = $cloudConfig.api_base
    region       = $Region
    cluster      = $ClusterName
    auth         = @{
        mode = "token"
        token = "REPLACE_WITH_REAL_TOKEN"
    }
}

$cliProfile | ConvertTo-Json -Depth 5 | Set-Content -Path $cliProfileFile -Encoding UTF8

Write-Host "[*] CLI profile written to: $cliProfileFile" -ForegroundColor Green

# 8. Run initial health check (assuming a script exists)
if (Test-Path "scripts/health-check-cloud.js") {
    Write-Host "[*] Running Cloud Edition health check..." -ForegroundColor Yellow
    node scripts/health-check-cloud.js --config "$cloudConfigFile"
} else {
    Write-Host "[!] No health-check script found (scripts/health-check-cloud.js)." -ForegroundColor DarkYellow
    Write-Host "    You can add one to validate mesh engines, control plane, etc."
}

Write-Host "=== JROC OS Cloud Edition Bootstrap Complete ===" -ForegroundColor Cyan
Write-Host "Cluster: $ClusterName"
Write-Host "Region:  $Region"
Write-Host "Plan:    $Plan"
Write-Host "API:     $($cloudConfig.api_base)"
Write-Host "Dashboard: $($cloudConfig.dashboard)"
Write-Host ""
Write-Host "Next steps:"
Write-Host "  - Wire your Cloud Edition control plane to use config/cloud-edition.json"
Write-Host "  - Point your CLI to cli/profile-$ClusterName.json"
Write-Host "  - Implement scripts/health-check-cloud.js for real checks"