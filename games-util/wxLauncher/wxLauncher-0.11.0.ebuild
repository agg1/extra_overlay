EAPI="6"

inherit cmake-utils

DESCRIPTION="Multi-platform launcher for Freespace 2"
HOMEPAGE="https://github.com/scp-fs2open/wxLauncher"
SRC_URI="https://github.com/scp-fs2open/wxLauncher/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="test"

RDEPEND="dev-python/markdown"
DEPEND="${RDEPEND}"
