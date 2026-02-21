function Export-FanartTVModuleSettings {
<#
    .SYNOPSIS
        Exports the FanartTV BaseURI, API, & JSON configuration information to file

    .DESCRIPTION
        The Export-FanartTVModuleSettings cmdlet exports the FanartTV BaseURI, API, & JSON configuration information to file

        Making use of PowerShell's System.Security.SecureString type, exporting module settings encrypts your API key in a format
        that can only be unencrypted with the your Windows account as this encryption is tied to your user principal
        This means that you cannot copy your configuration file to another computer or user account and expect it to work

    .PARAMETER FanartTVConfigPath
        Define the location to store the FanartTV configuration file

        By default the configuration file is stored in the following location:
            $env:USERPROFILE\Celerium.FanartTV

    .PARAMETER FanartTVConfigFile
        Define the name of the FanartTV configuration file

        By default the configuration file is named:
            config.psd1

    .EXAMPLE
        Export-FanartTVModuleSettings

        Validates that the BaseURI, API, and JSON depth are set then exports their values
        to the current user's FanartTV configuration file located at:
            $env:USERPROFILE\Celerium.FanartTV\config.psd1

    .EXAMPLE
        Export-FanartTVModuleSettings -FanartTVConfigPath C:\Celerium.FanartTV -FanartTVConfigFile MyConfig.psd1

        Validates that the BaseURI, API, and JSON depth are set then exports their values
        to the current user's FanartTV configuration file located at:
            C:\Celerium.FanartTV\MyConfig.psd1

    .NOTES
        N/A

    .LINK
        https://celerium.github.io/Celerium.FanartTV/site/Internal/Export-FanartTVModuleSettings.html
#>

    [CmdletBinding(DefaultParameterSetName = 'Set')]
    Param (
        [Parameter()]
        [string]$FanartTVConfigPath = $(Join-Path -Path $home -ChildPath $(if ($IsWindows -or $PSEdition -eq 'Desktop') {"Celerium.FanartTV"}else{".Celerium.FanartTV"}) ),

        [Parameter()]
        [string]$FanartTVConfigFile = 'config.psd1'
    )

    begin {}

    process {

        Write-Warning "Secrets are stored using Windows Data Protection API (DPAPI)"
        Write-Warning "DPAPI provides user context encryption in Windows but NOT in other operating systems like Linux or UNIX. It is recommended to use a more secure & cross-platform storage method"

        $FanartTVConfig = Join-Path -Path $FanartTVConfigPath -ChildPath $FanartTVConfigFile

        # Confirm variables exist and are not null before exporting
        if ($FanartTVModuleBaseURI -and $FanartTVModuleJSONConversionDepth) {

            if ($FanartTVModulePersonalApiKey -or $FanartTVModuleProjectApiKey) {
                if ($FanartTVModulePersonalApiKey) { $SecurePersonalString  = $FanartTVModulePersonalApiKey | ConvertFrom-SecureString }
                if ($FanartTVModuleProjectApiKey)  { $SecureProjectString   = $FanartTVModuleProjectApiKey | ConvertFrom-SecureString }
            }

            if ($IsWindows -or $PSEdition -eq 'Desktop') {
                New-Item -Path $FanartTVConfigPath -ItemType Directory -Force | ForEach-Object { $_.Attributes = $_.Attributes -bor "Hidden" }
            }
            else{
                New-Item -Path $FanartTVConfigPath -ItemType Directory -Force
            }
@"
    @{
        FanartTVModuleBaseURI             = '$FanartTVModuleBaseURI'
        FanartTVModulePersonalApiKey      = '$SecurePersonalString'
        FanartTVModuleProjectApiKey       = '$SecureProjectString'
        FanartTVModuleJSONConversionDepth = '$FanartTVModuleJSONConversionDepth'
        FanartTVModuleUserAgent           = '$FanartTVModuleUserAgent'
    }
"@ | Out-File -FilePath $FanartTVConfig -Force
        }
        else {
            Write-Error "Failed to export FanartTV Module settings to [ $FanartTVConfig ]"
            Write-Error $_
            exit 1
        }

    }

    end {}

}