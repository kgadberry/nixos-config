{ config, pkgs, lib, ... }: {
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    environment.systemPackages = with pkgs; [
        gedit
    ];
}