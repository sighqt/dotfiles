{ pkgs, inputs, ... }:

let
  cursorName = "Adwaita";
  cursorPkg = pkgs.adwaita-icon-theme;
  cursorSize = 20;
in
{
  home.username = "sighqt";
  home.homeDirectory = "/home/sighqt";

  home.packages = with pkgs; [
    home-manager
    wl-clipboard
    brave
    kitty
    obsidian
    # shell
    zsh
    oh-my-zsh
    fastfetch
    # comms
    telegram-desktop
    # code
    docker
    git
    helix
    reaper
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        bbenoist.nix # nix syntax highlighting
        rust-lang.rust-analyzer
        vadimcn.vscode-lldb # lldb for rust
        pkief.material-product-icons
        tamasfe.even-better-toml
        esbenp.prettier-vscode
        ms-vsliveshare.vsliveshare
        vscodevim.vim
        piousdeer.adwaita-theme
        dracula-theme.theme-dracula
        zhuangtongfa.material-theme
        file-icons.file-icons
        eamodio.gitlens # git lens
        ms-python.python
      ];
    })
    # nil # nix lsp for Helix
    # studio
    obs-studio
    ffmpeg # video formatter
    v4l-utils
    gphoto2
    #    fix kernel header vvvvvvvvvv
    # linuxKernel.packages.linux_5_15.vrl2loopbacko
    gnomeExtensions.dash-to-dock
    gnomeExtensions.color-picker
    gnomeExtensions.pop-shell
    gnomeExtensions.user-themes
    tlp
    auto-cpufreq
    discord
    xdg-desktop-portal
    xdg-desktop-portal-gnome
    blender
    steam
    libreoffice
    kitty-themes
  ];
  
  programs.kitty = {
    enable = true;
    shellIntegration = {
      mode = "no-cursor";
      enableZshIntegration = true;
    };
    themeFile = "GruvboxMaterialDarkMedium";
    font.name = "JetBrainsMono Nerd Font";
    settings = {
      # The window padding (in pts) (blank area between the text and the window border).
      # A single value sets all four sides. Two values set the vertical and horizontal sides.
      # Three values set top, horizontal and bottom. Four values set top, right, bottom and left.
      window_padding_width = "8 0 8 8"; # extra padding for oh-my-zsh dst theme
      hide_window_decorations = true;
      cursor_shape = "block";
    };
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "gruvbox_material_dark_medium";
      editor = {
        cursor-shape = {
          insert = "underline";
          normal = "block";
          select = "block";
        };
        statusline = {
          mode = {
            insert = "INSERT";
            normal = "NORMAL";
            select = "SELECT";
          };
        };
        indent-guides = {
          render = true;
          character = "|";
        };
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
      };
    };
    themes = inputs.helix-themes.outputs.themes;
  };

  # zsh & oh-my-zsh configurations
  programs.zsh = {
    enable = true;
  };
  programs.zsh.oh-my-zsh = {
    enable = true;
    plugins = [ "git" ];
    theme = "dst";
  };

  programs.git = {
    enable = true;
    userName = "sighqt";
    userEmail = "sighqt@gmail.com";
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = cursorName;
      package = cursorPkg;
      size = cursorSize;
    };
    iconTheme = {
      name = "Gruvbox-Plus-Dark";
      package = pkgs.gruvbox-plus-icons;
    };
     theme = {
       name = "gruvbox-dark";
       package = pkgs.gruvbox-gtk-theme;
     };
    gtk3.extraConfig = {
      "gtk-application-prefer-dark-theme" = true;
    };
    gtk4.extraConfig = {
      "gtk-application-prefer-dark-theme" = true;
    };
  };
  home.sessionVariables.GTK_THEME = "Gruvbox-Dark";
  dconf.settings = {
    # shell extensions 
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        # "dash-to-dock@micxgx.gmail.com"        
        "pop-shell@system76.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
      ];
    };
    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-fixed = true;
      dock-position = "LEFT";      
      extend-height = false;
      show-trash = false;
      show-mounts-only-mounted = false;
      disable-overview-on-startup = true;
    };
    "org/gnome/shell/extensions/user-theme" = {
      name = "gruvbox-dark";
    };

    # keybindings
    "org/gnome/shell/keybindings" = {
      toggle-quick-settings = []; # turn off focus power menu
      toggle-message-tray = ["<Super>n"];
      focus-active-notification = [];
    };
    "org/gnome/desktop/wm/keybindings" = {
      close = ["<Super>q"];
      minimize = [];
      maximize = [];
      toggle-maximized = ["<Super>m"];
      # workspace/monitor settings
      switch-to-workspace-left = ["<Alt>h"];
      switch-to-workspace-right = ["<Alt>l"];
      move-to-workspace-left = ["<Shift><Alt>h"];
      move-to-workspace-right = ["<Shift><Alt>l"];
      move-to-monitor-down = [];  # handled by pop-shell
      move-to-monitor-left = [];  #
      move-to-monitor-right = []; #
      move-to-monitor-up = [];    #
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      screensaver = []; # turn off lock screen
    };
  };

  home.pointerCursor = {
    name = cursorName;
    package = cursorPkg;
    size = cursorSize;
    gtk.enable = true;
    x11.enable = true;
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.
}


