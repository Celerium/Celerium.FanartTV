function Add-FanartTVAPIKey {
<#
    .SYNOPSIS
        Sets your API key used to authenticate all API calls

    .DESCRIPTION
        The Add-FanartTVAPIKey cmdlet sets your API key which is used to
        authenticate all API calls made to FanartTV

        Note: When both keys are provided, the personal key determines the
        access tier (2-day delay instead of 7-day). When both query parameter
        and header are present for the same key type, the query parameter takes priority

    .PARAMETER PersonalKey
        Plain text personal key

        If not defined the cmdlet will prompt you to enter it

    .PARAMETER ProjectKey
        Plain text project key

    .EXAMPLE
        Add-FanartTVAPIKey

        Prompts to enter in the personal API key which will be
        stored as a SecureString

    .EXAMPLE
        Add-FanartTVAPIKey -PersonalKey 123456 -ProjectKey 8765309

        Adds both project & personal keys which will be
        stored as a SecureString

    .NOTES
        N/A

    .LINK
        https://celerium.github.io/Celerium.FanartTV/site/Internal/Add-FanartTVAPIKey.html

    .LINK
        https://api.fanart.tv/#section/Fanart.tv-API-Documentation/Authentication
#>

    [CmdletBinding()]
    [Alias('Set-FanartTVAPIKey')]
    Param (
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [AllowEmptyString()]
        [string]$PersonalKey,

        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [AllowEmptyString()]
        [string]$ProjectKey
    )

    begin {}

    process{

        if (-not $PersonalKey -and -not $ProjectKey) {
            Write-Output "Please enter your personal API key:"
            $PersonalSecureString = Read-Host -AsSecureString
            Set-Variable -Name "FanartTVModulePersonalApiKey" -Value $PersonalSecureString -Option ReadOnly -Scope Global -Force
        }

        if ($PersonalKey -and -not $ProjectKey) {
            $PersonalSecureString = ConvertTo-SecureString $PersonalKey -AsPlainText -Force
            Set-Variable -Name "FanartTVModulePersonalApiKey" -Value $PersonalSecureString -Option ReadOnly -Scope Global -Force
        }

        if (-not $PersonalKey -and $ProjectKey) {
            $ProjectSecureString = ConvertTo-SecureString $ProjectKey -AsPlainText -Force
            Set-Variable -Name "FanartTVModuleProjectApiKey" -Value $ProjectSecureString -Option ReadOnly -Scope Global -Force
        }

        if ($PersonalKey -and $ProjectKey) {
            $PersonalSecureString   = ConvertTo-SecureString $PersonalKey -AsPlainText -Force
            $ProjectSecureString    = ConvertTo-SecureString $ProjectKey -AsPlainText -Force
            Set-Variable -Name "FanartTVModulePersonalApiKey" -Value $PersonalSecureString -Option ReadOnly -Scope Global -Force
            Set-Variable -Name "FanartTVModuleProjectApiKey" -Value $ProjectSecureString -Option ReadOnly -Scope Global -Force
        }

    }

    end {}

}