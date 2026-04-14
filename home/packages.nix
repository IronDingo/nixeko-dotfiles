{ pkgs, ... }:

{
  home.packages = with pkgs; [

    # Terminal utilities
    bat
    btop
    eza
    fastfetch
    fd
    jq
    ripgrep
    tldr
    tree

    # Editors
    sublime4

    # Development
    gcc
    github-cli
    go
    mise
    nodejs
    python3
    ruff
    rustup
    pyright
    gopls
    rust-analyzer
    lua-language-server
    typescript-language-server

    # Containers
    lazydocker
    docker-compose

    # Networking
    tcpdump
    wget
    whois
    openbsd-netcat
    rsync

    # Media
    ffmpeg
    handbrake
    imagemagick
    imv
    mpv
    obs-studio
    yt-dlp

    # Wayland / Hyprland ecosystem
    grim
    hypridle
    hyprlock
    hyprpicker
    mako
    slurp
    swayosd
    wl-clipboard
    wl-clip-persist
    wayfreeze
    wiremix

    # GUI apps
    evince
    gnome-calculator
    localsend
    meld
    nautilus
    obsidian
    pinta
    signal-desktop
    spotify
    xournalpp

    # Gaming
    protonup-qt

    # Productivity
    typora

    # System tools
    brightnessctl
    exfatprogs
    inxi
    ntfs3g
    pamixer
    usbutils
    unzip

    # Arduino / embedded
    arduino-cli
    esptool

    # Launcher
    walker

    # Remote desktop
    rustdesk

    # Audio
    pwvucontrol

    # Media controls
    playerctl

    # Screenshot
    satty

    # Screen recording
    gpu-screen-recorder
  ];
}
