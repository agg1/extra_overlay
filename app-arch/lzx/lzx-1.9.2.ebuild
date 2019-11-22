EAPI=6

#if [[ ${PV} == 9999 ]]; then
#	inherit git-r3
#	EGIT_REPO_URI="https://github.com/lz4/lz4.git"
#	EGIT_BRANCH=dev
#else
	SRC_URI="https://github.com/Cyan4973/lz4/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
#fi

DESCRIPTION="Extremely Fast Compression algorithm with scrambling"
HOMEPAGE="https://github.com/lz4/lz4"

LICENSE="BSD-2 GPL-2"
SLOT="0/r132"
IUSE="static-libs"

src_install() {
    emake DESTDIR="${D}" install
}
