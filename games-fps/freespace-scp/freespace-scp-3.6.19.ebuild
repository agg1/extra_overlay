EAPI="5"

inherit games toolchain-funcs

DESCRIPTION="Freespace SCP"
HOMEPAGE="http://scp.indiegames.us/"
SRC_URI="https://github.com/scp-fs2open/fs2open.github.com/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="test"

CFLAGS="${CFLAGS} -mcpu=core2 -march=core2 -mtune=core2"
CXXFLAGS="${CXXFLAGS} -mcpu=core2 -march=core2 -mtune=core2"

RDEPEND="media-libs/openal
	dev-libs/jansson
	dev-lang/lua
	media-libs/libpng
	sys-libs/zlib
	media-libs/libjpeg-turbo
	media-libs/libsdl
	media-video/ffmpeg
	media-libs/alsa-lib
	media-libs/libvorbis
	media-libs/libtheora
	app-arch/bzip2"

DEPEND="${RDEPEND}"

src_configure() {
	./autogen.sh
}

src_compile() {
	emake
}

src_install() {
	dogamesbin code/fs2_open_${PV}
}
