# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
CDROM_OPTIONAL="yes"
inherit eutils unpacker cdrom games

DESCRIPTION="Quake III Arena - highres data portion"
HOMEPAGE="http://ioquake3.org/"
SRC_URI="http://ioquake3.org/files/xcsv_hires.zip http://ioquake3.org/files/quake3-data.tar.gz"

LICENSE="Q3AEULA"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~x86 ~x86-fbsd"
IUSE=""

S=${WORKDIR}
dir=${GAMES_DATADIR}/quake3

src_install() {
	ebegin "Copying files from linux client ..."
	insinto "${GAMES_DATADIR}"/quake3/baseq3
	doins *.pk3
	eend 0

	find "${D}" -exec touch '{}' \;

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
}
