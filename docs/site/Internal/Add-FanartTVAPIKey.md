---
external help file: Celerium.FanartTV-help.xml
grand_parent: Internal
Module Name: Celerium.FanartTV
online version: https://celerium.github.io/Celerium.FanartTV/site/Internal/Add-FanartTVAPIKey.html
parent: POST
schema: 2.0.0
title: Add-FanartTVAPIKey
---

# Add-FanartTVAPIKey

## SYNOPSIS
Sets your API key used to authenticate all API calls

## SYNTAX

```powershell
Add-FanartTVAPIKey [[-PersonalKey] <String>] [[-ProjectKey] <String>] [<CommonParameters>]
```

## DESCRIPTION
The Add-FanartTVAPIKey cmdlet sets your API key which is used to
authenticate all API calls made to FanartTV

Note: When both keys are provided, the personal key determines the
access tier (2-day delay instead of 7-day).
When both query parameter
and header are present for the same key type, the query parameter takes priority

## EXAMPLES

### EXAMPLE 1
```powershell
Add-FanartTVAPIKey
```

Prompts to enter in the personal API key which will be
stored as a SecureString

### EXAMPLE 2
```powershell
Add-FanartTVAPIKey -PersonalKey 123456 -ProjectKey 8765309
```

Adds both project & personal keys which will be
stored as a SecureString

## PARAMETERS

### -PersonalKey
Plain text personal key

If not defined the cmdlet will prompt you to enter it

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ProjectKey
Plain text project key

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

[https://celerium.github.io/Celerium.FanartTV/site/Internal/Add-FanartTVAPIKey.html](https://celerium.github.io/Celerium.FanartTV/site/Internal/Add-FanartTVAPIKey.html)

[https://api.fanart.tv/#section/Fanart.tv-API-Documentation/Authentication](https://api.fanart.tv/#section/Fanart.tv-API-Documentation/Authentication)

