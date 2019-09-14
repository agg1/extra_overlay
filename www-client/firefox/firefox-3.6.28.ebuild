EAPI="5"
WANT_AUTOCONF="2.1"

inherit flag-o-matic toolchain-funcs eutils mozconfig-v6.52 multilib fdo-mime autotools mozextension

MAJ_XUL_PV="1.9.2"
MAJ_PV="${PV/_*/}"
DESKTOP_PV="3.6"
MY_PV="${PV/_rc/rc}"
XUL_PV="${MAJ_XUL_PV}${MAJ_PV/${DESKTOP_PV}/}"

DESCRIPTION="Firefox Web Browser"
HOMEPAGE="http://www.mozilla.com/firefox"

KEYWORDS="~amd64 ~arm ~ia64 ~ppc ~ppc64 ~x86 ~amd64-linux ~ia64-linux ~x86-linux"
SLOT="0"
LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
IUSE="alsa bindist ipc system-sqlite"

REL_URI="http://releases.mozilla.org/pub/mozilla.org/firefox/releases"
SRC_URI="${REL_URI}/${MY_PV}/source/firefox-${MY_PV}.source.tar.bz2"

RDEPEND="sys-devel/binutils
	dev-libs/libIDL
	dev-libs/nss
	dev-libs/nspr
	app-text/hunspell
	system-sqlite? ( >=dev-db/sqlite-3.7.4[fts3,secure-delete] )
	alsa? ( media-libs/alsa-lib )
	x11-libs/cairo[X]"

DEPEND="${RDEPEND}
	=dev-lang/python-2*[threads]
	virtual/pkgconfig"

RDEPEND="${RDEPEND}"

S="${WORKDIR}/mozilla-1.9.2"

pkg_setup() {
	export LANG="C"
	export LC_ALL="C"
	export LC_MESSAGES="C"
	export LC_CTYPE="C"
}

src_unpack() {
	unpack firefox-${MY_PV}.source.tar.bz2
}

src_prepare() {
	# Apply our patches
	EPATCH_SUFFIX="patch" \
	EPATCH_FORCE="yes" \
	epatch "${WORKDIR}"
	epatch "${FILESDIR}"/firefox-3.6.patch
	epatch "${FILESDIR}"/firefox-config.patch

	epatch_user
	eautoreconf

	cd js/src
	eautoreconf
}

src_configure() {
	MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"
	EXTENSIONS="default"

	mozconfig_init
	mozconfig_config

	mozconfig_annotate '' --disable-tests
	mozconfig_annotate '' --disable-dbus
	mozconfig_annotate '' --enable-crypto
	mozconfig_annotate '' --disable-extensions
	#mozconfig_annotate '' --enable-extensions
	#mozconfig_annotate '' --enable-extensions="${MEXTENSIONS}"
	mozconfig_annotate '' --enable-application=browser
	mozconfig_annotate '' --disable-mailnews
	mozconfig_annotate 'broken' --disable-crashreporter
	mozconfig_annotate '' --enable-image-encoder=all
	mozconfig_annotate '' --without-system-png
	mozconfig_annotate '' --enable-canvas
	mozconfig_annotate 'gtk' --enable-default-toolkit=cairo-gtk2
	mozconfig_annotate '' --enable-oji --enable-mathml
	mozconfig_annotate 'places' --enable-storage --enable-places
	mozconfig_annotate '' --disable-safe-browsing

	# Build mozdevelop permately
	mozconfig_annotate '' --disable-jsd --disable-xpctools

	# System-wide install specs
	mozconfig_annotate '' --disable-installer
	mozconfig_annotate '' --disable-updater
	mozconfig_annotate '' --disable-strip
	mozconfig_annotate '' --disable-install-strip

	# Use system libraries
	mozconfig_annotate '' --enable-system-cairo
	mozconfig_annotate '' --enable-system-hunspell
	mozconfig_annotate '' --with-system-nspr --with-nspr-prefix="${EPREFIX}"/usr
	mozconfig_annotate '' --with-system-nss --with-nss-prefix="${EPREFIX}"/usr
	mozconfig_annotate '' --x-includes="${EPREFIX}"/usr/include --x-libraries="${EPREFIX}"/usr/$(get_libdir)
	mozconfig_annotate '' --with-system-bz2
	mozconfig_annotate '' --with-system-libxul
	#mozconfig_annotate '' --with-libxul-sdk="${EPREFIX}"/usr/$(get_libdir)/xulrunner-devel-${MAJ_XUL_PV}
	#mozconfig_annotate '' --disable-xul

	mozconfig_annotate '' --enable-optimize=-Os
	mozconfig_annotate '' --enable-permissions
	mozconfig_annotate '' --disable-jemalloc
	mozconfig_annotate '' --disable-inspector-apis
	#mozconfig_annotate '' --disable-jsloader
	mozconfig_annotate '' --disable-javaxpcom
	mozconfig_annotate '' --disable-xpcom-obsolete
	mozconfig_annotate '' --disable-xpcom-fastload
	mozconfig_annotate '' --disable-splashscreen
	mozconfig_annotate '' --disable-ipc
	#mozconfig_annotate '' --without-libIDL

	#mozconfig_annotate '' --disable-ogg
	#mozconfig_annotate '' --disable-wave

	#mozconfig_use_enable ipc
	mozconfig_use_enable alsa ogg
	mozconfig_use_enable alsa wave
	mozconfig_use_enable system-sqlite
	mozconfig_use_enable !bindist official-branding

	# Other ff-specific settings
	mozconfig_annotate '' --with-default-mozilla-five-home=${MOZILLA_FIVE_HOME}

	# Finalize and report settings
	mozconfig_final

	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getLD)" CXXFLAGS="$CXXFLAGS -fpermissive" PYTHON="python2.7" econf
}

src_compile() {
	emake ${MAKEOPTS} || die
}

src_install() {
	MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	emake DESTDIR="${D}" install || die "emake install failed"

	# Install icon and .desktop for menu entry
	newicon "${S}"/other-licenses/branding/firefox/content/icon48.png ${PN}-icon.png
	newmenu "${FILESDIR}"/icon/${PN}-1.5.desktop \
	mozilla-${PN}-${DESKTOP_PV}.desktop

	# Plugins dir
	dodir ../nsbrowser/plugins
	dosym ../nsbrowser/plugins "${MOZILLA_FIVE_HOME}"/plugins || die "failed to symlink"
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}
