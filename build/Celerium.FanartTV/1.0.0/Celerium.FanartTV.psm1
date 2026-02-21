#Region '.\Private\ApiCalls\ConvertTo-FanartTVQueryString.ps1' -1

function ConvertTo-FanartTVQueryString {
<#
    .SYNOPSIS
        Converts uri filter parameters

    .DESCRIPTION
        The ConvertTo-FanartTVQueryString cmdlet converts & formats uri query parameters
        from a function which are later used to make the full resource uri for
        an API call

        This is an internal helper function the ties in directly with the
        ConvertTo-FanartTVQueryString & any public functions that define parameters

    .PARAMETER UriFilter
        Hashtable of values to combine a functions parameters with
        the ResourceUri parameter

        This allows for the full uri query to occur

    .EXAMPLE
        ConvertTo-FanartTVQueryString -UriFilter $HashTable

        Example HashTable:
            $UriParameters = @{
                'filter[id]']               = 123456789
                'filter[organization_id]']  = 12345
            }

    .NOTES
        N/A

    .LINK
        https://celerium.github.io/Celerium.FanartTV/site/Internal/ConvertTo-FanartTVQueryString.html
#>

    [CmdletBinding(DefaultParameterSetName = 'Convert')]
    Param (
        [Parameter(Mandatory = $true)]
        [hashtable]$UriFilter
    )

    begin {}

    process{

        if (-not $UriFilter) {
            return ""
        }

        $params = @()
        foreach ($key in $UriFilter.Keys) {
            $value = [System.Net.WebUtility]::UrlEncode($UriFilter[$key])
            $params += "$key=$value"
        }

        $QueryString = '?' + ($params -join '&')
        return $QueryString

    }

    end{}

}
#EndRegion '.\Private\ApiCalls\ConvertTo-FanartTVQueryString.ps1' 64
#Region '.\Private\ApiCalls\Invoke-FanartTVRequest.ps1' -1

function Invoke-FanartTVRequest {
<#
    .SYNOPSIS
        Makes an API request to FanartTV

    .DESCRIPTION
        The Invoke-FanartTVRequest cmdlet invokes an API request to the FanartTV API

        This is an internal function that is used by all public functions

    .PARAMETER Method
        Defines the type of API method to use

        Allowed values:
        'GET'

    .PARAMETER ResourceURI
        Defines the resource uri (url) to use when creating the API call

    .PARAMETER UriFilter
        Hashtable of values to combine a functions parameters with
        the ResourceUri parameter

        This allows for the full uri query to occur

        The full resource path is made with the following data
        $FanartTVModuleBaseURI + $ResourceURI + ConvertTo-FanartTVQueryString

    .EXAMPLE
        Invoke-FanartTVRequest -Method GET -ResourceURI '/passwords' -UriFilter $UriFilter

        Invoke a rest method against the defined resource using the provided parameters

        Example HashTable:
            $UriParameters = @{
                'filter[id]']               = 123456789
                'filter[organization_id]']  = 12345
            }

    .NOTES
        N/A

    .LINK
        https://celerium.github.io/Celerium.FanartTV/site/Internal/Invoke-FanartTVRequest.html
