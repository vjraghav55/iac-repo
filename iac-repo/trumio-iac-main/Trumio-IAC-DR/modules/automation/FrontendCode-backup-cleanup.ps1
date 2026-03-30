# Install Azure PowerShell module if not already installed
# Install-Module -Name Az -AllowClobber -Scope CurrentUser

# Connect to Azure account
Connect-AzAccount -Identity

# Set variables
$resourceGroupName = "azusctr-rg"
$storageAccountName = "azusctrwebsa"
$containerName = "prod-frontend-backup"
$folderName = "frontend-"

# Get storage account context
$storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName
$ctx = $storageAccount.Context

# Get the list of files and folders in the container
$files = Get-AzStorageBlob -Context $ctx -Container $containerName -Prefix $folderName -ErrorAction Stop

# Sort files by last modified time
$sortedFiles = $files | Sort-Object LastModified -Descending

# Keep the last two files, delete the rest
$filesToDelete = $sortedFiles[2..($sortedFiles.Count - 1)]

# Loop through each file/folder and delete them
foreach ($file in $filesToDelete) {
    Remove-AzStorageBlob -Context $ctx -Container $containerName -Blob $file.Name -Force
}