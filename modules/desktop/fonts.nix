{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    # Monospace + Nerd Fonts
    maple-mono.NF-CN
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
    nerd-fonts.symbols-only

    # Sans / serif / CJK / emoji
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    lxgw-wenkai-screen
    roboto
  ];
}