#>

    [CmdletBinding(DefaultParameterSetName = 'Invoke', SupportsShouldProcess)]
    param (
        [Parameter()]
        [ValidateSet('GET')]
        [string]$Method = 'GET',

        [Parameter(Mandatory = $true)]
        [string]$ResourceURI,

        [Parameter()]
        [hashtable]$UriFilter
    )

    begin {

        if ( !("System.Web.HttpUtility" -as [Type]) ) {
            Add-Type -Assembly System.Web
        }

        $FunctionName       = $MyInvocation.InvocationName
        $ParameterName      = $functionName + '_Parameters'      -replace '-','_'
        $QueryParameterName = $functionName + '_ParametersQuery' -replace '-','_'

    }

    process {

        Write-Verbose "[ $FunctionName ] - Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        $Result = @{}

        try {

            $ApiKeys = Get-FanartTVAPIKey -AsPlainText

            if ($ApiKeys.PersonalKey -and -not $ApiKeys.ProjectKey) {
                $Headers = @{ 'client-key' = $ApiKeys.PersonalKey }
            }

            if (-not $ApiKeys.PersonalKey -and $ApiKeys.ProjectKey) {
                $Headers = @{ 'api-key' = $ApiKeys.ProjectKey }
            }

            if ($ApiKeys.PersonalKey -and $ApiKeys.ProjectKey) {
                $Headers = @{
                    'api-key'       = $ApiKeys.ProjectKey
                    'client-key'    = $ApiKeys.PersonalKey
                }
            }

            if ($UriFilter) {
                $QueryString = ConvertTo-FanartTVQueryString -UriFilter $UriFilter
                Set-Variable -Name $QueryParameterName -Value $QueryString -Scope Global -Force -Confirm:$false
            }

            $parameters = @{
                'Method'    = $Method
                'Uri'       = $FanartTVModuleBaseURI + $ResourceURI + $QueryString
                'Headers'   = $Headers
                'UserAgent' = $FanartTVModuleUserAgent
            }

            Set-Variable -Name $ParameterName -Value $parameters -Scope Global -Force -Confirm:$false

            $Result = Invoke-RestMethod @parameters -ErrorAction Stop

        }
        catch {

            $ExceptionError = $_.Exception.Message
            Write-Warning 'The [ Invoke_FanartTVRequest_Parameters, Invoke_FanartTVRequest_ParametersQuery, & CmdletName_Parameters ] variables can provide extra details'

            switch -Wildcard ($ExceptionError) {
                '*404*' { Write-Error "Invoke-FanartTVRequest : URI not found - [ $ResourceURI ]" }
                '*429*' { Write-Error 'Invoke-FanartTVRequest : API rate limited' }
                '*504*' { Write-Error "Invoke-FanartTVRequest : Gateway Timeout" }
                default { Write-Error $_ }
            }
        }
        finally{

            if ($ApiKeys.PersonalKey -and -not $ApiKeys.ProjectKey) {
                $Auth = $Invoke_FanartTVRequest_Parameters['headers']['client-key']
                $Invoke_FanartTVRequest_Parameters['headers']['client-key'] = $Auth.Substring( 0, [Math]::Min($Auth.Length, 5) ) + '*******'
            }

            if (-not $ApiKeys.PersonalKey -and $ApiKeys.ProjectKey) {
                $Auth = $Invoke_FanartTVRequest_Parameters['headers']['api-key']
                $Invoke_FanartTVRequest_Parameters['headers']['api-key'] = $Auth.Substring( 0, [Math]::Min($Auth.Length, 5) ) + '*******'
            }

            if ($ApiKeys.PersonalKey -and $ApiKeys.ProjectKey) {
                $AuthProject    = $Invoke_FanartTVRequest_Parameters['headers']['api-key']
                $AuthPersonal   = $Invoke_FanartTVRequest_Parameters['headers']['client-key']
                $Invoke_FanartTVRequest_Parameters['headers']['api-key'] = $AuthProject.Substring( 0, [Math]::Min($AuthProject.Length, 5) ) + '*******'
                $Invoke_FanartTVRequest_Parameters['headers']['client-key'] = $AuthPersonal.Substring( 0, [Math]::Min($AuthPersonal.Length, 5) ) + '*******'
            }

        }

        return $Result

    }

    end {}

}
#EndRegion '.\Private\ApiCalls\Invoke-FanartTVRequest.ps1' 154
#Region '.\Private\ApiKeys\Add-FanartTVAPIKey.ps1' -1

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
#EndRegion '.\Private\ApiKeys\Add-FanartTVAPIKey.ps1' 85
#Region '.\Private\ApiKeys\Get-FanartTVAPIKey.ps1' -1

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
#EndRegion '.\Private\ApiKeys\Get-FanartTVAPIKey.ps1' 94
#Region '.\Private\ApiKeys\Remove-FanartTVAPIKey.ps1' -1

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
#EndRegion '.\Private\ApiKeys\Remove-FanartTVAPIKey.ps1' 47
#Region '.\Private\BaseUri\Add-FanartTVBaseURI.ps1' -1

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
#EndRegion '.\Private\BaseUri\Add-FanartTVBaseURI.ps1' 70
#Region '.\Private\BaseUri\Get-FanartTVBaseURI.ps1' -1

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
#EndRegion '.\Private\BaseUri\Get-FanartTVBaseURI.ps1' 39
#Region '.\Private\BaseUri\Remove-FanartTVBaseURI.ps1' -1

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
#EndRegion '.\Private\BaseUri\Remove-FanartTVBaseURI.ps1' 45
#Region '.\Private\ModuleSettings\Export-FanartTVModuleSettings.ps1' -1

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
#EndRegion '.\Private\ModuleSettings\Export-FanartTVModuleSettings.ps1' 99
#Region '.\Private\ModuleSettings\Get-FanartTVModuleSettings.ps1' -1

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
#EndRegion '.\Private\ModuleSettings\Get-FanartTVModuleSettings.ps1' 89
#Region '.\Private\ModuleSettings\Import-FanartTVModuleSettings.ps1' -1

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
#EndRegion '.\Private\ModuleSettings\Import-FanartTVModuleSettings.ps1' 110
#Region '.\Private\ModuleSettings\Initialize-FanartTVModuleSettings.ps1' -1

