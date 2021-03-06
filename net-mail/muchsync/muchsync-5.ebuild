# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Synchronizes mail messages and notmuch tags across machines"
HOMEPAGE="http://www.muchsync.org/"
SRC_URI="http://www.muchsync.org/src/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="libressl"

DEPEND="dev-db/sqlite:3
	!libressl? ( dev-libs/openssl:= )
	libressl? ( dev-libs/libressl:= )
	dev-libs/xapian:=
	net-mail/notmuch:=
	"
RDEPEND="${DEPEND}
	net-misc/openssh
	"
