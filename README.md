# NixOS Arm/UEFI image with a linux-next kernel

> :warning: Work in progress, use at your own risk...

## Building

```bash
git clone git@github.com:Tyler-Hardin/nixos-linux-next-arm-uefi.git
cd nixos-linux-next-arm-uefi
nix build .#images.arm-uefi
```

If it fails with `Error: modDirVersion ...`, just look at the error
message -- it will tell you what you need to set version to in 
flake.nix. Sorry, it's an annoyingly manual process.

## Updating

```bash
cd nixos-linux-next-arm-uefi

# This wipes any previous local, uncommitted updates
git reset --hard HEAD
git pull

# This updates to the most recent linux-next commit.
nix flake update

# Update "version = ..." in flake.nix
$EDITOR flake.nix
```
