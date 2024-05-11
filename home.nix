{ config, pkgs, ... }:

{
  #import other modules
  imports = [
	#firefox config in separate file
	./customs/firefox.nix
  ];
  
  #Add partial scaling for desktop env.
  dconf.settings = {
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
  };

  #nixpgs unfree
  nixpkgs = {
    config = {
       allowUnfree = true;
       allowUnfreePredicate = _: true;
    };
  };
  
  home = {
	username = "baptiste";
	homeDirectory = "/home/baptiste";
	shellAliases = {
		"la" = "ls -la";
	};
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
  
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
   firefox
   thunderbird
   vscode
   spotify
   discord
   inkscape-with-extensions
   python311
#   adobe-reader
   libreoffice-fresh   
   neovim
 ];
  
  #Various programs
  programs.texlive = {
	enable = true;
	extraPackages = tpkgs: { inherit (tpkgs) scheme-full; };
  };

  programs.zsh = {
	enable = true;
	enableAutosuggestions = true;
	enableCompletion = true;
	syntaxHighlighting.enable = true;
	shellAliases = {
		la = "ls -la";
		nixrebuild = "cd ~/.nix-config && nix flake update && cd && sudo nixos-rebuild switch --flake ~/.nix-config#default";
		nixhmedit = "nvim ~/.nix-config/home.nix";
	};
	zplug = {
		enable = true;
		plugins = [
		#	{ name = "dracula/zsh"; tags = ["as:theme"]; }
			{ name  = "romkatv/powerlevel10k"; tags = ["as:theme" "depth:1"]; }
		];
	};
  };

  #Define p10k theme
  home.file.".p10k.zsh" = {
  	source = ./.p10k.zsh;
  	executable = true;
  };

  programs.git = {
	enable = true;
	userEmail = "baptiste.chatelier1@gmail.com";
	userName = "Baptiste CHATELIER";
  };

  programs.btop = {
	enable = true;
  };

  #Default programs
  xdg.mimeApps = {
	enable = true;
	defaultApplications = {
		"applications/pdf" = ["org.gnome.Evince.desktop"];
		"image/png" = ["org.gnome.Loupe.desktop"];
		"image/jpg"= ["org.gnome.Loupe.desktop"];
	};
  };
  
  xdg.configFile."mimeapps.list".force = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
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
  #  /etc/profiles/per-user/baptiste/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
