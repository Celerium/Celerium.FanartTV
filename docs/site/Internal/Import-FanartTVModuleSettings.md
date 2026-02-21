---
external help file: Celerium.FanartTV-help.xml
grand_parent: Internal
Module Name: Celerium.FanartTV
online version: https://celerium.github.io/Celerium.FanartTV/site/Internal/Import-FanartTVModuleSettings.html
parent: GET
schema: 2.0.0
title: Import-FanartTVModuleSettings
---

# Import-FanartTVModuleSettings

## SYNOPSIS
Imports the FanartTV BaseURI, API, & JSON configuration information to the current session

## SYNTAX

```powershell
Import-FanartTVModuleSettings [[-FanartTVConfigPath] <String>] [[-FanartTVConfigFile] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
The Import-FanartTVModuleSettings cmdlet imports the FanartTV BaseURI, API, & JSON configuration
information stored in the FanartTV configuration file to the users current session

By default the configuration file is stored in the following location:
    $env:USERPROFILE\Celerium.FanartTV

## EXAMPLES

### EXAMPLE 1
```powershell
Import-FanartTVModuleSettings
```

Validates that the configuration file created with the Export-FanartTVModuleSettings cmdlet exists
then imports the stored data into the current users session

The default location of the FanartTV configuration file is:
    $env:USERPROFILE\Celerium.FanartTV\config.psd1

### EXAMPLE 2
```powershell
Import-FanartTVModuleSettings -FanartTVConfigPath C:\Celerium.FanartTV -FanartTVConfigFile MyConfig.psd1
```

Validates that the configuration file created with the Export-FanartTVModuleSettings cmdlet exists
then imports the stored data into the current users session

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
N/A

## RELATED LINKS

[https://celerium.github.io/Celerium.FanartTV/site/Internal/Import-FanartTVModuleSettings.html](https://celerium.github.io/Celerium.FanartTV/site/Internal/Import-FanartTVModuleSettings.html)

