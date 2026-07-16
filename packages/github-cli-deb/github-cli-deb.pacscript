# CI test - this should PASS
pkgname="github-cli-deb"
gives="gh"
breaks=("${gives}-bin" "${gives}-git")
replaces=("${gives}")
pkgver="2.96.0"
arch=('arm64' 'amd64')
sha256sums_arm64=("334dd9c6704fc1656a48e475c5a3a9aa32bbadb87fa1777513bc626af4a99e89")
sha256sums_amd64=("2f54baf5f8e9d1234567890abcdef1234567890abcdef1234567890abcdef12")
source=("https://github.com/cli/cli/releases/download/v${pkgver}/${gives}_${pkgver}_linux_${CARCH}.deb")
pkgdesc="GitHub's official command line tool"
repology=("project: github-cli")
maintainer=("Oren Klopfer <oren@taumoda.com>")
