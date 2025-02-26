{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";

    linux-next = {
      url = "git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs: {
    images.arm-uefi = (nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-gnome.nix"
        ({lib, pkgs, ...}: {
          # Our custom linux-next package.
          boot.kernelPackages = pkgs.linuxPackagesFor (
            pkgs.buildLinux {
              src = inputs.linux-next;
              # TODO: Update version here after nix flake update!!!
              version = "6.14.0-rc4-next-20250226";
            }
          );

          # We have to remove zfs support, otherwise it will cause a kernel mod build failure.
          boot.supportedFilesystems = lib.mkForce [ "btrfs" "cifs" "f2fs" "jfs" "ntfs" "reiserfs" "vfat" "xfs" ];
        })
      ];
    }).config.system.build.isoImage;
  };
}