#Used to auto load either baseline settings or saved configurations when the module is imported
Import-FanartTVModuleSettings -Verbose:$false
#EndRegion '.\Private\ModuleSettings\Initialize-FanartTVModuleSettings.ps1' 3
#Region '.\Private\ModuleSettings\Remove-FanartTVModuleSettings.ps1' -1

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
#EndRegion '.\Private\ModuleSettings\Remove-FanartTVModuleSettings.ps1' 91
#Region '.\Public\Latest\Get-FanartTVLatest.ps1' -1

function Get-FanartTVLatest {
<#
    .SYNOPSIS
        Retrieve the latest fanart images for a specific resource

    .DESCRIPTION
        The Get-FanartTVLatest cmdlet retrieve the latest fanart
        images for a specific resource.

        Resources are Movies,TV Shows, & Music

    .PARAMETER ResourceType
        What type of latest resource to retrieve

        Allowed values:
            'Movies','TV Shows','Music'

    .PARAMETER Date
        Date to return items updated after

        By default, returns movies updated in the last 2 days

        Date is converted to Unix timestamp

        Example:
            2026-02-21 = 1771657200

    .EXAMPLE
        Get-FanartTVLatest -ResourceType Movies

        Retrieve all available fanart images for movies updated in the
        past 2 days

    .EXAMPLE
        Get-FanartTVLatest -ResourceType Movies -Date '2026-02-01'

        Retrieve all available fanart images for movies updated since
        the defined date

    .NOTES
        N/A

    .LINK
        https://celerium.github.io/Celerium.FanartTV/site/Latest/Get-FanartTVLatest.html
#>

    [CmdletBinding(DefaultParameterSetName = 'Index')]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateSet('Movies','TV Shows','Music')]
        [string]$ResourceType,

        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [ValidateNotNull()]
        [string]$Date
    )

    begin {

        $FunctionName       = $MyInvocation.InvocationName

    }

    process {

        Write-Verbose "[ $FunctionName ] - Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        switch ($ResourceType){
            'Movies'    { $ResourceUri = "/movies/latest" }
            'TV Shows'  { $ResourceUri = "/tv/latest" }
            'Music'     { $ResourceUri = "/music/latest" }
        }

        $UriParameters = @{}
        if ($Date) {$UriParameters['date']  = ([DateTimeOffset]$Date).ToUnixTimeSeconds() }

        return Invoke-FanartTVRequest -Method GET -ResourceURI $ResourceUri -UriFilter $UriParameters

    }

    end {}

}
#EndRegion '.\Public\Latest\Get-FanartTVLatest.ps1' 84
#Region '.\Public\Movies\Get-FanartTVMovie.ps1' -1

