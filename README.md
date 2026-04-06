```
  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·
  ·                                     ·
  ·   d o t f i l e s                   ·
  ·   NixOS + Home Manager              ·
  ·   Hyprland · Stylix · home-manager  ·
  ·                                     ·
  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·
```

A clean, declarative NixOS configuration.
Edit one file, run one command, get a full desktop.

---

## what's inside

```
Compositor    Hyprland (Wayland)
Bar           Waybar
Launcher      Walker
Terminal      Alacritty
Editor        Neovim
Shell         Bash + starship + fzf + zoxide
Theming       Stylix (base16, system-wide)
Packages      home-manager
Fonts         JetBrains Mono Nerd Font
```

---

## prerequisites

- NixOS already installed (any method — minimal ISO, Calamares, whatever)
- Flakes enabled: add `experimental-features = nix-command flakes` to your nix config

---

## install

```bash
# 1. Clone
git clone https://github.com/IronDingo/nixeko-dotfiles ~/Projects/nixeko-dotfiles
cd ~/Projects/nixeko-dotfiles

# 2. Tell it who you are
#    Edit hosts/default/params.nix — takes 30 seconds
$EDITOR hosts/default/params.nix

# 3. Bring your hardware config
#    If you already have one:
cp /etc/nixos/hardware-configuration.nix hosts/default/hardware-configuration.nix
#    If starting fresh:
sudo nixos-generate-config --show-hardware-config > hosts/default/hardware-configuration.nix

# 4. Apply
sudo nixos-rebuild switch --flake .#default
```

That's it. Reboot and you're in Hyprland.

---

## params.nix — the only file you need to touch

```nix
# hosts/default/params.nix

{
  dotfiles.username = "yourname";      # your unix username
  dotfiles.hostname = "yourhostname";  # machine hostname
  dotfiles.gitName  = "Your Name";     # git commit author name
  dotfiles.gitEmail = "you@example.com";

  dotfiles.hasNvidia     = false;      # true for Intel + NVIDIA hybrid
  dotfiles.intelBusId    = "PCI:0:2:0";
  dotfiles.nvidiaBusId   = "PCI:1:0:0";

  dotfiles.hardwareModule = null;      # e.g. "dell-xps-15-9500"
                                       # see: github.com/NixOS/nixos-hardware
}
```

For NVIDIA bus IDs, run `lspci | grep -E "VGA|3D"` and convert
`00:02.0` → `PCI:0:2:0`.

---

## structure

```
dotfiles/
├── flake.nix                 entry point
├── modules/
│   ├── params.nix            option definitions (dotfiles.*)
│   └── system/
│       ├── base.nix          audio, bluetooth, docker, syncthing
│       ├── theme.nix         Stylix configuration
│       ├── networking.nix    DNS over TLS, Tailscale
│       ├── security.nix      SSH hardening, sudo
│       └── nvidia.nix        Intel + NVIDIA PRIME offload
├── hosts/
│   └── default/
│       ├── params.nix        ← edit this
│       ├── default.nix       boot, user, programs
│       └── hardware-configuration.nix   ← you provide this
├── home/
│   ├── default.nix           home-manager entry point
│   ├── packages.nix          user packages
│   ├── hyprland.nix          Hyprland + hypridle + hyprlock
│   ├── waybar.nix            bar config
│   ├── shell.nix             bash, starship, aliases
│   ├── neovim.nix            editor config
│   └── ...
├── themes/                   base16 yaml files
└── wallpapers/               .png files
```

---

## daily use

```bash
# Rebuild after any config change:
sudo nixos-rebuild switch --flake ~/Projects/nixeko-dotfiles#default

# Or use the shorthand:
./bin/apply

# Roll back if something breaks:
sudo nixos-rebuild switch --rollback

# See all generations:
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Garbage collect:
sudo nix-collect-garbage -d
```

---

## themes

Themes are Stylix base16 schemes — they apply system-wide (terminal,
Neovim, GTK, Waybar, everything).

To switch, edit `modules/system/theme.nix`:

```nix
# Bundled themes (themes/*.yaml):
base16Scheme = ../../themes/nes.yaml;

# Or from nixpkgs base16-schemes:
base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
```

Then `./bin/apply`.

Bundled themes:

```
nes.yaml            NES palette     ← default
```

Browse the full collection: [tinted-theming/schemes](https://github.com/tinted-theming/schemes)

---

## adding packages

Open `home/packages.nix` and add to the list:

```nix
home.packages = with pkgs; [
  ...
  your-package-here
];
```

Search packages: [search.nixos.org](https://search.nixos.org/packages)

Then `./bin/apply`.

---

## keybinds

```
Super + Enter               Terminal (Alacritty)
Super + Alt + Space         Launcher (walker)
Super + Shift + B           Firefox
Super + Shift + N           Neovim
Super + Shift + O           Obsidian
Super + Q                   Close window
Super + F                   Fullscreen
Super + V                   Float toggle
Super + [arrow keys]        Move focus

Super + Shift + Ctrl + V    VPN menu
Super + Shift + Ctrl + P    Pi-hole menu
Super + Shift + Ctrl + Q    Power menu
```

---

## want a guided installer instead?

See **[vessel](https://github.com/IronDingo/nixeko)** — runs from the NixOS ISO,
handles partitioning, encryption, NVIDIA detection, and config in one wizard.

---

> *It should just work. If it doesn't, open an issue.*
