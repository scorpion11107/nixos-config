{ config, pkgs, ... }:

{
  # Disable PulseAudio (we use PipeWire)
  services.pulseaudio.enable = false;

  # Enable real-time scheduling for audio
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;	# needed for 32-bit
    pulse.enable = true;	# PulseAudio compatibility
    jack.enable = true;		# JACK compatibility
    wireplumber.enable = true;
  };
}
