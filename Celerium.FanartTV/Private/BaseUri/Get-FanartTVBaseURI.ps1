function Get-FanartTVBaseURI {
<#
    .SYNOPSIS
        Shows the FanartTV base URI

    .DESCRIPTION
        The Get-FanartTVBaseURI cmdlet shows the FanartTV
        base URI from the global variable

    .EXAMPLE
        Get-FanartTVBaseURI

        Shows the FanartTV base URI value defined in the global variable

    .NOTES
        N/A

    .LINK
        https://celerium.github.io/Celerium.FanartTV/site/Internal/Get-FanartTVBaseURI.html
#>

    [CmdletBinding(DefaultParameterSetName = 'Index')]
    Param ()

    begin {}

    process {

        switch ([bool]$FanartTVModuleBaseURI) {
            $true   { $FanartTVModuleBaseURI }
            $false  { Write-Warning "The FanartTV base URI is not set. Run Add-FanartTVBaseURI to set the base URI." }
        }

    }

    end {}

}