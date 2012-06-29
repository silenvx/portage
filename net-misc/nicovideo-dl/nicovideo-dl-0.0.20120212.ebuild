# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="A small command-line program to download videos from www.nicovideo.jp"
HOMEPAGE="http://sourceforge.jp/projects/nicovideo-dl/"
SRC_URI="mirror://sourceforge.jp/${PN}/56304/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	=dev-lang/python-2*"

src_prepare(){
	sed -i -e "1s/python$/python2/" "${S}/${PN}" || die "failed sed"
}

src_install(){
	dobin "${S}/${PN}"
}
