function Remove-FanartTVModuleSettings {
<#
    .SYNOPSIS
        Removes the stored FanartTV configuration folder

    .DESCRIPTION
        The Remove-FanartTVModuleSettings cmdlet removes the FanartTV folder and its files
        This cmdlet also has the option to remove sensitive FanartTV variables as well

        By default configuration files are stored in the following location and will be removed:
            $env:USERPROFILE\Celerium.FanartTV

    .PARAMETER FanartTVConfigPath
        Define the location of the FanartTV configuration folder

        By default the configuration folder is located at:
            $env:USERPROFILE\Celerium.FanartTV

    .PARAMETER AndVariables
        Define if sensitive FanartTV variables should be removed as well

        By default the variables are not removed

    .EXAMPLE
        Remove-FanartTVModuleSettings

        Checks to see if the default configuration folder exists and removes it if it does

        The default location of the FanartTV configuration folder is:
            $env:USERPROFILE\Celerium.FanartTV

    .EXAMPLE
        Remove-FanartTVModuleSettings -FanartTVConfigPath C:\Celerium.FanartTV -AndVariables

        Checks to see if the defined configuration folder exists and removes it if it does
        If sensitive FanartTV variables exist then they are removed as well

        The location of the FanartTV configuration folder in this example is:
            C:\Celerium.FanartTV

    .NOTES
        N/A

    .LINK
        https://celerium.github.io/Celerium.FanartTV/site/Internal/Remove-FanartTVModuleSettings.html
#>

    [CmdletBinding(DefaultParameterSetName = 'Destroy',SupportsShouldProcess, ConfirmImpact = 'None')]
    Param (
        [Parameter()]
        [string]$FanartTVConfigPath = $(Join-Path -Path $home -ChildPath $(if ($IsWindows -or $PSEdition -eq 'Desktop') {"Celerium.FanartTV"}else{".Celerium.FanartTV"}) ),

        [Parameter()]
        [switch]$AndVariables
    )

    begin {}

    process {

        if(Test-Path $FanartTVConfigPath)  {

            Remove-Item -Path $FanartTVConfigPath -Recurse -Force -WhatIf:$WhatIfPreference

            If ($AndVariables) {
                Remove-FanartTVApiKey
                Remove-FanartTVBaseUri
            }

            if ($WhatIfPreference -eq $false) {

                if (!(Test-Path $FanartTVConfigPath)) {
                    Write-Output "The Celerium.FanartTV configuration folder has been removed successfully from [ $FanartTVConfigPath ]"
                }
                else {
                    Write-Error "The Celerium.FanartTV configuration folder could not be removed from [ $FanartTVConfigPath ]"
                }

            }

        }
        else {
            Write-Warning "No configuration folder found at [ $FanartTVConfigPath ]"
        }

    }

    end {}

}