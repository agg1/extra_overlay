EAPI="5"

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="authenticated scram88-encrypted pipe"
HOMEPAGE="https://www.github.com/agg1/scrampipe"
SRC_URI="https://www.github.com/agg1/scrampipe/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ia64 ~ppc64"
IUSE=""

COMMON_DEPEND=""
RDEPEND=""
DEPEND=""

#S="${WORKDIR}/${MY_P}"

#src_prepare() {
#}

#src_configure() {
#}

src_compile() {
	make
}

src_install() {
	default
}
