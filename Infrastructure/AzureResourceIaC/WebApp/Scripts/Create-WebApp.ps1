<#
.SYNOPSIS
	This powershell script is going to deploy Web App.

.DESCRIPTION
    This script creates an Web App by useing the ARM template.

.OUTPUTS
    Metadata Information

.EXAMPLE
    $Params = @{
        ResourceGroupName = "Test-RG1"
        webAppName = "demoAPP"
        appServicePlanSku = "Shared"
        appServicePlanSkuCode = "S2"
        httpsOnly = "true"
    }

    Create-AppInsights.ps1 @Params
#>

[CmdletBinding()]
Param (
    [Parameter(Mandatory = $true)]
    [String] $ResourceGroupName,

    [Parameter(Mandatory = $true)]
    [String] $WebAppName,

    [Parameter(Mandatory = $false)]
    [ValidateSet('eastus2', 'westeurope', 'westus2')]
    [String] $Location,

    [Parameter(Mandatory = $true)]
    [ValidateSet('Free', 'Shared', 'Basic', 'Standard', 'Premium', 'Dynamic')]
    [String] $AppServicePlanSku,

    [Parameter(Mandatory = $true)]
    [ValidateSet("F1", "D1", "B1", "B2", "B3",  "S1",  "S2",  "S3",  "P1", "P2",  "P3",  "P1V2", "P2V2", "P3V2", "Y1")]
    [String] $AppServicePlanSkuCode

)

Write-Verbose "Creating parameters object for ARM Template."
$ARMParams = @{
    webAppName                      = $WebAppName
    location                        = $Location
    appServicePlanSku               = $AppServicePlanSku
    appServicePlanSkuCode           = $AppServicePlanSkuCode
}

$TemplateName = 'webApp.json'

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
    Write-Verbose "ApplicationInsights successfully created."
    Write-Output $($Result.OutputsString)

}