with (import <nixpkgs> { });
derivation {
  name = "tokyonight-theme";
  version = "1.5.4";
  builder = "${bash}/bin/bash";
  args = [
    "-c"
    ''
      set -xe
      export PATH=$PATH:${coreutils}/bin;
      mkdir -p $out/share/{themes, icons}
      cp -rv $src/themes $out/share/
      cp -rv $src/icons $out/share/
    ''
  ];
  system = builtins.currentSystem;
  src = fetchFromGitHub {
    owner = "Fausto-Korpsvart";
    repo = "Tokyo-Night-GTK-Theme";
    rev = "a25fd5e82c2ef534a021e2f75b6134f3562ef77e";
    sha256 = "sha256-AeAG60zOyE4Uyw6YDGlk9NyI+iaZpilaGl8OCsX9vE8=";
  };

}
