{ config, pkgs, lib, ... }: {

    environment.systemPackages = with pkgs; [
        python3
        python3Packages.virtualenv
        python3Packages.pip
    ];

}