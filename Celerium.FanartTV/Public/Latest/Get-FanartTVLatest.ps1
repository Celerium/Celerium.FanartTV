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
