with (import ../appimage.nix);
appimagePackage {
  binName = "lunarclient";
  version = "2.15.1";
  url =
    "https://launcherupdates.lunarclientcdn.com/Lunar%20Client-2.15.1.AppImage";
  sha256 = "f05ea29cb72d34b0ab4ef3bf7f82161dc9699bfeafa96e3834a6dcb74129a78b";
}
