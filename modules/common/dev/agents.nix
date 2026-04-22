{ pkgs, inputs, ... } : {
  
    environment.systemPackages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
    claude-code
    # code
    # goose-cli
    # kilocode-cli
    # localgpt
    # git-surgeon
    # gno
    # nono
    # rtk
  ];
}