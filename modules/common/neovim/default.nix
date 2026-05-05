{ lib, ... }: {
    imports = let
        defs = lib.attrNames (lib.filterAttrs
            (n: k: n != "default.nix" && k == "regular")
            (builtins.readDir ./.));
    in map (f: ./${f}) defs;
}
