{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      ms-dotnettools.csharp
    ];
    profiles.default.userSettings = {
      "editor.fontSize" = 14;
      "files.autoSave" = "afterDelay";
      "workbench.colorTheme" = "Dracula";
    };
  };
}
