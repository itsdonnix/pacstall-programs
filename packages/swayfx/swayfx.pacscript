pkgname="swayfx"
repology=("project: swayfx")
pkgver="0.5.3"
pkgdesc="SwayFX: Sway, but with eye candy!"
arch=("amd64")
license=("MIT")
maintainer=("<YOUR_NAME> <YOUR_EMAIL>")
source=("https://github.com/WillPower3309/swayfx/archive/refs/tags/${pkgver}.tar.gz")
sha256sums=("5bbec69f8d1b58e52aa41e9f6f415cd2c3e4bfd9fdc881aa44867f07897f5dd5")
makedepends=("meson" "ninja-build" "pkg-config" "scdoc")
depends=("libcairo2-dev" "libpango1.0-dev" "libwayland-dev" "libinput-dev" "libxkbcommon-dev" "libdrm-dev" "libevdev-dev" "libpixman-1-dev" "libjson-c-dev" "libpcre2-dev" "libxcb1-dev" "libxcb-icccm4-dev" "libgdk-pixbuf-2.0-dev" "wlroots-0.19" "scenefx-0.4")

prepare() {
  cd "${pkgname}-${pkgver}"
  meson setup build -Dwerror=false
}

build() {
  cd "${pkgname}-${pkgver}"
  ninja -C build -j"${NCPU}"
}

package() {
  cd "${pkgname}-${pkgver}"
  DESTDIR="${pkgdir}" ninja -C build install
}
