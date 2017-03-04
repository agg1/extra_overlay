# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games

MY_P="quake2-${PV}"
DESCRIPTION="Yamagi Quake 2 source port"
HOMEPAGE="http://deponie.yamagi.org/quake2/"
SRC_URI="http://deponie.yamagi.org/quake2/${MY_P}.tar.xz
	http://deponie.yamagi.org/quake2/quake2-rogue-2.03.tar.xz
	http://deponie.yamagi.org/quake2/quake2-xatrix-2.04.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~sparc"
IUSE="dedicated rogue xatrix"

DEPEND="sys-libs/zlib
		media-libs/openal
		virtual/jpeg
		media-libs/libogg
		media-libs/libvorbis
		virtual/opengl"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}
ROGUE="${WORKDIR}/quake2-rogue-2.03"
XATRIX="${WORKDIR}/quake2-xatrix-2.04"

#src_unpack() {
#}

#src_prepare() {
#	return
#}

src_compile() {
	# Some ugly stuff, could probably be made prettier
	emake \
		DEFAULT_BASEDIR="${GAMES_DATADIR}/quake2" \
		DEFAULT_LIBDIR="$(games_get_libdir)/${PN}${libsuffix}" \
		|| die "make failed"
	cd ${ROGUE} \
		&& make || die "rogue failed"
	cd ${XATRIX} \
		&& make || die "xatrix failed"
	cd "${S}"
	# Move tuff around to keep libs and bins seperate
	mkdir -p "${S}/rel-bin"
	mkdir -p "${S}/rel-lib"
	cp "${S}/release/quake2" "${S}/rel-bin"
	cp "${S}/release/q2ded" "${S}/rel-bin"
	cp "${S}/release/"* "${S}/rel-lib"
	cp -R "${S}/release/baseq2" "${S}/rel-lib"
	mkdir -p "${S}/rel-lib/rogue" \
		&& cp "${ROGUE}/release/game.so" "${S}/rel-lib/rogue"
	mkdir -p "${S}/rel-lib/xatrix" \
		&& cp "${XATRIX}/release/game.so" "${S}/rel-lib/xatrix"
}

src_install() {
	local q2dir=$(games_get_libdir)/${PN}

	dodoc README.md

	dodir "${q2dir}"
	cp -rf "${S}/rel-lib/"* "${D}/${q2dir}"/

	dogamesbin "${S}/rel-bin/quake2"

	use dedicated \
		&& dogamesbin "${S}/rel-bin"/q2ded
#	use rogue \
		dogamesbin "${FILESDIR}"/quake2-rogue \
		&& make_desktop_entry quake2-rogue "Yamagi Quake II: Ground Zero" Quake2
#	use xatrix \
		dogamesbin "${FILESDIR}"/quake2-xatrix \
		&& make_desktop_entry quake2-xatrix "Yamagi Quake II: The Reckoning" Quake2

	doicon "${S}"/stuff/icon/Quake2.png
	make_desktop_entry yquake2 "Yamagi Quake II" Quake2

	prepgamesdirs
}
