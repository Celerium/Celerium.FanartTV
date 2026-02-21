---
title: Tracking CSV
parent: Home
nav_order: 2
---

# Tracking CSV

When updating the documentation for this project, the tracking CSV plays a huge part in organizing of the markdown documents. Any new functions or endpoints should be added to the tracking CSV when publishing an updated module or documentation version.

{: .warning }
I recommend downloading the CSV from the link provided rather then viewing the table below.

[Tracking CSV](https://github.com/Celerium/Celerium.FanartTV/blob/master/docs/endpoints.csv)

---

## CSV markdown table

|Category|EndpointUri                 |Method|Function                     |Example|Complete|Notes|
|--------|----------------------------|------|-----------------------------|-------|--------|-----|
|Movies  |/{version}/movies/{id}      |GET   |Get-FanartTVMovie            |N/A    |Yes     |     |
|TV Shows|/{version}/tv/{id}          |GET   |Get-FanartTVShow             |N/A    |Yes     |     |
|Music   |/{version}/music/{id}       |GET   |Get-FanartTVMusic            |N/A    |Yes     |     |
|Music   |/{version}/music/albums/{id}|GET   |Get-FanartTVMusic            |N/A    |Yes     |     |
|Music   |/{version}/music/labels/{id}|GET   |Get-FanartTVMusic            |N/A    |Yes     |     |
|Latest  |/{version}/movies/latest    |GET   |Get-FanartTVLatest           |N/A    |Yes     |     |
|Latest  |/{version}/tv/latest        |GET   |Get-FanartTVLatest           |N/A    |Yes     |     |
|Latest  |/{version}/music/latest     |GET   |Get-FanartTVLatest           |N/A    |Yes     |     |
|Internal|                            |POST  |Add-FanartTVAPIKey           |N/A    |Yes     |     |
|Internal|                            |POST  |Request-FanartTVAccessToken  |N/A    |Yes     |     |
|Internal|                            |POST  |Add-FanartTVBaseURI          |N/A    |Yes     |     |
|Internal|                            |PUT   |ConvertTo-FanartTVQueryString|N/A    |Yes     |     |
|Internal|                            |PATCH |Export-FanartTVModuleSettings|N/A    |Yes     |     |
|Internal|                            |GET   |Get-FanartTVAccessToken      |N/A    |Yes     |     |
|Internal|                            |GET   |Get-FanartTVAPIKey           |N/A    |Yes     |     |
|Internal|                            |GET   |Get-FanartTVBaseURI          |N/A    |Yes     |     |
|Internal|                            |GET   |Get-FanartTVModuleSettings   |N/A    |Yes     |     |
|Internal|                            |GET   |Import-FanartTVModuleSettings|N/A    |Yes     |     |
|Internal|                            |GET   |Invoke-FanartTVRequest       |N/A    |Yes     |     |
|Internal|                            |DELETE|Remove-FanartTVAPIKey        |N/A    |Yes     |     |
|Internal|                            |DELETE|Remove-FanartTVBaseURI       |N/A    |Yes     |     |
|Internal|                            |DELETE|Remove-FanartTVModuleSettings|N/A    |Yes     |     |
|Internal|                            |GET   |Test-FanartTVAPIKey          |N/A    |Yes     |     |
