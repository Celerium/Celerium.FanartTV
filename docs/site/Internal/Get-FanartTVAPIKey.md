---
external help file: Celerium.FanartTV-help.xml
grand_parent: Internal
Module Name: Celerium.FanartTV
online version: https://celerium.github.io/Celerium.FanartTV/site/Internal/Get-FanartTVAPIKey.html
parent: GET
schema: 2.0.0
title: Get-FanartTVAPIKey
---

# Get-FanartTVAPIKey

## SYNOPSIS
Gets the FanartTV API key

## SYNTAX

```powershell
Get-FanartTVAPIKey [-AsPlainText] [<CommonParameters>]
```

## DESCRIPTION
The Get-FanartTVAPIKey cmdlet gets the FanartTV API key from
the global variable and returns it as a SecureString

## EXAMPLES

### EXAMPLE 1
```powershell
Get-FanartTVAPIKey
```

Gets the Api key and returns it as a SecureString

### EXAMPLE 2
```powershell
Get-FanartTVAPIKey -AsPlainText
```

Gets and decrypts the API key from the global variable and
returns the API key as plain text

## PARAMETERS

### -AsPlainText
Decrypt and return the API key in plain text

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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

[https://celerium.github.io/Celerium.FanartTV/site/Internal/Get-FanartTVAPIKey.html](https://celerium.github.io/Celerium.FanartTV/site/Internal/Get-FanartTVAPIKey.html)

