# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
inherit eutils

DESCRIPTION="ibus-fbterm is a input method for FbTerm based on iBus."
HOMEPAGE="http://ibus-fbterm.googlecode.com"
SRC_URI="https://ibus-fbterm.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=app-i18n/ibus-1.4.1
	app-i18n/fbterm"
DEPEND="${RDEPEND}"

src_prepare(){
	epatch "${FILESDIR}"/${P}-ibus-1.4.1.patch
}
