{ config, pkgs, lib, unstable, ... }: {

    environment.systemPackages = with pkgs; [
        jdk21_headless
        maven
        unstable.gradle_9
    ];

}