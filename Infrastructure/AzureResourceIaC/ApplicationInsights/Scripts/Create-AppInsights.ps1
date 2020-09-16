<#
.SYNOPSIS
	This powershell script is going to deploy Application Insight.

.DESCRIPTION
    This script creates an App Insight by useing the ARM template.

.OUTPUTS
    Metadata Information

.EXAMPLE
    $Params = @{
        ResourceGroupName = "Test-RG1"
        AppInsightsName = "test-appIn"
        appInsightsType = "web"
    }

    Create-AppInsights.ps1 @Params
#>

[CmdletBinding()]
Param (
    [Parameter(Mandatory = $true)]
    [String] $ResourceGroupName,

    [Parameter(Mandatory = $true)]
    [String] $AppInsightsName,

    [Parameter(Mandatory = $false)]
    [ValidateSet('eastus2', 'westeurope', 'westus2')]
    [String] $Location,

    [Parameter(Mandatory = $true)]
    [ValidateSet('web', 'java', 'other')]
    [String] $AppInsightsType
)

Write-Verbose "Creating parameters object for ARM Template."
$ARMParams = @{
    appInsightsName               = $AppInsightsName
    location                      = $Location
    appInsightsType               = $AppInsightsType
}

$TemplateName = 'applicationInsights.json'

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