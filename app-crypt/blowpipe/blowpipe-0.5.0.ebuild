EAPI="5"

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="authenticated Blowfish-encrypted pipe"
HOMEPAGE="https://github.com/skeeto/blowpipe"
SRC_URI="https://github.com/skeeto/blowpipe/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ia64 ~ppc64"
IUSE=""

COMMON_DEPEND=""
RDEPEND=""
DEPEND=""

src_compile() {
	make
}

src_install() {
	default
}
