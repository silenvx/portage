# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit font

MY_PV="${PV}-2"

DESCRIPTION="Mixing mplus and IPA fonts"
HOMEPAGE="http://mix-mplus-ipa.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/mix-mplus-ipa/56155/migmix-1m-${MY_PV}.zip
	mirror://sourceforge.jp/mix-mplus-ipa/56155/migmix-1p-${MY_PV}.zip
	mirror://sourceforge.jp/mix-mplus-ipa/56155/migmix-2m-${MY_PV}.zip
	mirror://sourceforge.jp/mix-mplus-ipa/56155/migmix-2p-${MY_PV}.zip
	mirror://sourceforge.jp/mix-mplus-ipa/56156/migu-1p-${MY_PV}.zip
	mirror://sourceforge.jp/mix-mplus-ipa/56156/migu-1c-${MY_PV}.zip
	mirror://sourceforge.jp/mix-mplus-ipa/56156/migu-1m-${MY_PV}.zip
	mirror://sourceforge.jp/mix-mplus-ipa/56156/migu-2m-${MY_PV}.zip"

LICENSE="mplus-fonts IPAfont"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S="${WORKDIR}"

FONT_SUFFIX="ttf"
FONT_S="${S}"

src_prepare() {
	mv */*.${FONT_SUFFIX} "${FONT_S}" || die
}
