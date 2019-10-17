  {}:
with (import (builtins.fetchTarball {
  url = "https://github.com/dmjio/miso/archive/1114ba461605cef11ef4e1a96b5adfc4b4c9af18.tar.gz";
  sha256 = "03x323yjpx3wq87kb2i202cw6sxj3sb79j4h712jiv4yd993gjlz";
}) {});
let
  inherit (pkgs) runCommand closurecompiler;
  inherit (pkgs.haskell.packages) ghcjs86;
  client = clientDrv.callCabal2nix "tomlerone" ./. {};

  # project derivation.
  clientDrv = ghcjs86.extend (pkgs.haskell.lib.packageSourceOverrides {
    tomland = builtins.fetchTarball "https://github.com/kowainik/tomland/archive/09bf050a3e964ef137e1f96de76f17ac2b6198b4.tar.gz";
    parser-combinators = builtins.fetchTarball "https://github.com/mrkkrp/parser-combinators/archive/7996964b0f4da5adfed5768656e2f1e47cebe659.tar.gz";
    });
in
  runCommand "tomlerone" { inherit client; } ''
    mkdir -p $out/static
    ${closurecompiler}/bin/closure-compiler --compilation_level ADVANCED_OPTIMIZATIONS \
      --jscomp_off=checkVars \
      --externs=${client}/bin/client.jsexe/all.js.externs \
      ${client}/bin/client.jsexe/all.js > temp.js
    mv temp.js $out/static/all.js
  ''
