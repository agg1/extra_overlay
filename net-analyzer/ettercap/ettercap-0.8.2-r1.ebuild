# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit cmake-utils

DESCRIPTION="A suite for man in the middle attacks"
HOMEPAGE="https://github.com/Ettercap/ettercap"
SRC_URI="https://github.com/Ettercap/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz" #mirror does not work

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="gtk ipv6 ncurses +plugins libressl"

RDEPEND="dev-libs/libbsd
	dev-libs/libpcre
    !libressl? ( dev-libs/openssl:0= )
    libressl? ( dev-libs/libressl:0= )
	net-libs/libnet:1.1
	>=net-libs/libpcap-0.8.1
	sys-libs/zlib
	gtk? (
		>=dev-libs/atk-1.2.4
		>=dev-libs/glib-2.2.2:2
		media-libs/freetype
		x11-libs/cairo
		x11-libs/gdk-pixbuf:2
		>=x11-libs/gtk+-2.2.2:2
		>=x11-libs/pango-1.2.3
	)
	ncurses? ( >=sys-libs/ncurses-5.3:= )
	plugins? ( >=net-misc/curl-7.26.0 )"
DEPEND="${RDEPEND}
	sys-devel/flex
	virtual/yacc"

src_prepare() {
	sed -i "s:Release:Release Gentoo:" CMakeLists.txt || die
	epatch "${FILESDIR}"/cve-2017-6430.patch
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable ncurses CURSES)
		$(cmake-utils_use_enable gtk)
		$(cmake-utils_use_enable plugins)
		$(cmake-utils_use_enable ipv6)
		-DBUNDLED_LIBS=OFF
		-DSYSTEM_LIBS=ON
		-DINSTALL_SYSCONFDIR="${EROOT}"etc
	)
		#right now we only support gtk2, but ettercap also supports gtk3
		#do we care? do we want to support both?

		#we want to enable testing but it fails right now
		#we want to disable the bundled crap, but we are missing at least "libcheck"
		#if we want to enable tests, we need to fix it, and either package libcheck or allow bundled version
		#$(cmake-utils_use_enable test TESTS)
	cmake-utils_src_configure
}
