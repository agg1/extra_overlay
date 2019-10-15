# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit autotools toolchain-funcs

DESCRIPTION="Systrace is a computer security utility which limits an application's access to the system by enforcing access policies for system calls."
HOMEPAGE="http://www.citi.umich.edu/u/provos/systrace/"
SRC_URI="http://www.citi.umich.edu/u/provos/systrace/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
#CFLAGS="-Os"

RDEPEND="dev-libs/libevent"
DEPEND="${RDEPEND}"

RESTRICT="test"

src_prepare() {
	eapply "${FILESDIR}/systrace-1.6f.patch"
	eapply "${FILESDIR}/systrace-musl.patch"
	eapply_user
	eautoreconf
}

src_configure() {
	econf
}

src_compile() {
	emake
}

src_install() {
	dobin systrace
	doman systrace.1
	dodoc README
	newdoc ChangeLog CHANGES
}
