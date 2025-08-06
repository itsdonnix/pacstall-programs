pkgname="earlyoom-git"
gives="earlyoom"
pkgver="1.8.2"
breaks=("earlyoom")
arch=("any")
url="https://github.com/rfjakob/earlyoom"
license=("MIT")
pkgdesc="Userspace out-of-memory (OOM) killer for Linux"
section=("admin")
depends=(
  'init-system-helpers>=1.54~'
)
makedepends=(
  'pkgconf'
  'pandoc'
)
source=("https://github.com/rfjakob/earlyoom.git")
sha256sums=("SKIP")
maintainer=("Don Alfons <donnisnoni@outlook.com>")

build() {
  cd "earlyoom"
  make -j"${NCPU}" \
    PREFIX="/usr" \
    VERSION="${pkgver}"
}

package() {
  cd "earlyoom"
  export PREFIX="/usr"
  export DESTDIR="${pkgdir}"
  export VERSION="${pkgver}"

  if command -v systemctl &> /dev/null; then
    make SYSTEMDUNITDIR="$(pkgconf --variable=systemdsystemunitdir systemd)" install
  else
    make install-initscript
  fi
}

post_install() {
  if command -v systemctl &> /dev/null; then
    systemctl daemon-reload
    systemctl enable --now earlyoom
  else
    fancy_message info "Systemd is not available, skipping service management"
  fi
}

pre_remove() {
  if command -v systemctl &> /dev/null; then
    systemctl stop earlyoom
    systemctl disable earlyoom
  else
    fancy_message info "Systemd is not available, skipping service management"
  fi
}

post_remove() {
  if command -v systemctl &> /dev/null; then
    systemctl daemon-reload
  else
    fancy_message info "Systemd is not available, skipping daemon-reload"
  fi
}
