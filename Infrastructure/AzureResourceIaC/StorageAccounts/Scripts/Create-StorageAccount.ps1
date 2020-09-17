<#
.SYNOPSIS
	This powershell script is going to deploy Storage Account.

.DESCRIPTION
    This script creates an Storage Account by useing the ARM template.

.OUTPUTS
    Metadata Information

.EXAMPLE
    $Params = @{
        ResourceGroupName = "Test-RG1"
        StorageAccountName = "demoAPP"
        StorageAccountKind = "StorageV2"
        StorageAccountSku = "Standard_GRS"
    }

    Create-StorageAccount.ps1 @Params
#>

[CmdletBinding()]
Param (
    [Parameter(Mandatory = $true)]
    [String] $ResourceGroupName,

    [Parameter(Mandatory = $true)]
    [String] $StorageAccountName,

    [Parameter(Mandatory = $false)]
    [ValidateSet('eastus2', 'westeurope', 'westus2')]
    [String] $Location,

    [Parameter(Mandatory = $true)]
    [ValidateSet("Storage","StorageV2","BlobStorage", "FileStorage","BlockBlobStorage")]
    [String] $StorageAccountKind,

    [Parameter(Mandatory = $true)]
    [ValidateSet("Standard_LRS","Standard_GRS","Standard_RAGRS","Standard_ZRS","Premium_LRS", "Premium_ZRS", "Standard_GZRS", "Standard_RAGZRS")]
    [String] $StorageAccountSku,

    [Parameter(Mandatory = $true)]
    [String] $VNetName,

    [Parameter(Mandatory = $true)]
    [String] $SubnetName

)

Write-Verbose "Creating parameters object for ARM Template."
$ARMParams = @{
    storageAccountName          = $StorageAccountName
    location                    = $Location
    storageAccountKind          = $StorageAccountKind
    storageAccountSku           = $StorageAccountSku
    vNetName                    = $VNetName
    SubnetName                  = $SubnetName
}

$TemplateName = 'storageAccount.json'

$TemplateFile = Join-Path -Path $PSScriptRoot -ChildPath "..\Templates\$TemplateName"

Write-Host "Deploying ARM Template.. "
$DeploymentName = (Get-ChildItem -Path $TemplateFile).BaseName + "-" + ((Get-Date).ToUniversalTime()).ToString("MMdd-HHmm")
$DeploymentParams = @{
    Name                    = $DeploymentName
    ResourceGroupName       = $ResourceGroupName
    TemplateFile            = $TemplateFile
    TemplateParameterObject = $ARMParams
    Force                   = $true
    ErrorVariable           = "ErrorMessages"
    ErrorAction             = "SilentlyContinue"
}

$Result = New-AzResourceGroupDeployment @DeploymentParams

If ($ErrorMessages) {
    Throw "Template deployment returned the following errors: $ErrorMessages"
}
else {
    Write-Verbose "Storage Account successfully created."
    Write-Output $($Result.OutputsString)
}