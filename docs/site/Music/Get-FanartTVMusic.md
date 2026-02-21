---
external help file: Celerium.FanartTV-help.xml
grand_parent: Music
Module Name: Celerium.FanartTV
online version: https://celerium.github.io/Celerium.FanartTV/site/Music/Get-FanartTVMusic.html
parent: GET
schema: 2.0.0
title: Get-FanartTVMusic
---

# Get-FanartTVMusic

## SYNOPSIS
Retrieve all available music artist and album images

## SYNTAX

```powershell
Get-FanartTVMusic [-ImageType] <String> [-ID] <String> [<CommonParameters>]
```

## DESCRIPTION
The Get-FanartTVMusic cmdlet retrieve all available
music artist and album images

## EXAMPLES

### EXAMPLE 1
```powershell
Get-FanartTVMusic -ImageType Artist -ID 20244d07-534f-4eff-b4d4-930878889970
```

Retrieve all available fanart artist images for a specific music artist

### EXAMPLE 2
```powershell
Get-FanartTVMusic -ImageType Album -ID 70816f08-b7d1-4e77-817e-8c1426751de0
```

Retrieve all available fanart album images for a specific music album

### EXAMPLE 3
```powershell
Get-FanartTVMusic -ImageType Label -ID be994c3e-0527-404f-b8f9-455e217e83d2
```

Retrieve all available fanart label images for a specific music label

## PARAMETERS

### -ImageType
What type of image to retrieve

Allowed values:
    'Artist','Album','Label'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ID
MusicBrainz Artist ID (MBID)
MusicBrainz Release Group ID
MusicBrainz Label ID

Examples:
    Artist  - 20244d07-534f-4eff-b4d4-930878889970 - MusicBrainz ID (Taylor Swift)
    Album   - 70816f08-b7d1-4e77-817e-8c1426751de0 - MusicBrainz Release Group ID (Taylor Swift)
    Label   - be994c3e-0527-404f-b8f9-455e217e83d2 - MusicBrainz Label ID (Profile Records)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
N/A

## RELATED LINKS

[https://celerium.github.io/Celerium.FanartTV/site/Music/Get-FanartTVMusic.html](https://celerium.github.io/Celerium.FanartTV/site/Music/Get-FanartTVMusic.html)

