pkgname="earlyoom-git"
gives="earlyoom"
pkgver="1.9.0"
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

# Return 0 if systemd appears to be running in this environment.
_has_systemd() {
  # systemctl binary must exist and a systemd run-time dir present
  if command -v systemctl > /dev/null 2>&1 && [[ -d /run/systemd/system ]]; then
    return 0
  fi
  # fallback: check whether PID 1 is systemd
  if [[ -r /proc/1/comm ]] && grep -q '^systemd$' /proc/1/comm 2> /dev/null; then
    return 0
  fi
  return 1
}

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

  if _has_systemd; then
    make SYSTEMDUNITDIR="$(pkgconf --variable=systemdsystemunitdir systemd)" install
  else
    # In non-systemd environments install the sysv/openrc initscript instead
    make install-initscript
  fi
}

post_install() {
  if _has_systemd; then
    # Only run systemctl management when systemd is active
    systemctl daemon-reload || true
    systemctl enable --now earlyoom || true
  else
    fancy_message info "Systemd is not available, skipping service management"
  fi
}

pre_remove() {
  if _has_systemd; then
    systemctl stop earlyoom || true
    systemctl disable earlyoom || true
  else
    fancy_message info "Systemd is not available, skipping service management"
  fi
}

post_remove() {
  if _has_systemd; then
    systemctl daemon-reload || true
  else
    fancy_message info "Systemd is not available, skipping daemon-reload"
  fi
}
