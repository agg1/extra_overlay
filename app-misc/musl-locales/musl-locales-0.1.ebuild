# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

if [[ "${PV}" == 9999 ]]; then
		inherit git-r3
		EGIT_REPO_URI="https://github.com/rilian-la-te/${PN}.git"
		SRC_URI=""
else
		SRC_URI="https://github.com/dhewm/${PN}/archive/${P}.tar.gz"
		KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
		S="${WORKDIR}/${P}"
fi

DESCRIPTION="Locale program for musl libc"
HOMEPAGE="https://github.com/rilian-la-te/musl-locales"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="sys-libs/musl"
RDEPEND="${DEPEND}"
