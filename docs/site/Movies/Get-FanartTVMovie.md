---
external help file: Celerium.FanartTV-help.xml
grand_parent: Movies
Module Name: Celerium.FanartTV
online version: https://celerium.github.io/Celerium.FanartTV/site/Movies/Get-FanartTVMovie.html
parent: GET
schema: 2.0.0
title: Get-FanartTVMovie
---

# Get-FanartTVMovie

## SYNOPSIS
Retrieve all available fanart images for a specific movie

## SYNTAX

```powershell
Get-FanartTVMovie [-ID] <String> [<CommonParameters>]
```

## DESCRIPTION
The Get-FanartTVMovie cmdlet retrieve all available
fanart images for a specific movie

## EXAMPLES

### EXAMPLE 1
```powershell
Get-FanartTVMovie -ID 550
```

Retrieve all available fanart images for a specific movie

## PARAMETERS

### -ID
Movie identifier (TMDB ID or IMDB ID with 'tt' prefix)

Examples:
    550 - TMDB ID (Fight Club)
    tt0137523 - IMDB ID (Fight Club)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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

[https://celerium.github.io/Celerium.FanartTV/site/Movies/Get-FanartTVMovie.html](https://celerium.github.io/Celerium.FanartTV/site/Movies/Get-FanartTVMovie.html)

