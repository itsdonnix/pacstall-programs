pkgname="linux-modules-deb"
gives="linux-modules-6.16.0-061600rc5-generic"
pkgver="6.16~rc5"
buildver="6.16.0-061600rc5.202507062141"
arch=('arm64' 'amd64')
sha256sums_arm64=("85e1f496e87f525b8baa9291063fd8246328b531d1356482eed4c9c70d7916db")
sha256sums_amd64=("65fd624c3914b46060527ae7301d72cd42d52a13d5a628d1c0e2dc8e3db4f36d")
source=("https://kernel.ubuntu.com/~kernel-ppa/mainline/v${pkgver/\~/-}/${CARCH}/${gives}_${buildver}_${CARCH}.deb")
pkgdesc="Ubuntu Linux mainline kernel (Linux Modules)"
maintainer=("Oren Klopfer <oren@taumoda.com>")
