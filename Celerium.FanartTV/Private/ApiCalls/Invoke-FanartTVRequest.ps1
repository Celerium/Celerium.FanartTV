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
