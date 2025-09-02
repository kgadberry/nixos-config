{ config, pkgs, lib, ... }: {

    environment.systemPackages = with pkgs; [
        jdk21_headless
        maven
        gradle
    ];

}