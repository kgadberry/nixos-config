{ config, pkgs, lib, ... }: {

    environment.systemPackages = with pkgs; [
        libfido2
    ];

    security.pam.u2f.enable = true;
    services.udev.packages = [ pkgs.libfido2 ];
}