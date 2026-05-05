{ ignorePatterns, pkgs, ... }:

{
    packages = with pkgs; [
        ripgrep
    ];

    homeFiles.".rgignore".text = ignorePatterns;
}
