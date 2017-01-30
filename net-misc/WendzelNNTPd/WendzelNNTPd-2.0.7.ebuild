# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit toolchain-funcs

DESCRIPTION="A free Usenet server with SQL backend and RBAC."
HOMEPAGE="http://steffen-wendzel.blogspot.de/p/blog-page.html"
SRC_URI="https://github.com/cdpxe/WendzelNNTPd/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ppc ~sparc x86"
IUSE=""

RESTRICT="test"

MYSQL=NO
CONFDIR=/etc

RDEPEND="dev-db/sqlite"
DEPEND="${RDEPEND}"

#src_prepare() {
#}

src_configure() {
	MYSQL=NO CONFDIR=/etc ./configure
}

src_compile() {
	emake
}

src_install() {
	dobin bin/wendzelnntpadm
	dobin bin/wendzelnntpd
	newdoc docs/docs.pdf wendzelnntpd.pdf
	dodoc README
	dodoc CHANGELOG
	insinto /etc
	doins wendzelnntpd.conf
}
