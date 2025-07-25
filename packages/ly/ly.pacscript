pkgname="ly"
repology=("project: ${pkgname}")
arch=('any')
pkgver="1.1.1"
url='https://codeberg.org/fairyglade/ly'
source=("${pkgname}::https://codeberg.org/fairyglade/ly/archive/v${pkgver}.tar.gz")
sha256sums=("4d56bf14f091648b180f0d72a3b40647a175713975fb9268d4830cd8dd4184b3")
depends=("systemd")
makedepends=("build-essential" "libpam0g-dev" "libxcb-xkb-dev")
pacdeps=("zig-bin")
conflicts=("${pkgname}-git")
replaces=("lightdm" "sddm")
pkgdesc="TUI display manager"
priority='required'
maintainer=("villamorrd <villamorrd@students.nu-moa.edu.ph>")
license=('WTFPL')
external_connection=true

prepare() {
  mkdir -p "${pkgdir}/usr"
  mkdir -p "${pkgdir}/etc"
}

build() {
  cd "ly"

  zig build -j"${NCPU}"
}

package() {
  cd "ly"
  zig build -Ddest_directory="${pkgdir}" installexe
}

post_install() {
  fancy_message info "Finished installation. To enable Ly, run sudo systemctl enable ly.service"
  fancy_message info "If you need to switch between ttys after Ly's start you also have to disable getty on Ly's tty to prevent 'login' from spawning on top of it by running sudo systemctl disable getty@tty2.service"
}
