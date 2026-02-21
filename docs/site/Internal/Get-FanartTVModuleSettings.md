---
external help file: Celerium.FanartTV-help.xml
grand_parent: Internal
Module Name: Celerium.FanartTV
online version: https://celerium.github.io/Celerium.FanartTV/site/Internal/Get-FanartTVModuleSettings.html
parent: GET
schema: 2.0.0
title: Get-FanartTVModuleSettings
---

# Get-FanartTVModuleSettings

## SYNOPSIS
Gets the saved FanartTV configuration settings

## SYNTAX

```powershell
Get-FanartTVModuleSettings [[-FanartTVConfigPath] <String>] [[-FanartTVConfigFile] <String>] [-OpenConfigFile]
 [<CommonParameters>]
```

## DESCRIPTION
The Get-FanartTVModuleSettings cmdlet gets the saved FanartTV configuration settings
from the local system

By default the configuration file is stored in the following location:
    $env:USERPROFILE\Celerium.FanartTV

## EXAMPLES

### EXAMPLE 1
```powershell
Get-FanartTVModuleSettings
```

Gets the contents of the configuration file that was created with the
Export-FanartTVModuleSettings

The default location of the FanartTV configuration file is:
    $env:USERPROFILE\Celerium.FanartTV\config.psd1

### EXAMPLE 2
```powershell
Get-FanartTVModuleSettings -FanartTVConfigPath C:\Celerium.FanartTV -FanartTVConfigFile MyConfig.psd1 -openConfFile
```

Opens the configuration file from the defined location in the default editor

The location of the FanartTV configuration file in this example is:
    C:\Celerium.FanartTV\MyConfig.psd1

## PARAMETERS

### -FanartTVConfigPath
Define the location to store the FanartTV configuration file

By default the configuration file is stored in the following location:
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

### -FanartTVConfigFile
Define the name of the FanartTV configuration file

By default the configuration file is named:
    config.psd1

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: Config.psd1
Accept pipeline input: False
Accept wildcard characters: False
```

### -OpenConfigFile
Opens the FanartTV configuration file

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

[https://celerium.github.io/Celerium.FanartTV/site/Internal/Get-FanartTVModuleSettings.html](https://celerium.github.io/Celerium.FanartTV/site/Internal/Get-FanartTVModuleSettings.html)

