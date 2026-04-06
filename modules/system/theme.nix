{ pkgs, ... }:

# System-wide theming via Stylix (base16).
# Change base16Scheme to retheme everything at once — terminal, editor, GTK, bar.
#
# ── Bundled (themes/*.yaml) ──────────────────────────────────────────
#   ../../themes/nes.yaml         NES hardware palette  ← DEFAULT
#
# ── From nixpkgs base16-schemes ─────────────────────────────────────
#   "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml"
#   "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml"
#   "${pkgs.base16-schemes}/share/themes/nord.yaml"
#   "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml"
#   "${pkgs.base16-schemes}/share/themes/rose-pine.yaml"
#   "${pkgs.base16-schemes}/share/themes/kanagawa.yaml"
#
# Browse all: https://github.com/tinted-theming/schemes

{
  stylix = {
    enable = true;

    # Wallpaper — drop .png files into wallpapers/ and update this path.
    image = ../../wallpapers/emerald-07.png;

    base16Scheme = ../../themes/nes.yaml;

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name    = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name    = "Noto Sans";
      };
      serif = {
        package = pkgs.noto-fonts;
        name    = "Noto Serif";
      };
      sizes = {
        terminal     = 13;
        applications = 12;
      };
    };

    # Stylix auto-themes: alacritty, waybar, hyprland, gtk, qt, mako, bat, etc.
    targets = {
      gtk.enable = true;
      qt.enable  = true;
    };
  };
}
