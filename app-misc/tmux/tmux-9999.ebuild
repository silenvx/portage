# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils autotools git-2

DESCRIPTION="Terminal multiplexer"
HOMEPAGE="http://tmux.sourceforge.net/"
SRC_URL=""

EGIT_BRANCH="master"
EGIT_REPO_URI="git://github.com/ThomasAdam/tmux.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="vim-syntax"

DEPEND="
	|| ( >=dev-libs/libevent-2.0.10 <dev-libs/libevent-2 )
	sys-libs/ncurses"
RDEPEND="${DEPEND}
	vim-syntax? ( || (
		app-editors/vim
		app-editors/gvim ) )"

DOCS=( CHANGES FAQ NOTES TODO )

pkg_setup() {
	if has_version "<app-misc/tmux-1.3"; then
		echo
		ewarn "Commands 'up-pane', 'down-pane' and 'select-prompt' were removed in version 1.3."
		ewarn "You may want to update your configuration file accordingly to avoid errors on"
		ewarn "tmux startup."
		ewarn
		ewarn "For the full Changelog, together with details on what replaced the above"
		ewarn "commands, visit http://tmux.cvs.sourceforge.net/viewvc/tmux/tmux/CHANGES."
		ewarn
		ewarn "WARNING: after updating to ${P} you will _not_ be able to connect to any"
		ewarn "running 1.2 tmux server instances. You'll have to use an existing client to"
		ewarn "end your old sessions or kill the old server instances. Otherwise you'll have"
		ewarn "to temporarily downgrade to tmux 1.2 to access them."
		echo
	fi
}

src_prepare() {
	S="${S}/trunk"
	cd ${S}
	epatch "${FILESDIR}/${PN}-fbterm.patch" # support 256color on fbterm
	./autogen.sh || die "autogen.sh failed"
	# look for config file in the prefix
	sed -i -e '/SYSTEM_CFG/s:"/etc:"'"${EPREFIX}"'/etc:' tmux.h || die "sed failed"
	# and don't just add some includes
	sed -i -e 's:-I/usr/local/include::' Makefile.in || die "sed failed"
	eautoconf || die "eautoconf failed"
}

src_install() {
	default

	docinto examples
	dodoc examples/*.conf

	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/syntax
		doins examples/tmux.vim

		insinto /usr/share/vim/vimfiles/ftdetect
		doins "${FILESDIR}"/tmux.vim
	fi
}
