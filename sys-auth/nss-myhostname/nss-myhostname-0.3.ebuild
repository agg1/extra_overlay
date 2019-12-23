# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit eutils

DESCRIPTION="Name Service Switch module for resolving the local hostname"
HOMEPAGE="http://0pointer.de/lennart/projects/nss-myhostname/"
SRC_URI="http://0pointer.de/lennart/projects/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm arm64 ia64 ppc sparc x86"
IUSE=""

COMMON_DEPEND=""
RDEPEND="${COMMON_DEPEND}
	!>=sys-apps/systemd-197"
DEPEND="${COMMON_DEPEND}"

src_prepare() {
	# The documentation in doc/ is just the README file in other formats
	sed -e 's:SUBDIRS *= *doc:SUBDIRS =:' -i Makefile.{am,in} ||
		die "sed failed"
	epatch "${FILESDIR}"/0001-nss-myhostname-Check-for-nss.h-presense-before-use.patch
}

src_configure() {
	econf --disable-lynx
}

pkg_postinst() {
	elog "You must modify your name service switch lookup file to enable"
	elog "nss-myhostname. To do so, add 'myhostname' to the hosts line in"
	elog "/etc/nsswitch.conf"
	elog
	elog "An example hosts line looks like this:"
	elog "hosts:      files dns myhostname"
	elog
}
