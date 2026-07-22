pkgname="swayfx"
repology=("project: swayfx")
pkgver="0.5.3"
pkgdesc="SwayFX: Sway, but with eye candy!"
arch=("amd64")
license=("MIT")
maintainer=("<YOUR_NAME> <YOUR_EMAIL>")
source=(
  "https://github.com/WillPower3309/swayfx/archive/refs/tags/${pkgver}.tar.gz"
  "scenefx::https://github.com/wlrfx/scenefx.git#tag=0.4.1"
  "wlroots::https://gitlab.freedesktop.org/wlroots/wlroots.git#tag=0.19.0"
)
sha256sums=(
  "e6345e198f128520cf422b458ac8ad9759c3a6c8f633d7b722655309f8a14b9e"
  "SKIP"
  "SKIP"
)
makedepends=("meson" "ninja-build" "pkg-config" "cmake" "git" "scdoc")
depends=("wayland-protocols" "libwayland-dev" "libpcre2-dev" "libjson-c-dev" "libpango1.0-dev" "libcairo2-dev" "libgdk-pixbuf-2.0-dev" "libdrm-dev" "libgbm-dev" "libinput-dev" "libseat-dev" "libxkbcommon-dev" "libxcb-dri3-dev" "libxcb-present-dev" "libxcb-res0-dev" "libxcb-render-util0-dev" "libxcb-ewmh-dev" "libxcb-icccm4-dev" "libliftoff-dev" "libdisplay-info-dev" "liblcms2-dev" "libpixman-1-dev" "libgles2-mesa-dev")

prepare() {
  cd "${pkgname}-${pkgver}"

  mkdir -p subprojects
  mv "${srcdir}/scenefx" subprojects/scenefx
  mv "${srcdir}/wlroots" subprojects/wlroots

  PKG_CONFIG_LIBDIR="/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib/pkgconfig:/usr/share/pkgconfig" \
    LDFLAGS="${LDFLAGS:+${LDFLAGS} }-Wl,--disable-new-dtags,-rpath,/usr/local/lib/x86_64-linux-gnu" \
    meson setup build \
    -Dwerror=false \
    --force-fallback-for=scenefx,wlroots
}

build() {
  cd "${pkgname}-${pkgver}"
  ninja -C build -j"${NCPU}"
}

package() {
  cd "${pkgname}-${pkgver}"
  DESTDIR="${pkgdir}" ninja -C build install
}
