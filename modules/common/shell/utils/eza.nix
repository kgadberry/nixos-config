{pkgs, ...}:

{
    packages = with pkgs; [
        eza
    ];

    shellAliases = {
        ls = "eza";
    };
}