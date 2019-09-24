# .sartaj_profile

## Goals

Set up mac environmnent

## Usage

### Cloning 
`cd; curl -#L https://github.com/sartaj/.sartaj_profile/tarball/master | tar -xzv --strip-components 1; source setup/part1.sh`

### Machine Setup

Run `~/.sartaj_profile/.setup_mac_machine`

This will install a number of things, including XCode tools and nvm for Node.

### Shell Setup

In shell profile (`.bash_profile`, `.zshrc`), add the following:

```bash
source ~/.sartaj_profile/.index
```
