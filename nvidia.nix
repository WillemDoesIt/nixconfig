{config, ...}: {
  # NVIDIA STUFF https://nixos.wiki/wiki/Nvidia

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;

    # Buggy Experimental Settings
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;

    # activate menu app
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
