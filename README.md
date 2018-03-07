# .sartaj_profile

## Goals

Scripts to set up my dev environment on Mac machines.

## Usage

### Cloning 

Git clone to User home directory, i.e. `~`.

### Machine Setup

Copy and paste this to your terminal: 

`curl https://raw.githubusercontent.com/sartaj/.sartaj_profile/master/.setup_mac_machine | bash`

This will install a number of things, including XCode tools and nvm for Node.

### Shell Setup

In shell profile (`.bash_profile`, `.zshrc`), add the following:

```bash
source ~/.sartaj_profile/.index
```
