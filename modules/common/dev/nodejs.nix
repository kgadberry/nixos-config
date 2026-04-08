{ config, pkgs, lib, ... }: {

    environment.systemPackages = with pkgs; [
        nodejs
        nodePackages.yarn
        nodePackages.npm
        nodePackages.typescript
    ];

}