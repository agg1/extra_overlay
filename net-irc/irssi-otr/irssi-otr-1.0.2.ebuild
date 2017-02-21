# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit autotools

DESCRIPTION="Libotr (https://otr.cypherpunks.ca) support for Irssi"
HOMEPAGE="https://github.com/cryptodotis/irssi-otr"
SRC_URI="https://github.com/cryptodotis/irssi-otr/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="test"

MYSQL=NO
CONFDIR=/etc

RDEPEND="dev-libs/glib net-irc/irssi net-libs/libotr dev-libs/libgcrypt"
DEPEND="${RDEPEND}"

src_prepare() {
        default
        eautoreconf
}

src_configure() {
	econf
}

src_install() {
        emake DESTDIR="${D}" install
	newdoc README.md README
#	insinto usr/lib/irssi/modules
#	doins src/.libs/libotr.so
#	doins src/.libs/libotr.lai
#	doins src/libotr.la
}
