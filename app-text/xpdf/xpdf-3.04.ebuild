EAPI=5

inherit fdo-mime gnome2 eutils flag-o-matic toolchain-funcs

DESCRIPTION="An X Viewer for PDF Files"
HOMEPAGE="http://www.foolabs.com/xpdf/"
SRC_URI="https://mirror.hmc.edu/ctan/support/xpdf/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="nodrm"

RDEPEND="
	>=app-text/poppler-0.18.0
	>=x11-libs/motif-2.3:0
	x11-libs/libX11
	x11-libs/libXpm
	media-libs/freetype
	"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${P}

src_configure() {
	econf --with-freetype2-includes=/usr/include/freetype2/
}

src_compile() {
	emake -j1
}

src_install() {
#	dobin xpdf/pdfdetach
#	dobin xpdf/pdffonts
#	dobin xpdf/pdfimages
#	dobin xpdf/pdfinfo
#	dobin xpdf/pdftohtml
#	dobin xpdf/pdftopng
#	dobin xpdf/pdftoppm
#	dobin xpdf/pdftops
#	dobin xpdf/pdftotext
	dobin xpdf/xpdf

#	doman doc/pdfdetach.1
#	doman doc/pdffonts.1
#	doman doc/pdfimages.1
#	doman doc/pdfinfo.1
#	doman doc/pdftohtml.1
#	doman doc/pdftopng.1
#	doman doc/pdftoppm.1
#	doman doc/pdftops.1
#	doman doc/pdftotext.1
	doman doc/xpdf.1
	doman doc/xpdfrc.5

	dodoc README ANNOUNCE CHANGES
	insinto /usr/share/applications
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
