{
  config,
  lib,
  pkgs,
  ...
}: {
  # enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  imports = [
  ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "nixos"; # Define your hostname.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  fileSystems."/media/secondary_drive" = {
    device = "/dev/disk/by-uuid/3c94cd16-d257-4584-9913-84dced3680b7"; # Replace with your UUID
    fsType = "ext4";
    options = ["defaults" "nofail" "x-systemd.automount"];
  };

  services = {
    # Enable CUPS to print documents.
    printing.enable = true;
    pulseaudio.enable = false;

    # Enable sound with pipewire.
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    syncthing = {
      enable = true;
      openDefaultPorts = true;
      #settings = {
      #  gui = {
      #    user = "myuser";
      #    password = "mypassword";
      #  };
      #  devices = {
      #    "device1" = { id = "DEVICE-ID-GOES-HERE"; };
      #    "device2" = { id = "DEVICE-ID-GOES-HERE"; };
      #  };
      #  folders = {
      #    "Documents" = {
      #      path = "/home/myusername/Documents";
      #      devices = [ "device1" "device2" ];
      #    };
      #    "Example" = {
      #      path = "/home/myusername/Example";
      #      devices = [ "device1" ];
      #      ignorePerms = false; # Enable file permission syncing
      #    };
      #  };
      #};
    };

    i2p.enable = true;

    #ollama = {
    #  enable = true;
    #  package = pkgs.ollama-cuda;
    #  loadModels = ["llama4:latest" "deepseek-v3:latest" "qwen3.5:35b"];
    #};
    #open-webui.enable = true;

    # services.nginx = {
    #   enable = true;
    #   recommendedProxySettings = true;
    #   virtualHosts."localhost" = {
    #     # no enableACME or forceSSL
    #     locations."/" = {
    #       proxyPass = "http://127.0.0.1:12345";
    #       proxyWebsockets = true;
    #     };
    #   };
    # };
  };

  security.rtkit.enable = true;

  security.acme = {
    acceptTerms = true;
    defaults.email = "willem@vanzwol.com";
  };

  hardware.bluetooth.enable = true;

  virtualisation.docker.enable = true;

  environment.localBinInPath = true;
  environment.sessionVariables.QT_NO_KDE_WALLET = "1"; # use default GNOME keyring not K Wallet

  #services.docker = {
  #  enable = true;
  #  extraOptions = "--add-runtime nvidia=/usr/bin/nvidia-container-runtime";
  #};

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  programs.steam.enable = true;
  programs.localsend.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  programs.nix-ld.enable = true;

  # for evolution email (if it doesn't work remove this)
  services.gnome.gnome-keyring.enable = true;

  systemd.tmpfiles.rules = [
    "d /etc/nixos 0755 willemvz users -"
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.willemvz = {
    isNormalUser = true;
    description = "Willem Van Zwol";
    extraGroups = ["networkmanager" "docker" "wheel"];
  };

  networking.extraHosts = ''
    10.200.1.1 power-puff-praise.whitcloud.org
  '';
  networking.nameservers = ["1.1.1.1" "8.8.8.8"];

  networking.firewall = {
    enable = true;
    #allowedTCPPorts = [];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    corefonts
    vista-fonts
    wineWowPackages.fonts
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
