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
