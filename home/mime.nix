{ ... }:

{
  # Default applications — xdg-open uses these.
  # Change to whatever you prefer.

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # Web
      "text/html"             = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";

      # Files
      "inode/directory" = "org.gnome.Nautilus.desktop";

      # Images — imv is installed; eog is not
      "image/png"    = "imv.desktop";
      "image/jpeg"   = "imv.desktop";
      "image/gif"    = "imv.desktop";
      "image/webp"   = "imv.desktop";
      "image/svg+xml" = "imv.desktop";

      # Video
      "video/mp4"          = "mpv.desktop";
      "video/mkv"          = "mpv.desktop";
      "video/webm"         = "mpv.desktop";
      "video/x-matroska"   = "mpv.desktop";

      # Audio
      "audio/mpeg" = "mpv.desktop";
      "audio/flac" = "mpv.desktop";
      "audio/ogg"  = "mpv.desktop";

      # Documents
      "application/pdf"  = "firefox.desktop";

      # Archives — nautilus handles these without a separate archive manager
      "application/zip"   = "org.gnome.Nautilus.desktop";
      "application/x-tar" = "org.gnome.Nautilus.desktop";

      # Text / code
      "text/plain"    = "nvim.desktop";
      "text/markdown" = "nvim.desktop";
    };
  };
}
