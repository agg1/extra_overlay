EAPI="6"

inherit cmake-utils

DESCRIPTION="simple joystick tester based on Gtk+"
HOMEPAGE="https://github.com/Grumbel/jstest-gtk.git"
SRC_URI="https://github.com/Grumbel/jstest-gtk.git/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="test"

RDEPEND="games-util/joystick x11-libs/gtk+:2 dev-cpp/gtkmm"
DEPEND="${RDEPEND}"

cmake-utils_src_install() {
        dobin ${BUILD_DIR}/jstest-gtk
}

