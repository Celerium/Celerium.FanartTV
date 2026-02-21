function Get-FanartTVModuleSettings {
<#
    .SYNOPSIS
        Gets the saved FanartTV configuration settings

    .DESCRIPTION
        The Get-FanartTVModuleSettings cmdlet gets the saved FanartTV configuration settings
        from the local system

        By default the configuration file is stored in the following location:
            $env:USERPROFILE\Celerium.FanartTV

    .PARAMETER FanartTVConfigPath
        Define the location to store the FanartTV configuration file

        By default the configuration file is stored in the following location:
            $env:USERPROFILE\Celerium.FanartTV

    .PARAMETER FanartTVConfigFile
        Define the name of the FanartTV configuration file

        By default the configuration file is named:
            config.psd1

    .PARAMETER OpenConfigFile
        Opens the FanartTV configuration file

    .EXAMPLE
        Get-FanartTVModuleSettings

        Gets the contents of the configuration file that was created with the
        Export-FanartTVModuleSettings

        The default location of the FanartTV configuration file is:
            $env:USERPROFILE\Celerium.FanartTV\config.psd1

    .EXAMPLE
        Get-FanartTVModuleSettings -FanartTVConfigPath C:\Celerium.FanartTV -FanartTVConfigFile MyConfig.psd1 -openConfFile

        Opens the configuration file from the defined location in the default editor

        The location of the FanartTV configuration file in this example is:
            C:\Celerium.FanartTV\MyConfig.psd1

    .NOTES
        N/A

    .LINK
        https://celerium.github.io/Celerium.FanartTV/site/Internal/Get-FanartTVModuleSettings.html
#>

    [CmdletBinding(DefaultParameterSetName = 'Index')]
    Param (
        [Parameter()]
        [string]$FanartTVConfigPath = $(Join-Path -Path $home -ChildPath $(if ($IsWindows -or $PSEdition -eq 'Desktop') {"Celerium.FanartTV"}else{".Celerium.FanartTV"}) ),

        [Parameter()]
        [string]$FanartTVConfigFile = 'config.psd1',

        [Parameter()]
        [switch]$OpenConfigFile
    )

    begin {
        $FanartTVConfig = Join-Path -Path $FanartTVConfigPath -ChildPath $FanartTVConfigFile
    }

    process {

        if (Test-Path -Path $FanartTVConfig) {

            if($OpenConfigFile) {
                Invoke-Item -Path $FanartTVConfig
            }
            else{
                Import-LocalizedData -BaseDirectory $FanartTVConfigPath -FileName $FanartTVConfigFile
            }

        }
        else{
            Write-Verbose "No configuration file found at [ $FanartTVConfig ]"
        }

    }

    end {}

}