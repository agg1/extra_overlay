# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit toolchain-funcs

DESCRIPTION="A virtual maildir file system for notmuch queries"
HOMEPAGE="https://github.com/tsto/notmuchfs"
SRC_URI="https://github.com/tso/notmuchfs/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-mail/notmuch mail-client/mutt"
DEPEND="${RDEPEND}"

RESTRICT="test"

src_compile() {
	emake
}

src_install() {
	dobin notmuchfs
	dobin mutt/bin/notmuch_tag
	dobin mutt/bin/prompt_mkdir
	#doman notmuch.1
	dodoc INSTALL
	dodoc AUTHORS
	dodoc ISSUES
	newdoc README.md README
	newdoc README.MUTT.md README.MUTT
	newdoc mutt/.muttrc notmuchfs.muttrc
}
