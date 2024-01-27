# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  # security.rngd.enable = false; //otherwise vm won't boot

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
	#./hyprland.nix
    ];
   hardware = {
	   opengl.enable = true;
	   #wayland compositors
	   #nvidia.modesetting.enable = true;
	   bluetooth.enable = true;
   };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.grub.enable = true;
  #boot.loader.grub.device = "/dev/sda";
  #boot.initrd.checkJournalingFS = false;

#swapDevices = [ {
	#device = "/var/lib/swapfile";
	#size = 16*1024;
#} ];

   networking = {
	   hostName = "nixos-P15V"; # Define your hostname.
	  # Pick only one of the below networking options.
	  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
	   networkmanager.enable = true;  # Easiest to use and most distros use this by default.
	   proxy = {
		   default = "127.0.0.1:7890";
		   noProxy = "localhost";
	   };
   };
  

nix.settings = {
	experimental-features = "nix-command flakes";
	auto-optimise-store = true;
	substituters = [ 
		"https://nix-community.cachix.org"
		"https://mirrors.ustc.edu.cn/nix-channels/store"
		"https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
	];
};


nixpkgs = {
	config = {
		allowUnfree = true;
		permittedInsecurePackages = [ "electron-25.9.0" ];
	};
};

  # Set your time zone.
  #time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     firefox
  #     tree
  #   ];
  # };

   users.users.vikrant = {
     isNormalUser = true;
     extraGroups = [ "networkmanager" "wheel" "vboxusers" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
     ];
   };



  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment = {
	   systemPackages = with pkgs; [
		kitty
		vim
		grimblast
		unar

		#libsForQt5.dolphin
		libreoffice
		#fcitx5-gtk
		#fcitx5
		#libpinyin
		#ibus
		#ibus-engines.libpinyin

		thunderbird
		vlc
		firefox
		ungoogled-chromium

		busybox
		openssh
		file
		git
		github-desktop
		python3
		gcc
		neofetch
		transmission_4-qt
		teams-for-linux
		#virtualbox
		pulseaudio

		obsidian
		steam
		discord
		#obs-studio
		freecad
		cura
		#davinci-resolve
		#blender #cuda, nvidia?
		#blender-hip #AMD
		inkscape-with-extensions
		

		#hyprland related
		waybar
		(waybar.overrideAttrs (oldAttrs : {
			mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
		})
		)
		eww-wayland
		dunst
		libnotify
		swww
		rofi-wayland
		#rofi-screenshot
		networkmanagerapplet
		brightnessctl
		sassc
		swaylock
		swayidle
		#end hyprland related
	   ];

	   sessionVariables = {
		#prompt rice baby
		#PS1="\[\033[1;31m\]\A\[\033[0m\]  \[\033[1;33m\]\u@\h\[\033[0m\]  \[\033[1;36m\]<\w>\[\033[0m\]$ ";
		#for if cursor becomes invisible
		   WLR_NO_HARDWARE_CURSORS = "1";
		#for electron apps
		   NIXOS_OZONE_WL = "1";
		 INPUT_METHOD = "fcitx";
		 GTK_IM_MODULE = "fcitx";
		 XMODIFIERS = "@im=fcitx";
		 QT_IM_MODULE = "fcitx";
		 #XIM_SERVERS=fcitx;
	   };

   };

i18n = {
	inputMethod = {
#		#fcitx5.addons = with pkgs; [ 
#			#fcitx5-chinese-addons 
#			#fcitx5-rime
#		#];
#
		enabled = "fcitx5";
		fcitx5.addons = builtins.attrValues {
			inherit (pkgs) fcitx5-chinese-addons;
		};
  	
		#enabled = "ibus";
		#ibus.engines = with pkgs.ibus-engines; [ libpinyin ];
	};

	#defaultLocale = "zh_CN.UTF-8";
};

fonts = {
	fontDir.enable = true;
	packages = with pkgs; [
		nerdfonts
		font-awesome
		google-fonts
		#noto-fonts
		#source-han-sans
		#source-han-serif
		#source-code-pro
		#hack-font
		#jetbrains-mono
	];

	fontconfig = {
      		defaultFonts = {
			emoji = [ "Noto Color Emoji" ];
			monospace = [
			  "Noto Sans Mono CJK SC"
			  "Sarasa Mono SC"
			  "DejaVu Sans Mono"
			];
			sansSerif = [
			  "Noto Sans CJK SC"
			  "Source Han Sans SC"
			  "DejaVu Sans"
			];
			serif = [
			  "Noto Serif CJK SC"
			  "Source Han Serif SC"
			  "DejaVu Serif"
			];
		};
      };
};

qt = {
	enable = true;
	platformTheme = "gtk2";
	style = "gtk2";
};

   #xdg = {
	   #portal = {
		   #enable = true;
		   #extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
	   #};
   #};
   xdg.portal.enable = true;
   xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

#set env vars
#environment.variables.EDITOR = "vim";
programs = {
	vim = {
		defaultEditor = true;
	};
	
	hyprland = {
		enable = true;
		#enableNvidiaPatches = true;
		xwayland.enable = true;
	};

	waybar.enable = true;

	thunar = {
		enable = true;
		plugins = with pkgs.xfce; [
			thunar-archive-plugin
			thunar-volman
		];
	};

	sway.enable = true;

};

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
   programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };


  security = {
	  rtkit = {
		  enable = true;
	  };
	  polkit = {
		  enable = true;
	  };
	  pam.services.waylock = {};
  };
services = {
	openssh.enable = true;
	pipewire = {
	   enable = true;
	   alsa = {
		   enable = true;
		   support32Bit = true;
	   };
	   pulse.enable = true;
	   jack.enable = true;
	};
	blueman.enable = true;
	xserver = {
	  enable = true;
	  layout = "us";
	  xkbVariant = "";
	  displayManager.sddm.enable = true;
	  libinput.enable = true;
	  #videoDrivers = [ "nvidia" ];
	};
	gvfs.enable = true; #mount, trash, etc. for thunar
	tumbler.enable = true; #image thumbnails for thunar
	automatic-timezoned.enable = true;
};
   #virtualisation = {
	   #virtualbox = {
		   #host = {
			   #enable = true;
			   ###enableExtensionPack = true; #causes frequent recompilation
		   #};
		   #guest = {
			   #enable = true;
			   #x11 = true;
		   #};
	   #};
   #};
   virtualisation.virtualbox.host.enable = true;
   users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
   system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
	system = {
		autoUpgrade = {
			enable = true;
			allowReboot = true;
		};
	};

}
