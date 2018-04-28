# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit toolchain-funcs git-r3
#autotools

DESCRIPTION="Systrace is a computer security utility which limits an application's access to the system by enforcing access policies for system calls."
HOMEPAGE="http://www.citi.umich.edu/u/provos/systrace/"
#SRC_URI="http://www.citi.umich.edu/u/provos/systrace/${P}.tar.gz"
EGIT_REPO_URI="file:///media/DISTFILES/git/xsystrace"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-apps/systrace
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/gtk+"
DEPEND="${RDEPEND}"

RESTRICT="test"

src_prepare() {
		autoreconf --install
		default
}

src_configure() {
	econf
}

src_compile() {
	emake
}

src_install() {
    default
	insinto /usr/bin/
	newins src/notification xsystrace
	doexe ${D}/usr/bin/xsystrace
	rm -f ${D}/usr/bin/notification
	#doman xsystrace.1
}
