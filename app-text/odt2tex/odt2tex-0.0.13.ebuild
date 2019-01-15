EAPI="7"

DESCRIPTION="simple command line tool that converts ODT (Libre/OpenOffice text documents) to LaTeX .tex input files"
SRC_URI="https://www.chronowerks.de/cgit/odt2tex/snapshot/${P}.tar.bz2"
HOMEPAGE="https://www.chronowerks.de/odt/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/libzip
dev-libs/expat"
RDEPEND="${DEPEND}"

