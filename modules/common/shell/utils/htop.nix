{pkgs, ...}:

{
    packages = with pkgs; [
        htop-vim
    ];

    shellAliases = {
        top = "htop";
    };
}