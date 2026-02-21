---
external help file: Celerium.FanartTV-help.xml
grand_parent: Internal
Module Name: Celerium.FanartTV
online version: https://celerium.github.io/Celerium.FanartTV/site/Internal/Invoke-FanartTVRequest.html
parent: GET
schema: 2.0.0
title: Invoke-FanartTVRequest
---

# Invoke-FanartTVRequest

## SYNOPSIS
Makes an API request to FanartTV

## SYNTAX

```powershell
Invoke-FanartTVRequest [[-Method] <String>] [-ResourceURI] <String> [[-UriFilter] <Hashtable>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The Invoke-FanartTVRequest cmdlet invokes an API request to the FanartTV API

This is an internal function that is used by all public functions

## EXAMPLES

### EXAMPLE 1
```powershell
Invoke-FanartTVRequest -Method GET -ResourceURI '/passwords' -UriFilter $UriFilter
```

Invoke a rest method against the defined resource using the provided parameters

Example HashTable:
    $UriParameters = @{
        'filter\[id\]'\]               = 123456789
        'filter\[organization_id\]'\]  = 12345
    }

## PARAMETERS

### -Method
Defines the type of API method to use

Allowed values:
'GET'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: GET
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceURI
Defines the resource uri (url) to use when creating the API call

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UriFilter
Hashtable of values to combine a functions parameters with
the ResourceUri parameter

This allows for the full uri query to occur

The full resource path is made with the following data
$FanartTVModuleBaseURI + $ResourceURI + ConvertTo-FanartTVQueryString

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
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

[https://celerium.github.io/Celerium.FanartTV/site/Internal/Invoke-FanartTVRequest.html](https://celerium.github.io/Celerium.FanartTV/site/Internal/Invoke-FanartTVRequest.html)

