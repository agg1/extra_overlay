# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools eutils linux-info multilib user

DESCRIPTION="A client implementation of Secure Socket Tunneling Protocol (SSTP)"
HOMEPAGE="http://sstp-client.sourceforge.net/"
SRC_URI="mirror://sourceforge/sstp-client/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static ssl libressl"

RDEPEND=">=dev-libs/libevent-2.0.10
	ssl? (
		!libressl? ( dev-libs/openssl:0= )
		libressl? ( dev-libs/libressl:0= )
	)
	net-dialup/ppp:="
DEPEND="${RDEPEND}
		virtual/pkgconfig"

CONFIG_CHECK="~NETFILTER_NETLINK"
DOCS=( AUTHORS ChangeLog DEVELOPERS INSTALL NEWS README TODO USING )

pkg_setup() {
	enewgroup sstpc
	enewuser sstpc -1 -1 -1 sstpc
}

src_prepare() {
	# set proper examples dir, --docdir overriding is src_configure does not work
	sed -i -e "/^docdir/s:@PACKAGE@:${PF}/examples:" Makefile.am || die 'sed on Makefile.am failed'

	eautomake
	epatch_user
}

src_configure() {
	local PPPD_VER="$(best_version net-dialup/ppp)"
	PPPD_VER=${PPPD_VER#*/*-} #reduce it to ${PV}-${PR}
	PPPD_VER=${PPPD_VER%%[_-]*} # main version without beta/pre/patch/revision
	econf \
		--enable-ppp-plugin \
		--enable-group=sstpc \
		--enable-user=sstpc \
		--with-pppd-plugin-dir="/usr/$(get_libdir)/pppd/${PPPD_VER}" \
		--with-runtime-dir="/run/sstpc" \
		$(use_enable static)
}

src_install() {
	default
	prune_libtool_files --modules
}
