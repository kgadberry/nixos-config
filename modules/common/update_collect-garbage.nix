{ config, pkgs, ... }:

{

    # Automatic system updates
    system.autoUpgrade.enable = true;
    system.autoUpgrade.dates = "weekly";
    system.autoUpgrade.allowReboot = true;

    # Collect garbage
    nix.gc.automatic = true;
    nix.gc.dates = "weekly";
    nix.gc.options = "--delete-older-than 30d";
}