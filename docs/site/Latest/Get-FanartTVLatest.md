---
external help file: Celerium.FanartTV-help.xml
grand_parent: Latest
Module Name: Celerium.FanartTV
online version: https://celerium.github.io/Celerium.FanartTV/site/Latest/Get-FanartTVLatest.html
parent: GET
schema: 2.0.0
title: Get-FanartTVLatest
---

# Get-FanartTVLatest

## SYNOPSIS
Retrieve the latest fanart images for a specific resource

## SYNTAX

```powershell
Get-FanartTVLatest [-ResourceType] <String> [[-Date] <String>] [<CommonParameters>]
```

## DESCRIPTION
The Get-FanartTVLatest cmdlet retrieve the latest fanart
images for a specific resource.

Resources are Movies,TV Shows, & Music

## EXAMPLES

### EXAMPLE 1
```powershell
Get-FanartTVLatest -ResourceType Movies
```

Retrieve all available fanart images for movies updated in the
past 2 days

### EXAMPLE 2
```powershell
Get-FanartTVLatest -ResourceType Movies -Date '2026-02-01'
```

Retrieve all available fanart images for movies updated since
the defined date

## PARAMETERS

### -ResourceType
What type of latest resource to retrieve

Allowed values:
    'Movies','TV Shows','Music'

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

### -Date
Date to return items updated after

By default, returns movies updated in the last 2 days

Date is converted to Unix timestamp

Example:
    2026-02-21 = 1771657200

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
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

[https://celerium.github.io/Celerium.FanartTV/site/Latest/Get-FanartTVLatest.html](https://celerium.github.io/Celerium.FanartTV/site/Latest/Get-FanartTVLatest.html)

[https://api.fanart.tv/#tag/Latest](https://api.fanart.tv/#tag/Latest)

