{ lib }: {
  "org/gnome/desktop/interface" = { color-scheme = "prefer-dark"; };
  "org/gnome/shell" = {
    disable-user-extensions = false;

    # `gnome-extensions list` for a list
    enabled-extensions = [
      "user-theme@gnome-shell-extensions.gcampax.github.com"
      "Vitals@CoreCoding.com"
      "bluetooth-battery@michalw.github.com"
      "spotify-controller@koolskateguy89"
    ];

  };

  "org/gnome/shell/extensions/user-theme" = {
    # name = "some theme"
  };
  "org/gnome/desktop/input-sources" = {
    sources = [
      (lib.hm.gvariant.mkTuple [ "xkb" "pt" ])
      (lib.hm.gvariant.mkTuple [ "ibus" "mozc-jp" ])
    ];
  };
  "org/gnome/desktop/peripherals/mouse" = {
    speed = -0.8;
    natural-scroll = false;
  };
  "org/gnome/desktop/peripherals/touchpad" = {
    click-method = "areas";
    speed = 0.0;
    natural-scroll = true;
    tap-to-click = true;
    edge-scrolling-enabled = true;
    two-finger-scrolling-enabled = false;
    send-events = "enabled";
  };
}
