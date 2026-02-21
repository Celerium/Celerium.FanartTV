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
