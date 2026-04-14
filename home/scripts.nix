{ username, ... }:

{
  home.file.".local/bin/power-menu" = {
    source     = ./scripts/power-menu.sh;
    executable = true;
  };

  home.file.".local/bin/docker-menu" = {
    source     = ./scripts/docker-menu.sh;
    executable = true;
  };

  home.file.".config/gtk-3.0/bookmarks".text = ''
    file:///home/${username}/Projects/nixeko-dotfiles  dotfiles
    file:///home/${username}/Documents                 Documents
    file:///home/${username}/Downloads                 Downloads
    file:///home/${username}/Syncthing-Master          Syncthing
  '';
}
