EAPI="5"

inherit toolchain-funcs

DESCRIPTION="Yet another traffic bouncer"
HOMEPAGE="https://github.com/glftpd/yatb"
SRC_URI="https://github.com/glftpd/${PN}/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="test"

src_compile() {
	make linux
}

src_install() {
	dobin bin/blowcrypt
	dobin bin/bnccheck
	dobin bin/getfp
	dobin bin/yatb
	newdoc README.md README
	insinto /etc/yatb
	newins yatb.conf.dist yatb.conf
	doins simple.conf
}
