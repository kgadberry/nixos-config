{ config, pkgs, lib, ... }: {

    environment.systemPackages = with pkgs; [
        libgcc
        gnat
	    gnumake
        cmake
        gdb
    ];
}
