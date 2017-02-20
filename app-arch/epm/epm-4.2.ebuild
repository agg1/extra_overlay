# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit toolchain-funcs

DESCRIPTION="Cross-platform package builder by Easy Software Products"
HOMEPAGE="https://packages.debian.org/en/wheezy/epm"
SRC_URI="mirror://debian/pool/main/e/${PN}/${PN}_${PV}.orig.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 ~ppc"

RDEPEND=""
DEPEND="
	${RDEPEND}
"

src_compile() {
	make
}

src_install() {
	newman doc/epm.man epm.1
	newman doc/epminstall.man epminstall.1
	newman doc/epm.list.man epm.list.1
	newman doc/mkepmlist.man mkepmlist.1
	newman doc/setup.man setup.1
	newman doc/setup.types.man setup.types.1
	dodoc doc/*
	dobin epm
}
