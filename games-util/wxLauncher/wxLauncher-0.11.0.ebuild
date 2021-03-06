EAPI="6"
PYTHON_COMPAT=( python3_{4,5,6,7} )

inherit cmake-utils python-single-r1

DESCRIPTION="Multi-platform launcher for Freespace 2"
HOMEPAGE="https://github.com/scp-fs2open/wxLauncher"
SRC_URI="https://github.com/scp-fs2open/wxLauncher/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="test"

RDEPEND="dev-python/markdown x11-libs/wxGTK"
DEPEND="${RDEPEND}"

src_install() {
	cmake-utils_src_install
	doicon resources/wxlauncher.ico
	make_desktop_entry wxlauncher "Freespace SCP Launcher"
}
