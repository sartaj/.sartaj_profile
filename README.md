# .sartaj_profile

Set up mac environmnent

## Command Install 

### Step 1
```bash
cd ~; curl -#L https://github.com/sartaj/.sartaj_profile/tarball/master | tar -xzv --strip-components 1; source ~/.sartaj_profile/setup.sh
```

### Step 2
After logging into Mac App Store, run the following

`bash ~/.sartaj_profile/setup/step2.sh`

### Step 3

`bash ~/.sartaj_profile/setup/step3.sh`

### Configuration

The `apps-and-preferences` folder are where you can change apps.

### Shell Setup

In shell profile (`.bash_profile`, `.zshrc`), add the following:

```bash
source ~/.sartaj_profile/.index
```
