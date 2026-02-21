function Import-FanartTVModuleSettings {
<#
    .SYNOPSIS
        Imports the FanartTV BaseURI, API, & JSON configuration information to the current session

    .DESCRIPTION
        The Import-FanartTVModuleSettings cmdlet imports the FanartTV BaseURI, API, & JSON configuration
        information stored in the FanartTV configuration file to the users current session

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

    .EXAMPLE
        Import-FanartTVModuleSettings

        Validates that the configuration file created with the Export-FanartTVModuleSettings cmdlet exists
        then imports the stored data into the current users session

        The default location of the FanartTV configuration file is:
            $env:USERPROFILE\Celerium.FanartTV\config.psd1

    .EXAMPLE
        Import-FanartTVModuleSettings -FanartTVConfigPath C:\Celerium.FanartTV -FanartTVConfigFile MyConfig.psd1

        Validates that the configuration file created with the Export-FanartTVModuleSettings cmdlet exists
        then imports the stored data into the current users session

        The location of the FanartTV configuration file in this example is:
            C:\Celerium.FanartTV\MyConfig.psd1

    .NOTES
        N/A

    .LINK
        https://celerium.github.io/Celerium.FanartTV/site/Internal/Import-FanartTVModuleSettings.html
#>

    [CmdletBinding(DefaultParameterSetName = 'Set')]
    Param (
        [Parameter()]
        [string]$FanartTVConfigPath = $(Join-Path -Path $home -ChildPath $(if ($IsWindows -or $PSEdition -eq 'Desktop') {"Celerium.FanartTV"}else{".Celerium.FanartTV"}) ),

        [Parameter()]
        [string]$FanartTVConfigFile = 'config.psd1'
    )

    begin {
        $FanartTVConfig = Join-Path -Path $FanartTVConfigPath -ChildPath $FanartTVConfigFile

        $ModuleVersion = $MyInvocation.MyCommand.Version.ToString()

        switch ($PSVersionTable.PSEdition){
            'Core'      { $UserAgent = "Celerium.FanartTV/$ModuleVersion - PowerShell/$($PSVersionTable.PSVersion) ($($PSVersionTable.Platform) $($PSVersionTable.OS))" }
            'Desktop'   { $UserAgent = "Celerium.FanartTV/$ModuleVersion - WindowsPowerShell/$($PSVersionTable.PSVersion) ($($PSVersionTable.BuildVersion))" }
            default     { $UserAgent = "Celerium.FanartTV/$ModuleVersion - $([Microsoft.PowerShell.Commands.PSUserAgent].GetMembers('Static, NonPublic').Where{$_.Name -eq 'UserAgent'}.GetValue($null,$null))" }
        }

    }

    process {

        if (Test-Path $FanartTVConfig) {
            $TempConfig = Import-LocalizedData -BaseDirectory $FanartTVConfigPath -FileName $FanartTVConfigFile

            # Send to function to strip potentially superfluous slash (/)
            Add-FanartTVBaseURI $TempConfig.FanartTVModuleBaseURI

            if ($TempConfig.FanartTVModulePersonalApiKey -or $TempConfig.FanartTVModulePersonalApiKey){
                if ($TempConfig.FanartTVModulePersonalApiKey)   { $TempConfig.FanartTVModulePersonalApiKey  = ConvertTo-SecureString $TempConfig.FanartTVModulePersonalApiKey}
                if ($TempConfig.FanartTVModuleProjectApiKey)    { $TempConfig.FanartTVModuleProjectApiKey   = ConvertTo-SecureString $TempConfig.FanartTVModuleProjectApiKey}
            }

            Set-Variable -Name "FanartTVModulePersonalApiKey" -Value $TempConfig.FanartTVModulePersonalApiKey -Option ReadOnly -Scope Global -Force
            Set-Variable -Name "FanartTVModuleProjectApiKey" -Value $TempConfig.FanartTVModuleProjectApiKey -Option ReadOnly -Scope Global -Force
            Set-Variable -Name "FanartTVModuleUserAgent" -Value $TempConfig.FanartTVModuleUserAgent -Option ReadOnly -Scope Global -Force
            Set-Variable -Name "FanartTVModuleJSONConversionDepth" -Value $TempConfig.FanartTVModuleJSONConversionDepth  -Option ReadOnly -Scope Global -Force

            Write-Verbose "Celerium.FanartTV Module configuration loaded successfully from [ $FanartTVConfig ]"

            # Clean things up
            Remove-Variable "TempConfig"
        }
        else {
            Write-Verbose "No configuration file found at [ $FanartTVConfig ] run Add-FanartTVAPIKey to get started."

            Add-FanartTVBaseURI

            Set-Variable -Name "FanartTVModuleBaseURI" -Value $(Get-FanartTVBaseURI) -Option ReadOnly -Scope Global -Force
            Set-Variable -Name "FanartTVModuleUserAgent" -Value $UserAgent -Option ReadOnly -Scope Global -Force
            Set-Variable -Name "FanartTVModuleJSONConversionDepth" -Value 100 -Option ReadOnly -Scope Global -Force
        }

    }

    end {}

}