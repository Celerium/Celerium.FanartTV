function Remove-FanartTVAPIKey {
<#
    .SYNOPSIS
        Removes the FanartTV API key

    .DESCRIPTION
        The Remove-FanartTVAPIKey cmdlet removes the FanartTV
        API key(s) from global variables0

    .EXAMPLE
        Remove-FanartTVAPIKey

        Removes the FanartTV API key global variables

    .NOTES
        N/A

    .LINK
        https://celerium.github.io/Celerium.FanartTV/site/Internal/Remove-FanartTVAPIKey.html
#>

    [CmdletBinding(DefaultParameterSetName = 'Destroy', SupportsShouldProcess, ConfirmImpact = 'None')]
    Param ()

    begin {}

    process {

        if ($FanartTVModulePersonalApiKey -or $FanartTVModuleProjectApiKey) {

            if ($PSCmdlet.ShouldProcess('FanartTVModulePersonalApiKey')) {
                Remove-Variable -Name "FanartTVModulePersonalApiKey" -Scope Global -Force
            }

            if ($PSCmdlet.ShouldProcess('FanartTVModuleProjectApiKey')) {
                Remove-Variable -Name "FanartTVModuleProjectApiKey" -Scope Global -Force
            }

        }
        else { Write-Warning "The FanartTV API keys are not set. Nothing to remove" }

    }

    end {}

}