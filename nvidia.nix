{config, ...}: {
  # NVIDIA STUFF https://nixos.wiki/wiki/Nvidia

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  # services.xserver.videoDrivers = ["nvidia"];

  # Intel first, NVIDIA secondary (offload only)
  # environment.sessionVariables = {
  #   WLR_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card2";
  # };

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    powerManagement.enable = true;
  };

  hardware.nvidia.prime = {
    offload.enable = true;
    offload.enableOffloadCmd = true;

    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };
}
