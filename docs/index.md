---
external help file: Celerium.FanartTV-help.xml
Module Name: Celerium.FanartTV
online version: https://github.com/Celerium/Celerium.FanartTV
schema: 2.0.0
title: Home
has_children: true
layout: default
nav_order: 1
---

<h1 align="center">
  <br>
  <a href="https://FanartTV.com"><img src="https://raw.githubusercontent.com/Celerium/Celerium.FanartTV/refs/heads/main/.github/images/PoSHGallery_Celerium.FanartTV.png" alt="Celerium.FanartTV" width="200"></a>
  <br>
  Celerium.FanartTV
  <br>
</h1>

<h1 align="center">
  <br>
  <a href="https://FanartTV.com"><img src="https://raw.githubusercontent.com/Celerium/Celerium.FanartTV/refs/heads/main/.github/images/PoSHGallery_Celerium.FanartTV.png" alt="Celerium.FanartTV" width="200"></a>
  <br>
  Celerium.FanartTV
  <br>
</h1>

[![Az_Pipeline][Az_Pipeline-shield]][Az_Pipeline-url]
[![GitHub_Pages][GitHub_Pages-shield]][GitHub_Pages-url]

[![PoshGallery_Version][PoshGallery_Version-shield]][PoshGallery_Version-url]
[![PoshGallery_Platforms][PoshGallery_Platforms-shield]][PoshGallery_Platforms-url]
[![PoshGallery_Downloads][PoshGallery_Downloads-shield]][PoshGallery_Downloads-url]
[![codeSize][codeSize-shield]][codeSize-url]

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]

[![GitHub_License][GitHub_License-shield]][GitHub_License-url]

<a name="readme-top"></a>

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://fanart.tv/">
    <img src="https://raw.githubusercontent.com/Celerium/Celerium.FanartTV/refs/heads/main/.github/images/PoSHGitHub_Celerium.FanartTV.png" alt="Logo">
  </a>

  <p align="center">
    <a href="https://www.powershellgallery.com/packages/Celerium.FanartTV" target="_blank">PowerShell Gallery</a>
    ·
    <a href="https://github.com/Celerium/Celerium.FanartTV/issues/new/choose" target="_blank">Report Bug</a>
    ·
    <a href="https://github.com/Celerium/Celerium.FanartTV/issues/new/choose" target="_blank">Request Feature</a>
  </p>
</div>

---

## About The Project

