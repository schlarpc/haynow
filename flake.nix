{
  description = "OpenHaystack flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    heystack-nrf5x = {
      url = "github:pix/heystack-nrf5x";
      flake = false;
    };
  };

 outputs = inputs@{ self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.simpleFlake {
       inherit self nixpkgs;
       name = "haynow";
       config = { allowUnfree = true; segger-jlink.acceptLicense = true; permittedInsecurePackages = [
                "segger-jlink-qt4-810"
              ];
              }; 
       shell = { pkgs }: pkgs.mkShell { 
       
       SDK_ROOT = "${pkgs.nrf5-sdk}/share/nRF5_SDK";
       GNU_INSTALL_ROOT = "${pkgs.gcc-arm-embedded-13}";
       buildInputs = with pkgs; [ nrf-command-line-tools  gcc-arm-embedded-13 (python3.withPackages (ps: with ps; [intelhex cryptography])) ]; };
    };
}
