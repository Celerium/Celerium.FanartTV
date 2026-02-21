function Remove-FanartTVBaseURI {
<#
    .SYNOPSIS
        Removes the FanartTV base URI global variable

    .DESCRIPTION
        The Remove-FanartTVBaseURI cmdlet removes the FanartTV
        base URI from the global variable

    .EXAMPLE
        Remove-FanartTVBaseURI

        Removes the FanartTV base URI value from the global variable

    .NOTES
        N/A

    .LINK
        https://celerium.github.io/Celerium.FanartTV/site/Internal/Remove-FanartTVBaseURI.html
#>

    [CmdletBinding(DefaultParameterSetName = 'Destroy', SupportsShouldProcess, ConfirmImpact = 'None')]
    Param ()

    begin {}

    process {

        switch ([bool]$FanartTVModuleBaseURI) {

            $true   {
                if ($PSCmdlet.ShouldProcess('FanartTVModuleBaseURI')) {
                    Remove-Variable -Name "FanartTVModuleBaseURI" -Scope Global -Force
                }
            }
            $false  { Write-Warning "The FanartTV base URI variable is not set. Nothing to remove" }

        }

    }

    end {}

}