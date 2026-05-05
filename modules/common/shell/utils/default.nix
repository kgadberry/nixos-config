# utility tools and common configurations, each split into a separate file in utils/
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

    toUserCfg = frag: {
        home.packages = frag.packages or [];
        home.file = frag.homeFiles or {};
        home.sessionVariables = frag.sessionVariables or {};
        home.shellAliases = frag.shellAliases or {};
        programs = frag.programs or {};
    };
in
{
    config.home-manager.users.${config.user} = lib.mkMerge (map toUserCfg fragments);
}