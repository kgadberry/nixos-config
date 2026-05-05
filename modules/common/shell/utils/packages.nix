{ pkgs, ... }:

{
    packages = with pkgs; [
        age
        bc
        delta
        dos2unix
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
