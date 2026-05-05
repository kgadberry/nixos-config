{ lib, ... }: {
    imports = let
        defs = lib.attrNames (lib.filterAttrs
            (n: k: n != "default.nix" && (k == "regular" || k == "directory"))
            (builtins.readDir ./.));
    in map (f: ./${f}) defs;
}