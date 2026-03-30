# Set the execution policy to Bypass for the current session
Set-ExecutionPolicy Bypass -Scope Process -Force

# Set the execution policy to allow script execution
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Function to display success messages
function Display-Installation {
    param (
        [string]$appName,
        [string]$version
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $message = "$timestamp - Installation successful: $appName - Version: $version"
    Write-Host $message
}

# Install Azure CLI
Write-Host "Downloading and installing Azure CLI..."
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile C:\AzureCLI.msi
Start-Process msiexec.exe -Wait -ArgumentList '/I C:\AzureCLI.msi /quiet'

# Azure CLI version
$azureCliVersion = az version | ConvertTo-Json
Display-Installation -appName "Azure CLI" -version $azureCliVersion

# Install kubectl
Write-Host "Installing kubectl..."
choco install -y kubernetes-cli

# Kubectl version
$kubectlVersion = kubectl version --client --output=json | ConvertFrom-Json | Select-Object -ExpandProperty clientVersion | Select-Object -ExpandProperty gitVersion
Display-Installation -appName "kubectl" -version $kubectlVersion

# Install git
Write-Host "Installing Git..."
choco install -y git.install 

# Git version
$gitVersion = git --version | ForEach-Object { $_.Split()[2] }
Display-Installation -appName "Git" -version $gitVersion

# Install helm
Write-Host "Installing Helm..."
choco install -y kubernetes-helm

# Helm version
$helmVersion = helm version | ForEach-Object { $_.Split(":")[1].Trim() }
Display-Installation -appName "Helm" -version $helmVersion

# Install vscode
Write-Host "Installing Visual Studio Code..."
choco install -y vscode

# Vscode version
$vscodeVersion = code --version
Display-Installation -appName "Visual Studio Code" -version $vscodeVersion
