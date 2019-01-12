EAPI=5

DESCRIPTION="Realtek WiFi firmware"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
S="${WORKDIR}"

src_install() {
	default
	FILES=( "${FILESDIR}"/* )
	insinto /lib/firmware/rtlwifi
	doins ${FILES[@]} || die "doins failed"
}
