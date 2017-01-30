# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit cmake-utils 

DESCRIPTION="encryption add-on for irssi"
HOMEPAGE="https://github.com/falsovsky/FiSH-irssi"
SRC_URI="https://github.com/falsovsky/FiSH-irssi/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="test"

MYSQL=NO
CONFDIR=/etc

RDEPEND="net-irc/irssi"
DEPEND="${RDEPEND}"
