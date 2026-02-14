{ config, pkgs, lib, ... }: {

    environment.systemPackages = with pkgs; [
        (python3.withPackages(p: with p; [
            pyyaml
            jinja2
            pyserial
            matplotlib
            pandas
            scipy
        ]))
    ];

}