{
  pkgs ? import <nixpkgs> { },
}:
{
  default = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
      nixd
      nixfmt-rfc-style
    ];
  };
}
