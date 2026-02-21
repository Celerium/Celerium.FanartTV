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

    .LINK
        https://api.fanart.tv/#tag/Movies/operation/getMovie
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
