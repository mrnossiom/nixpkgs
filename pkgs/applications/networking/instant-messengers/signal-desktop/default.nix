{ callPackage }: builtins.mapAttrs (pname: attrs: callPackage ./generic.nix (attrs // { inherit pname; })) {
  signal-desktop = {
    dir = "Signal";
    version = "6.30.2";
    hash = "sha256-qz3eO+pTLK0J+XjAccrZIJdyoU1zyYyrnpQKeLRZvc8=";
  };
  signal-desktop-beta = {
    dir = "Signal Beta";
    version = "6.30.0-beta.2";
    hash = "sha256-EMgstKlHA6ilSlbDmsPAu/jNC21XGzF7LS7QzWcK2F0";
  };
}
