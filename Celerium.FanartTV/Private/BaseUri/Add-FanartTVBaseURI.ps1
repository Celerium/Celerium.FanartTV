function Add-FanartTVBaseURI {
<#
    .SYNOPSIS
        Sets the base URI for the FanartTV API connection

    .DESCRIPTION
        The Add-FanartTVBaseURI cmdlet sets the base URI which is used
        to construct the full URI for all API calls

    .PARAMETER BaseUri
        Sets the base URI for the FanartTV API connection. Helpful
        if using a custom API gateway

        The default value is 'https://webservice.fanart.tv'

    .PARAMETER Version
        Sets API to use

        Note: Module was built and tested on v3.2 only

        The default value is 'v3.2'

    .EXAMPLE
        Add-FanartTVBaseURI

        The base URI will use https://webservice.fanart.tv/v3.2

    .EXAMPLE
        Add-FanartTVBaseURI -BaseUri 'https://gateway.celerium.org'

        The base URI will use https://gateway.celerium.org/v3.2

    .EXAMPLE
        'https://gateway.celerium.org' | Add-FanartTVBaseURI

        The base URI will use https://gateway.celerium.org/v3.2

    .NOTES
        N/A

    .LINK
        https://celerium.github.io/Celerium.FanartTV/site/Internal/Add-FanartTVBaseURI.html

    .LINK
        https://api.fanart.tv/#section/Fanart.tv-API-Documentation
#>

    [CmdletBinding(DefaultParameterSetName = 'Set')]
    [Alias('Set-FanartTVBaseURI')]
    Param (
        [parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [string]$BaseUri = 'https://webservice.fanart.tv',

        [parameter(Mandatory = $false)]
        [AllowNull()]
        [string]$Version = 'v3.2'
    )

    process{

        if($BaseUri[$BaseUri.Length-1] -eq "/") {
            $BaseUri = $BaseUri.Substring(0,$BaseUri.Length-1)
        }

        if ($Version.StartsWith('/')) { $Version = $Version.Substring(1) }
        if ($Version.EndsWith('/'))   { $Version = $Version.Substring(0, $Version.Length - 1) }

        Set-Variable -Name "FanartTVModuleBaseURI" -Value "$BaseUri/$Version" -Option ReadOnly -Scope Global -Force

    }

}