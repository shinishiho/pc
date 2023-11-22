# Bringing my Personal Computer everywhere

## Introduction

Note: You are on the Windows branch.

For some reasons, I am never satisfied with one OS or another. Someday I wake up, see a random YouTuber reviewing a beatiful distro of Linux, I may switch immediately without thinking twice.

Then it broke. I go back to Windows, again, but it no longer feels like home.

The goal of this repo is to make a `dotfiles` equivalent for every OS I use. I am dual booting Arch and Windows on my poor laptop, and I have a Mac Mini at home. Ultimately I will be able to sync my preferences across all of my devices.

This repo contains tools from various people on GitHub that made my live easier. You can find a list of them [here.](#tools-used) Please refer to the guides of each one for more information.

## Features

### Windows (Powershell)

1. Install tweaks from winutil.
2. Install AtlasOS (default Playbook).
3. Install apps using winget.
4. Install Office 365 and run activate script (can activate MSOffice and Windows).
5. Restore and backup configs (for Powershell, VSCode, Neovim, etc).

## Usage

You can fork my repository, check out the data and config folder and [make your own customization](#customization).

* How to use

  1. Clone the repo (you should fork this repo and clone yours):

     ```powershell
     git clone https://github.com/shinishiho/pc.git -b win win
     cd win\scripts
     .\run.ps1
     ```

  2. Follow on-screen instructions.
  3. Enjoy your beloved home. (It is recommended to restart your computer after the script finishes)

* For someone with a custom domain name, you can set your DNS setting to the raw link of [this file](./scripts/get.ps1), and then invoke this script using a fancy, short command (replace with your own domain):

   ```powershell
   iex(irm win.shinishiho.cyou)
   ```

## Customization

Here are what you can change according to your needs:

   1. Config folder: You can throw whatever config for the apps you use there. Then tell the script where those config files belong to by editing [this file.](./data/config_paths.json)
   2. Data folder: We currently have
      * [fonts](./data/fonts): You can put your favorite fonts here and they will be installed.
      * [themes](./data/themes): Theming for Windows (basic theming, no external software required). You can save your wallpapers, cursors, system icons, color schemes here.
      * [apps](./data/apps.json): A list of apps to be installed using winget.
   3. Scripts: 
      * [get.ps1](./scripts/get.ps1): Edit your repo link here.
      * [run.ps1](./scripts/run.ps1): Personalize the banner to your name, ~~or you can just throw it away~~.

## Tools used

Here is the list of what are included in the scripts. Big thanks to the authors of these tools.

   1. [AtlasOS](https://github.com/atlas-os/) by AtlasOS
   2. [Microsoft-Activation-Scripts](https://github.com/massgravel/Microsoft-Activation-Scripts) by Massgravel
   3. [winutil](https://github.com/ChrisTitusTech/winutil) by Christitus
   4. [winget](https://github.com/microsoft/winget-cli) by Microsoft
   5. [winget-install](https://github.com/asheroto/winget-install) by asheroto
