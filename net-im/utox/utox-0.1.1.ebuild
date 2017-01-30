# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit vcs-snapshot cmake-utils

DESCRIPTION="Lightweight Tox client"
HOMEPAGE="http://utox.org"
EGIT_COMMIT="1064afb581fdb5de773f1071c65af020466ee5ad"
SRC_URI="https://github.com/uTox/uTox/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
IUSE="dbus"

#IUSE="dbus +filter_audio"
#	filter_audio? ( media-libs/libfilteraudio )

RDEPEND="net-libs/tox[av]
	media-libs/freetype
	media-libs/libv4l
	media-libs/libvpx
	media-libs/openal
	media-libs/libsdl2
	media-libs/opus
	media-libs/libpng
	virtual/jpeg
	dev-libs/libsodium
	dev-libs/libbsd
	x11-libs/libX11
	x11-libs/libXext
	dbus? ( sys-apps/dbus )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

KEYWORDS="~amd64 ~x86"

#src_prepare() {
#	epatch_user
#}
#
#src_configure() {
#	# respect CFLAGS
#	sed -i \
#		-e '/CFLAGS/s# -g ##' \
#		Makefile || die
#}
#
#src_compile() {
#	emake \
#		CC="$(tc-getCC)" \
#		DBUS=$(usex dbus "1" "0") \
#		FILTER_AUDIO=$(usex filter_audio "1" "0")
#}

src_install() {
	dobin ${CMAKE_BUILD_DIR}/utox
	doman src/utox.1
	newdoc README.md README
	newdoc CHANGELOG.md CHANGELOG
	insinto usr/share/applications
	doins src/utox.desktop
}

#pkg_preinst() {
#	gnome2_icon_savelist
#}
#
#pkg_postinst() {
#	fdo-mime_desktop_database_update
#	gnome2_icon_cache_update
#}
#
#pkg_postrm() {
#	fdo-mime_desktop_database_update
#	gnome2_icon_cache_update
#}
