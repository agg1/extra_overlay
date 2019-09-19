# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

DESCRIPTION="Utility for fast (even real-time) de/compression with 64bit LFSR scrambler"
HOMEPAGE="http://www.lzop.org/"
SRC_URI="http://www.lzop.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm arm64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

RDEPEND=">=dev-libs/lzx-2"
DEPEND="${RDEPEND}"

src_configure() {
	econf --disable-asm
}

src_test() {
	einfo "compressing config.status to test"
	src/lzxp config.status || die 'compression failed'
	ls -la config.status{,.lzx}
	src/lzxp -t config.status.lzx || die 'lzx test failed'
	src/lzxp -dc config.status.lzx | diff config.status - || die 'decompression generated differences from original'
}

src_install() {
	# do not install COPYING or redundant conversions of manpage
	emake DESTDIR="${D}" install \
		dist_doc_DATA="AUTHORS NEWS README THANKS"
}
