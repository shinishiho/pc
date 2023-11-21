# Bringing my Personal Computer everywhere

## Introduction

Note: You are on the Windows branch.

For some reasons, I am never satisfied with one OS or another. Someday I wake up, see a random YouTuber reviewing a beatiful distro of Linux, I may switch immediately without thinking twice.

Then it broke. I go back to Windows, again, but it no longer feels like home.

In linux, there is some kind of `dotfiles` that people can define an store all of their preferences for their machines, which is my goal for this repository.

I do not own any tools available in this repository. This is just my collection of other's great works. You can find a list of them [here.](#tools-used) Please refer to the guides for each one.

## Features

### Windows (Powershell)

1. Install tweaks from winutil.
2. Install AtlasOS (default Playbook).
3. Install apps using winget.
4. Install Office 365 and run activate script (can activate MSOffice and Windows).
5. Restore and backup configs (for Powershell, VSCode, Neovim, etc).

## Usage

You can fork my repository, check out the data and config folder and make your own customization.

* How to use
  1. Clone the repo (you should fork this repo and clone yours):

     ```powershell
     git clone https://github.com/shinishiho/pc -b win win
     cd win\scripts
     .\run.ps1
     ```

  2. Follow on-screen instructions.

* For someone with a custom domain name
You can set your DNS setting to the raw link of [this](./scripts/get.ps1), and then invoke this script using a fancy command (replace with your own domain):

   ```powershell
   iex(irm win.shinishiho.cyou)
   ```

## Tools used

Here is the list of what are included in the scripts. Big thanks to the authors of these tools.

   1. [AtlasOS](https://github.com/atlas-os/) by AtlasOS
   2. [Microsoft-Activation-Scripts](https://github.com/massgravel/Microsoft-Activation-Scripts) by Massgravel
   3. [winutil](https://github.com/ChrisTitusTech/winutil) by Christitus
   4. [winget](https://github.com/microsoft/winget-cli) by Microsoft
   5. [winget-install](https://github.com/asheroto/winget-install) by asheroto
