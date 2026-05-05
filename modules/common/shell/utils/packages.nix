{ pkgs, ... }:

{
    packages = with pkgs; [
        age
        bc
        broot
        delta
        dos2unix
        home-manager
        inetutils
        neofetch
        nmap
        pwgen
        qrencode
        rsync
        tcpdump
        tealdeer
        tree
        unzip
        usbutils
        wget
        zip
    ];
}
