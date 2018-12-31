# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit toolchain-funcs eutils

DESCRIPTION="Manages various PaX related program header flags for Elf32, Elf64, binaries"
HOMEPAGE="https://pax.grsecurity.net"
SRC_URI="https://pax.grsecurity.net/${P}.tar.gz"

KEYWORDS="alpha amd64 arm ~arm64 hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-linux ~x86-linux"
IUSE=""
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=sys-devel/binutils-2.14.90.0.8-r1"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}/chpax-0.7-no_aout.patch"
	epatch_user
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}"
}

src_install () {
	emake DESTDIR="${ED}" install
	dodoc README Changelog
}
