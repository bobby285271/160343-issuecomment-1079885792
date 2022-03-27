let
  pkgs = import <nixpkgs> { };

  testSrc = pkgs.writeText "test.c" ''
    #include <glib.h>

    int main() {
        g_warning_once("attribute 'clip-path' given as CSS");

        return 0;
    }
  '';
in pkgs.runCommand "glib-collate-test" {
    buildInputs = with pkgs; [
      pkg-config
      glib
      clang
    ];
  } ''
    mkdir -p $out

    clang++ \
      $(pkg-config --cflags glib-2.0 gmodule-2.0) \
      $(pkg-config --libs glib-2.0 gmodule-2.0) \
      "${testSrc}" -o "$out/test"
  ''
