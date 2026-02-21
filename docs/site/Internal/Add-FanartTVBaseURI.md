---
external help file: Celerium.FanartTV-help.xml
grand_parent: Internal
Module Name: Celerium.FanartTV
online version: https://celerium.github.io/Celerium.FanartTV/site/Internal/Add-FanartTVBaseURI.html
parent: POST
schema: 2.0.0
title: Add-FanartTVBaseURI
---

# Add-FanartTVBaseURI

## SYNOPSIS
Sets the base URI for the FanartTV API connection

## SYNTAX

```powershell
Add-FanartTVBaseURI [[-BaseUri] <String>] [[-Version] <String>] [<CommonParameters>]
```

## DESCRIPTION
The Add-FanartTVBaseURI cmdlet sets the base URI which is used
to construct the full URI for all API calls

## EXAMPLES

### EXAMPLE 1
```powershell
Add-FanartTVBaseURI
```

The base URI will use https://webservice.fanart.tv/v3.2

### EXAMPLE 2
```powershell
Add-FanartTVBaseURI -BaseUri 'https://gateway.celerium.org'
```

The base URI will use https://gateway.celerium.org/v3.2

### EXAMPLE 3
```
'https://gateway.celerium.org' | Add-FanartTVBaseURI
```

The base URI will use https://gateway.celerium.org/v3.2

## PARAMETERS

### -BaseUri
Sets the base URI for the FanartTV API connection.
Helpful
if using a custom API gateway

The default value is 'https://webservice.fanart.tv'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: Https://webservice.fanart.tv
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Version
Sets API to use

Note: Module was built and tested on v3.2 only

The default value is 'v3.2'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: V3.2
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
N/A

## RELATED LINKS

[https://celerium.github.io/Celerium.FanartTV/site/Internal/Add-FanartTVBaseURI.html](https://celerium.github.io/Celerium.FanartTV/site/Internal/Add-FanartTVBaseURI.html)

[https://api.fanart.tv/#section/Fanart.tv-API-Documentation](https://api.fanart.tv/#section/Fanart.tv-API-Documentation)

