# AGENTS

This file defines required conventions and procedures for making consistent changes in this repository.

## Scope

Use these rules for any change to host definitions, modules, options, or flake wiring.

## Architecture Rules

- Keep the import chain intact: flake -> host -> category default.nix -> feature module.
- Put shared behavior in modules/common.
- Put Linux system behavior in modules/nixos.
- Put WSL-specific behavior in modules/wsl.
- Keep hosts/<name>/default.nix focused on host-local composition and overrides.
- When creating module imports prefer file aggregation over explicit references.

## Naming and Style Rules

- New module file names: kebab-case.
- New module directories: kebab-case.
- Nix option and attribute names: camelCase.
- Use 4-space indentation.
- Use explicit multiline imports in default.nix aggregators.
- Keep comments short and purpose-driven.
    - # comments should look like this, with one leading space. the first letter of each sentence should be lowercase.

## Module Authoring Procedure

1. Choose module category before creating files.
2. Create one feature per file.
3. Define options in the module if users or hosts must configure it.
4. Use lib.mkEnableOption for booleans and lib.mkOption for typed values.
5. Guard conditional config with lib.mkIf.
6. Add the module to the category aggregator default.nix.
7. Do not hardcode user identity; consume config.user, config.fullName, config.homePath, and related options where appropriate.

## Host Authoring Procedure

1. Create hosts/<host>/default.nix using hosts/cerberus/default.nix as the baseline.
2. Import only needed categories and external modules.
3. Keep host state in the inline host block (hostName, stateVersion, networking, host-only packages).
4. Add the host to nixosConfigurations in flake.nix.
5. Verify using dry-run and then switch for that host.

## Option Hygiene

- Define options close to where they are consumed.
- Provide explicit types and descriptions.
- Give safe defaults when feasible.
- Avoid adding options that are never consumed.
- Reuse existing global options from modules/common/default.nix where possible.

## Modularity Guardrails

- Do not add shared behavior directly to a host file.
- Do not mix unrelated concerns in one module.
- Do not bypass category aggregators by ad hoc imports from distant modules.
- Do not duplicate option definitions across modules.

## Required Validation Sequence

Run from repository root after any functional change:

1. nix flake show .
2. nix flake check
3. nixos-rebuild dry-run --flake .#cerberus (or target host)
4. nixos-rebuild switch --flake .#<target-host> when ready to apply

If a command is unavailable in the current environment, record the exact command that must be run later.

## Definition of Done

A change is complete only when all items are true:

- File location matches architecture boundaries.
- Naming/style rules are respected.
- Aggregator imports are updated.
- Any new options are typed, documented, and consumed.
- Validation sequence has been run or explicitly deferred with reason.
- Documentation is updated if behavior or workflow changed.

## Current Repository Notes

- Main host is cerberus.
- Home-manager is integrated through host composition.
- WSL behavior is conditionally enabled in modules/wsl/default.nix.
- Automated upgrades and GC are configured in modules/common/update_collect-garbage.nix.
