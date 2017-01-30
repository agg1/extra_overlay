EAPI="5"

inherit games cmake-utils

DESCRIPTION="Freespace SCP"
HOMEPAGE="http://scp.indiegames.us/"
SRC_URI="https://github.com/scp-fs2open/fs2open.github.com/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="test"

RDEPEND="games-fps/wxLauncher
			media-libs/openal
			dev-lang/lua
			media-libs/libpng
			sys-libs/zlib
			media-libs/libjpeg-turbo
			media-libs/libsdl2
			media-video/ffmpeg
			media-libs/alsa-lib
			app-arch/bzip2"
DEPEND="${RDEPEND}"

cmake-utils_src_install() {
	dogamesbin ${BUILD_DIR}/bin/fs2_open_3_7_5_x64
	#insinto
	#doins
}
