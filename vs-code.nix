{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      yzhang.markdown-all-in-one
      vscjava.vscode-java-pack
      arrterian.nix-env-selector
    ];
    profiles.default.userSettings = {
      "python.analysis.typeCheckingMode" = "standard";
      "python.analysis.autoImportCompletions" = true;
      "vim.useSystemClipboard" = true;
      "vim.handleKeys" = {
        "<C-p>" = false;
      };
      "vim.normalModeKeyBindingsNonRecursive" = [
        {
          "before" = [
            "<space>"
            "f"
            "f"
          ];
          "after" = [
            "<cmd>"
            "workbench.action.quickOpen"
            "<cr>"
          ];
        }
      ];
    };
  };
}
