---
external help file: Celerium.FanartTV-help.xml
grand_parent: Internal
Module Name: Celerium.FanartTV
online version: https://celerium.github.io/Celerium.FanartTV/site/Internal/Remove-FanartTVModuleSettings.html
parent: DELETE
schema: 2.0.0
title: Remove-FanartTVModuleSettings
---

# Remove-FanartTVModuleSettings

## SYNOPSIS
Removes the stored FanartTV configuration folder

## SYNTAX

```powershell
Remove-FanartTVModuleSettings [[-FanartTVConfigPath] <String>] [-AndVariables] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
The Remove-FanartTVModuleSettings cmdlet removes the FanartTV folder and its files
This cmdlet also has the option to remove sensitive FanartTV variables as well

By default configuration files are stored in the following location and will be removed:
    $env:USERPROFILE\Celerium.FanartTV

## EXAMPLES

### EXAMPLE 1
```powershell
Remove-FanartTVModuleSettings
```

Checks to see if the default configuration folder exists and removes it if it does

The default location of the FanartTV configuration folder is:
    $env:USERPROFILE\Celerium.FanartTV

### EXAMPLE 2
```powershell
Remove-FanartTVModuleSettings -FanartTVConfigPath C:\Celerium.FanartTV -AndVariables
```

Checks to see if the defined configuration folder exists and removes it if it does
If sensitive FanartTV variables exist then they are removed as well

The location of the FanartTV configuration folder in this example is:
    C:\Celerium.FanartTV

## PARAMETERS

### -FanartTVConfigPath
Define the location of the FanartTV configuration folder

By default the configuration folder is located at:
    $env:USERPROFILE\Celerium.FanartTV

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $(Join-Path -Path $home -ChildPath $(if ($IsWindows -or $PSEdition -eq 'Desktop') {"Celerium.FanartTV"}else{".Celerium.FanartTV"}) )
Accept pipeline input: False
Accept wildcard characters: False
```

### -AndVariables
Define if sensitive FanartTV variables should be removed as well

By default the variables are not removed

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

[https://celerium.github.io/Celerium.FanartTV/site/Internal/Remove-FanartTVModuleSettings.html](https://celerium.github.io/Celerium.FanartTV/site/Internal/Remove-FanartTVModuleSettings.html)

