# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="hardened malloc from bionic libc"
HOMEPAGE="https://github.com/GrapheneOS/hardened_malloc"
SRC_URI="https://github.com/GrapheneOS/hardened_malloc/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~arm64 ~ia64 ~ppc64"
#IUSE="static-libs"

src_install() {
	emake install DESTDIR="${D}"
}
