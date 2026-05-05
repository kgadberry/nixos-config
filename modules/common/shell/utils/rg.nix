{ ignorePatterns, ... }:

{
    programs.ripgrep.enable = true;
    programs.rgignore = ignorePatterns;
}