The [Celerium.FanartTV](https://www.powershellgallery.com/packages/Celerium.FanartTV) PowerShell wrapper offers the ability to read much of the data within FanartTV's platform. This module serves to abstract away the details of interacting with FanartTV's API endpoints in such a way that is consistent with PowerShell nomenclature. This gives system administrators and PowerShell developers a convenient and familiar way of using FanartTV's API to create documentation scripts, automation, and integrations.

- :book: **Celerium.FanartTV** project documentation can be found on [Github Pages](https://celerium.github.io/Celerium.FanartTV/)
- :book: FanartTV's REST API documentation can be found [here](https://api.fanart.tv/#section/Fanart.tv-API-Documentation)

FanartTV features a REST API that makes use of common HTTP request methods. In order to maintain PowerShell best practices, only approved verbs are used.

- GET -> `Get-`

Additionally, PowerShell's `verb-noun` nomenclature is respected. Each noun is prefixed with `FanartTV` in an attempt to prevent naming problems.

For example, one might access the /users/ API endpoint by running the following PowerShell command with the appropriate parameters:

```posh
Get-FanartTVMovie -ID 550
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Install

This module can be installed directly from the [PowerShell Gallery](https://www.powershellgallery.com/packages/Celerium.FanartTV) with the following command:

```posh
Install-Module -Name Celerium.FanartTV
```

- :information_source: This module supports PowerShell 5.1+ and *should* work in PowerShell Core.
- :information_source: If you are running an older version of PowerShell, or if PowerShellGet is unavailable, you can manually download the *main* branch and place the latest version of *Celerium.FanartTV* from the build folder into the *(default)* `C:\Program Files\WindowsPowerShell\Modules` folder.

**Celerium.FanartTV** project documentation can be found on [Github Pages](https://celerium.github.io/Celerium.FanartTV/)

- A full list of functions can be retrieved by running `Get-Command -Module Celerium.FanartTV`.
- Help info and a list of parameters can be found by running `Get-Help <command name>`, such as:

```posh
Get-Help Get-FanartTVMovie
Get-Help Get-FanartTVMovie -Full
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Initial Setup

After installing this module, you will need to configure both the *base URI* & *API key* that are used to talk with the FanartTV API.

1. Run `Add-FanartTVBaseURI`
   - By default, FanartTV's `https://webservice.fanart.tv/v3.2` URI is used.
   - If you have your own API gateway or proxy, you may put in your own custom URI by specifying the `-BaseUri` parameter:
      - `Add-FanartTVBaseURI -BaseUri http://myapi.gateway.celerium.org`
      <br>

2. Run `Add-FanartTVAPIKey -PersonalKey 8675309`
   - It will prompt you to enter your API key if you do not specify it.
   - FanartTV API key are generated via the [FanartTV portal](https://fanart.tv/get-an-api-key/)
   - Both Personal & Project keys are supported
   <br>

3. [**optional**] Run `Export-FanartTVModuleSettings`
   - This will create a config file at `%UserProfile%\Celerium.FanartTV` that holds the *base uri* & *API key* information.
   - Next time you run `Import-Module -Name Celerium.FanartTV`, this configuration file will automatically be loaded.
   - :warning: Exporting module settings encrypts your API key in a format that can **only be unencrypted by the user principal** that encrypted the secret. It makes use of .NET DPAPI, which for Windows uses reversible encrypted tied to your user principal. This means that you **cannot copy** your configuration file to another computer or user account and expect it to work.
   - :warning: However in Linux\Unix operating systems the secret keys are more obfuscated than encrypted so it is recommend to use a more secure & cross-platform storage method.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Usage

Calling an API resource is as simple as running `Get-FanartTV<resourceName>`

- The following is a table of supported functions and their corresponding API resources:
- Table entries with [ `-` ] indicate that the functionality is **NOT** supported by the FanartTV API at this time.
- Example scripts can be found in the [examples](https://github.com/Celerium/Celerium.FanartTV/tree/main/examples) folder of this repository.

| API Resource    | Create | Read               | Update | Delete |
|---------------- |--------|--------------------|--------|--------|
| Movies          | -      | Get-FanartTVMovie  | -      | -      |
| TVShows         | -      | Get-FanartTVMovie  | -      | -      |
| Music           | -      | Get-FanartTVMovie  | -      | -      |
| Latest          | -      | Get-FanartTVMovie  | -      | -      |

Each `Get-FanartTV*` function will respond with the raw data that FanartTV's API provides.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

---

## Contributing

Contributions are what makes the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

See the [CONTRIBUTING](https://github.com/Celerium/Celerium.FanartTV/blob/master/.github/CONTRIBUTING.md) guide for more information about contributing.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## License

Distributed under the MIT license. See [LICENSE](https://github.com/Celerium/Celerium.FanartTV/blob/master/LICENSE) for more information.

[![GitHub_License][GitHub_License-shield]][GitHub_License-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[Az_Pipeline-shield]:               https://img.shields.io/azure-devops/build/AzCelerium/Celerium.FanartTV/16?style=for-the-badge&label=DevOps_Build
[Az_Pipeline-url]:                  https://dev.azure.com/AzCelerium/Celerium.FanartTV/_build?definitionId=16

[GitHub_Pages-shield]:              https://img.shields.io/github/actions/workflow/status/celerium/Celerium.FanartTV/pages%2Fpages-build-deployment?style=for-the-badge&label=GitHub%20Pages
[GitHub_Pages-url]:                 https://github.com/Celerium/Celerium.FanartTV/actions/workflows/pages/pages-build-deployment

[GitHub_License-shield]:            https://img.shields.io/github/license/celerium/Celerium.FanartTV?style=for-the-badge
[GitHub_License-url]:               https://github.com/Celerium/Celerium.FanartTV/blob/master/LICENSE

[PoshGallery_Version-shield]:       https://img.shields.io/powershellgallery/v/Celerium.FanartTV?include_prereleases&style=for-the-badge
[PoshGallery_Version-url]:          https://www.powershellgallery.com/packages/Celerium.FanartTV

[PoshGallery_Platforms-shield]:     https://img.shields.io/powershellgallery/p/Celerium.FanartTV?style=for-the-badge
[PoshGallery_Platforms-url]:        https://www.powershellgallery.com/packages/Celerium.FanartTV

[PoshGallery_Downloads-shield]:     https://img.shields.io/powershellgallery/dt/Celerium.FanartTV?style=for-the-badge
[PoshGallery_Downloads-url]:        https://www.powershellgallery.com/packages/Celerium.FanartTV

[codeSize-shield]:                  https://img.shields.io/github/repo-size/celerium/Celerium.FanartTV?style=for-the-badge
[codeSize-url]:                     https://github.com/Celerium/Celerium.FanartTV

[contributors-shield]:              https://img.shields.io/github/contributors/celerium/Celerium.FanartTV?style=for-the-badge
[contributors-url]:                 https://github.com/Celerium/Celerium.FanartTV/graphs/contributors

[forks-shield]:                     https://img.shields.io/github/forks/celerium/Celerium.FanartTV?style=for-the-badge
[forks-url]:                        https://github.com/Celerium/Celerium.FanartTV/network/members

[stars-shield]:                     https://img.shields.io/github/stars/celerium/Celerium.FanartTV?style=for-the-badge
[stars-url]:                        https://github.com/Celerium/Celerium.FanartTV/stargazers

[issues-shield]:                    https://img.shields.io/github/issues/Celerium/Celerium.FanartTV?style=for-the-badge
[issues-url]:                       https://github.com/Celerium/Celerium.FanartTV/issues
