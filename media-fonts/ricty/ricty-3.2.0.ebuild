# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit font git-2

DESCRIPTION="A beautiful sans-serif monotype Japanese font designed for code listings"
HOMEPAGE="http://save.sys.t.u-tokyo.ac.jp/~yusa/fonts/ricty.html"
SRC_URI=""

if [ "${PV}" == "9999" ];then
	EGIT_BRANCH="master"
else
	EGIT_BRANCH="${PV}"
fi
EGIT_REPO_URI="git://github.com/yascentur/Ricty.git"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-gfx/fontforge
	>=media-fonts/mix-mplus-ipa-20111002
	media-fonts/inconsolata"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}"

FONT_SUFFIX="ttf"
FONT_S="${S}"

# Only installs fonts.
RESTRICT="strip binchecks"

src_compile(){
	sh ricty_generator.sh \
	"${EPREFIX}/usr/share/fonts/inconsolata/Inconsolata.otf" \
	"${EPREFIX}/usr/share/fonts/mix-mplus-ipa/Migu-1M-regular.ttf" \
	"${EPREFIX}/usr/share/fonts/mix-mplus-ipa/Migu-1M-bold.ttf" || die "failed ricty_generator.sh"
}
