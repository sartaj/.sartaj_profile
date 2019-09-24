# .sartaj_profile

## Goals

Set up mac environmnent

## Usage

### 1 Command Install 
`cd ~; curl -#L https://github.com/sartaj/.sartaj_profile/tarball/master | tar -xzv --strip-components 1; source ~/.sartaj_profile/setup.sh`

### Configuration

The `apps-and-preferences` folder are where you can change apps.

### Shell Setup

In shell profile (`.bash_profile`, `.zshrc`), add the following:

```bash
source ~/.sartaj_profile/.index
```
