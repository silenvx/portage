# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit eutils git-2

DESCRIPTION="a fast FrameBuffer based TERMinal emulator for linux"
HOMEPAGE="http://fbterm.googlecode.com"
SRC_URI=""

EGIT_BRANCH="prototype"
EGIT_REPO_URI="git://github.com/silenvx/fbterm.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="gpm video_cards_vesa caps"

RDEPEND=">=media-libs/freetype-2
	gpm? ( sys-libs/gpm )
	media-libs/fontconfig
	caps? ( sys-libs/libcap ) 
	video_cards_vesa? ( dev-libs/libx86 )"
DEPEND="${RDEPEND}
	sys-libs/ncurses
	dev-util/pkgconfig"

src_configure() {
	econf $(use_enable gpm) $(use_enable video_cards_vesa vesa)
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"

	dodoc AUTHORS NEWS README
	$(type -P tic) -o "${D}/usr/share/terminfo/" \
		"${S}"/terminfo/fbterm || die "Failed to generate terminfo database"
}

pkg_postinst() {
	if use caps ;then
		setcap "cap_sys_tty_config+ep" "${ROOT}"/usr/bin/fbterm
	else
		chmod u+s "${ROOT}"/usr/bin/fbterm
	fi
}
