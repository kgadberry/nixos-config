{ lib, pkgs, config, ... }:

let
    ignorePatterns = ''
        !.env*
        !.github/
        !.gitignore
        !*.tfvars
        .terraform/
        .target/
        /Library/'';

    definitions = lib.attrNames (
        lib.filterAttrs
        (filename: kind:
            filename != "default.nix"
            && (kind == "regular" || kind == "directory")
        )
        (builtins.readDir ./.)
    );

    fragments = map (file: import ./${file} { inherit pkgs lib ignorePatterns; }) definitions;

    merged = lib.foldl' (acc: frag: lib.recursiveUpdate acc frag) {} fragments;
in
{
    config = let
        userCfg = {
            home.packages = merged.packages or [];
            home.file = merged.homeFiles or {};
            home.sessionVariables = merged.sessionVariables or {};
            home.shellAliases = merged.shellAliases or {};
            programs = merged.programs or {};
        };
    in {
        home-manager.users.${config.user} = lib.mkMerge [ userCfg ];
    };
}

