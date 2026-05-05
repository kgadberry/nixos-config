{ config, pkgs, lib, ... }: {
    options.desktop.gdm.enable = lib.mkEnableOption "GNOME with GDM display manager";

    config = lib.mkIf (config.gui.enable && config.desktop.gdm.enable) {
        services.displayManager.gdm.enable = true;
        services.desktopManager.gnome.enable = true;
        security.pam.services.gdm.enableGnomeKeyring = true;

        environment.systemPackages = with pkgs; [
            gedit
        ];
    };
}