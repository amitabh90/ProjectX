<#
.SYNOPSIS
	This powershell script is going to deploy Vnet with subnets.

.DESCRIPTION
    This script creates an Vnet by useing the ARM template.

.OUTPUTS
    Metadata Information

.EXAMPLE
    $Params = @{
        ResourceGroupName = "Test-RG1"
        vNetName = "demovnet"
    }

    Create-VirtualNetwork.ps1 @Params
#>

[CmdletBinding()]
Param (
    [Parameter(Mandatory = $true)]
    [String] $ResourceGroupName,

    [Parameter(Mandatory = $true)]
    [String] $VNetName,

    [Parameter(Mandatory = $false)]
    [String] $Location

)

Write-Verbose "Creating parameters object for ARM Template."
$ARMParams = @{
    vNetName                      = $VNetName
    location                        = $Location
}

$TemplateName = 'virtualNetwork.json'

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