function Get-FanartTVMovie {
<#
    .SYNOPSIS
        Retrieve all available fanart images for a specific movie

    .DESCRIPTION
        The Get-FanartTVMovie cmdlet retrieve all available
        fanart images for a specific movie

    .PARAMETER ID
        Movie identifier (TMDB ID or IMDB ID with 'tt' prefix)

        Examples:
            550 - TMDB ID (Fight Club)
            tt0137523 - IMDB ID (Fight Club)

    .EXAMPLE
        Get-FanartTVMovie -ID 550

        Retrieve all available fanart images for a specific movie

    .NOTES
        N/A

    .LINK
        https://celerium.github.io/Celerium.FanartTV/site/Movies/Get-FanartTVMovie.html
#>

    [CmdletBinding(DefaultParameterSetName = 'Index')]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$ID
    )

    begin {

        $FunctionName       = $MyInvocation.InvocationName

    }

    process {

        Write-Verbose "[ $FunctionName ] - Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        $ResourceUri = "/movies/$ID"

        return Invoke-FanartTVRequest -Method GET -ResourceURI $ResourceUri

    }

    end {}

}
#EndRegion '.\Public\Movies\Get-FanartTVMovie.ps1' 54
#Region '.\Public\Music\Get-FanartTVMusic.ps1' -1

function Get-FanartTVMusic {
<#
    .SYNOPSIS
        Retrieve all available music artist and album images

    .DESCRIPTION
        The Get-FanartTVMusic cmdlet retrieve all available
        music artist and album images

    .PARAMETER ImageType
        What type of image to retrieve

        Allowed values:
            'Artist','Album','Label'

    .PARAMETER ID
        MusicBrainz Artist ID (MBID)
        MusicBrainz Release Group ID
        MusicBrainz Label ID

        Examples:
            Artist  - 20244d07-534f-4eff-b4d4-930878889970 - MusicBrainz ID (Taylor Swift)
            Album   - 70816f08-b7d1-4e77-817e-8c1426751de0 - MusicBrainz Release Group ID (Taylor Swift)
            Label   - be994c3e-0527-404f-b8f9-455e217e83d2 - MusicBrainz Label ID (Profile Records)

    .EXAMPLE
        Get-FanartTVMusic -ImageType Artist -ID 20244d07-534f-4eff-b4d4-930878889970

        Retrieve all available fanart artist images for a specific music artist

    .EXAMPLE
        Get-FanartTVMusic -ImageType Album -ID 70816f08-b7d1-4e77-817e-8c1426751de0

        Retrieve all available fanart album images for a specific music album

    .EXAMPLE
        Get-FanartTVMusic -ImageType Label -ID be994c3e-0527-404f-b8f9-455e217e83d2

        Retrieve all available fanart label images for a specific music label

    .NOTES
        N/A

    .LINK
        https://celerium.github.io/Celerium.FanartTV/site/Music/Get-FanartTVMusic.html
#>

    [CmdletBinding(DefaultParameterSetName = 'Index')]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateSet('Artist','Album','Label')]
        [string]$ImageType,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$ID
    )

    begin {

        $FunctionName       = $MyInvocation.InvocationName

    }

    process {

        Write-Verbose "[ $FunctionName ] - Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        switch ($ImageType) {
            'Artist'{ $ResourceUri = "/music/$ID" }
            'Album' { $ResourceUri = "/music/albums/$ID" }
            'Label' { $ResourceUri = "/music/labels/$ID" }
        }

        return Invoke-FanartTVRequest -Method GET -ResourceURI $ResourceUri

    }

    end {}

}
#EndRegion '.\Public\Music\Get-FanartTVMusic.ps1' 81
#Region '.\Public\TVShows\Get-FanartTVShow.ps1' -1

function Get-FanartTVShow {
<#
    .SYNOPSIS
        Retrieve all available fanart images for a specific TV Show

    .DESCRIPTION
        The Get-FanartTVShow cmdlet retrieve all available
        fanart images for a specific TV Show

    .PARAMETER ID
        TV Show identifier (TVDB ID)

        Examples:
            76703 - TVDB ID (Pokemon)

    .EXAMPLE
        Get-FanartTVShow -ID 76703

        Retrieve all available fanart images for a specific TV Show

    .NOTES
        N/A

    .LINK
        https://celerium.github.io/Celerium.FanartTV/site/TV Shows/Get-FanartTVShow.html
#>

    [CmdletBinding(DefaultParameterSetName = 'Index')]
    Param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$ID
    )

    begin {

        $FunctionName       = $MyInvocation.InvocationName

    }

    process {

        Write-Verbose "[ $FunctionName ] - Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        $ResourceUri = "/tv/$ID"

        return Invoke-FanartTVRequest -Method GET -ResourceURI $ResourceUri

    }

    end {}

}
#EndRegion '.\Public\TVShows\Get-FanartTVShow.ps1' 53
