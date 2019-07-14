# Copyright 2010-2018 Martin V\"ath
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit mozextension
RESTRICT="mirror"

DESCRIPTION="Firefox webextension: restrict active contents like java/javascript/flash"
HOMEPAGE="http://noscript.net/"
SRC_URI="https://secure.informaction.com/download/releases/${P}-patched.xpi
https://addons.cdn.mozilla.net/user-media/addons/722/noscript_security_suite-${PV}-an+fx.xpi -> ${P}-patched.xpi"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~x64-cygwin ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

src_unpack() {
	mkdir "${WORKDIR}/${P}" && unzip -qo "${DISTDIR}/${P}-patched.xpi" -d "${WORKDIR}/${P}" ||  die "failed to unpack ${P}"
	cp ${DISTDIR}/${P}-patched.xpi "${WORKDIR}/${P}/{73a6fe31-595d-460b-a920-fcc0f8843232}.xpi"
}

src_install() {
	# seamonkey
	insinto "/usr/share/mozilla/extensions/{92650c4d-4b8e-4d2a-b7eb-24ecf4f6b63a}"
	doins "{73a6fe31-595d-460b-a920-fcc0f8843232}.xpi"
}
