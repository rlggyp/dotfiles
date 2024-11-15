{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "rlggyp";
  home.homeDirectory = "/home/rlggyp";
  targets.genericLinux.enable = true;
  nixpkgs.config.allowUnfree = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    pfetch
    nodejs
    bun
    librewolf
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".zprofile".text = ''
      # automatically startx when login on tty1
      if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
      	startx
      fi
    '';
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/rlggyp/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
		EDITOR = "nvim";
		VISUAL = "nvim";
		_JAVA_AWT_WM_NONREPARENTING = 1;
		_JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=gasp";
		QT_X11_NO_MITSHM = 1;
		SSH_ASKPASS="";
  };

	programs.zsh = {
		enable = true;
		enableCompletion = true;
		completionInit = "autoload -U compinit && compinit";
		shellAliases = {
			ls = "exa";
			l = "exa -al -g";
			sxiv = "sxiv -Z -s f -r";
      feh = "feh -ZFqxr -B Black";
			vim = "nvim";
			cat = "bat --theme=tokyonight_night --style=plain --paging=never";
			bat = "bat --theme=tokyonight_night --style=plain --paging=never";
			rg = "rg --color=never";
			".." = "cd ..";
		};
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
	};

	programs.starship = {
    enable = false;
    settings = {
      add_newline = false;
      format = lib.concatStrings [
				"$directory"
				"$git_branch"
				"$git_status"
				"$character"
			];
			directory = {
				truncation_length = 1;
			};
			git_branch = {
				format = "[$branch]($style) ";
				style = "bold red";
			};
			git_status = {
				style = "bold yellow";
			};
    };
  };

	programs.tmux = {
		enable = true;
		mouse = true;
		newSession = false;
		terminal = "xterm";
		keyMode = "vi";
		prefix = "M-s";
		extraConfig = ''
      set -g base-index 1
      setw -g pane-base-index 1
      
      set -sa terminal-overrides ",xterm*:Tc"
      
      set-window-option -g mode-keys vi
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      
      set-option -g status-position bottom
      set -g status-right ""
      set -g status-left '#{?client_prefix,#[fg=#7aa2f7],}● '
      
      set-window-option -g window-status-current-format " #I "
      set-window-option -g window-status-format " #I "
      
      set-option -g status-style bg='#1a1b26',fg='#1a1b26'
      set-option -g pane-border-style fg='#7aa2f7'
      set-option -g pane-active-border-style fg='#7aa2f7'
      set-option -g message-style bg='#1a1b26',fg='#c0caf5'
      set-option -g mode-style 'bg=blue,fg=black'
      set-window-option -g window-status-current-style bg='#7aa2f7',fg='#1a1b26'
      set-window-option -g window-status-style bg='#292e42',fg='#545c7e'
      
      bind-key -r C-Up resize-pane -U 5
      bind-key -r C-Down resize-pane -D 5
      bind-key -r C-Left resize-pane -L 5
      bind-key -r C-Right resize-pane -R 5
      
      bind-key -r f resize-pane -Z
		'';
		plugins = with pkgs.tmuxPlugins; [
			{ plugin = yank; }
			{ plugin = resurrect;
				extraConfig = ''
					set -g @resurrect-strategy-nvim 'session'
					set -g @resurrect-capture-pane-contents 'on'
				'';
			}
			{ plugin = sensible; }
			{ plugin = pain-control; }
			{ plugin = vim-tmux-navigator; }
		];
	};

  home.pointerCursor.name = "capitaine-cursors";
  home.pointerCursor.package = pkgs.capitaine-cursors;
  home.pointerCursor.x11.defaultCursor = "left_ptr";

  # Compositor Configuration (Picom)
	services.picom = {
    enable = true;
		settings =  {
		  backend = "xrender";
		  vSync = true;
			blur = false;
			blurExclude = [ ];
    };
		backend = "xrender";
		vSync = true;
    fade = true;
    fadeDelta = 4;
    shadow = false;
    shadowExclude = [ ];
    inactiveOpacity = 1;
  };

  # XDG-MIME, manage default application for specific file format
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "firefox.desktop" ];
      "text/html" = [ "firefox.desktop" ];
      "video/mp4" = [ "mpv.desktop" ];
      "video/x-matroska" = [ "mpv.desktop" ];
      "image/gif" = [ "sxiv.desktop" ];
      "image/jpeg" = [ "sxiv.desktop" ];
      "image/png" = [ "sxiv.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "image/*" = [ "sxiv.desktop" ];
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
