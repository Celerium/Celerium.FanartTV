function Get-FanartTVAPIKey {
<#
    .SYNOPSIS
        Gets the FanartTV API key

    .DESCRIPTION
        The Get-FanartTVAPIKey cmdlet gets the FanartTV API key from
        the global variable and returns it as a SecureString

    .PARAMETER AsPlainText
        Decrypt and return the API key in plain text

    .EXAMPLE
        Get-FanartTVAPIKey

        Gets the Api key and returns it as a SecureString

    .EXAMPLE
        Get-FanartTVAPIKey -AsPlainText

        Gets and decrypts the API key from the global variable and
        returns the API key as plain text

    .NOTES
        N/A

    .LINK
        https://celerium.github.io/Celerium.FanartTV/site/Internal/Get-FanartTVAPIKey.html
#>

    [CmdletBinding(DefaultParameterSetName = 'Index')]
    Param (
        [Parameter(Mandatory = $false)]
        [switch]$AsPlainText
    )

    begin {}

    process {

        try {

            if ($FanartTVModulePersonalApiKey -or $FanartTVModuleProjectApiKey) {

                switch ($AsPlainText) {
                    $true   {

                        if ([bool]$FanartTVModulePersonalApiKey) {
                            $EncryptedPersonalKey = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($FanartTVModulePersonalApiKey)
                            $DecryptedPersonalKey = ([System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($EncryptedPersonalKey)).ToString()
                        }

                        if ([bool]$FanartTVModuleProjectApiKey) {
                            $EncryptedProjectKey = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($FanartTVModuleProjectApiKey)
                            $DecryptedProjectKey = ([System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($EncryptedProjectKey)).ToString()
                        }

                        [PSCustomObject]@{
                            PersonalKey = $DecryptedPersonalKey
                            ProjectKey  = $DecryptedProjectKey
                        }

                    }
                    $false  {
                        [PSCustomObject]@{
                            PersonalKey = $FanartTVModulePersonalApiKey
                            ProjectKey  = $FanartTVModuleProjectApiKey
                        }
                    }
                }

            }
            else { Write-Warning "The FanartTV API keys are not set. Run Add-FanartTVAPIKey to set the API key" }

        }
        catch {
            Write-Error $_
        }
        finally {
            if ([bool]$EncryptedPersonalKey) {
                [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($EncryptedPersonalKey)
            }
            if ([bool]$EncryptedProjectKey) {
                [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($EncryptedProjectKey)
            }
        }


    }

    end {}

}