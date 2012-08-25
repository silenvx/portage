# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils git-2

DESCRIPTION="Additional completion definitions for Zsh"
HOMEPAGE="https://github.com/zsh-users/zsh-completions"
SRC_URI=""

LICENSE="ZSH"
SLOT="0"
KEYWORDS="~x86"

IUSE="ack adb android attach baselayout bpython brew bundle
	cap choc coffee cpanm debuild dhcpcd ditz emulator
	eselect fab gas gcc-config geany gem genlop gentoolkit
	gentoo_packages git-flow github git-pulls git-wtf
	google gradle heroku jmeter jmeter-plugins jonas knife
	language_codes layman lein lunar lunchy manage.py mosh
	mvn node optirun pear perf periscope pgsql_utils pip
	pkcon play port portage portage_utils pygmentize
	redis-cli rvm sbt scala setup.py showoff smartmontools
	srm ssh-copy-id subliminal symfony teamocil thor
	tmuxinator vagrant virtualbox vpnc yaourt"

DEPEND=">=app-shells/zsh-4.3.5"
RDEPEND="${DEPEND}"

EGIT_REPO_URI="git://github.com/zsh-users/zsh-completions.git"
EGIT_BRANCH="master"
if [ "${PV}" != "9999" ];then
	EGIT_COMMIT="${PV}"
fi

S="${WORKDIR}/${PN}"

src_install() {
	cd src
	insinto /usr/share/zsh/site-functions
	use ack && doins _ack
	use adb && doins _adb
	use android && doins _android
	use attach && doins _attach
	use baselayout && doins _baselayout
	use bpython && doins _bpython
	use brew && doins _brew
	use bundle && doins _bundle
	use cap && doins _cap
	use choc && doins _choc
	use coffee && doins _coffee
	use cpanm && doins _cpanm
	use debuild && doins _debuild
	use dhcpcd && doins _dhcpcd
	use ditz && doins _ditz
	use emulator && doins _emulator
	use eselect && doins _eselect
	use fab && doins _fab
	use gas && doins _gas
	use gcc-config && doins _gcc-config
	use geany && doins _geany
	use gem && doins _gem
	use genlop && doins _genlop
	use gentoolkit && doins _gentoolkit
	use gentoo_packages && doins _gentoo_packages
	use git-flow && doins _git-flow
	use github && doins _github
	use git-pulls && doins _git-pulls
	use git-wtf && doins _git-wtf
	use google && doins _google
	use gradle && doins _gradle
	use heroku && doins _heroku
	use jmeter && doins _jmeter
	use jmeter-plugins && doins _jmeter-plugins
	use jonas && doins _jonas
	use knife && doins _knife
	use language_codes && doins _language_codes
	use layman && doins _layman
	use lein && doins _lein
	use lunar && doins _lunar
	use lunchy && doins _lunchy
	use manage.py && doins _manage.py
	use mosh && doins _mosh
	use mvn && doins _mvn
	use node && doins _node
	use optirun && doins _optirun
	use pear && doins _pear
	use perf && doins _perf
	use periscope && doins _periscope
	use pgsql_utils && doins _pgsql_utils
	use pip && doins _pip
	use pkcon && doins _pkcon
	use play && doins _play
	use port && doins _port
	use portage && doins _portage
	use portage_utils && doins _portage_utils
	use pygmentize && doins _pygmentize
	use redis-cli && doins _redis-cli
	use rvm && doins _rvm
	use sbt && doins _sbt
	use scala && doins _scala
	use setup.py && doins _setup.py
	use showoff && doins _showoff
	use smartmontools && doins _smartmontools
	use srm && doins _srm
	use ssh-copy-id && doins _ssh-copy-id
	use subliminal && doins _subliminal
	use symfony && doins _symfony
	use teamocil && doins _teamocil
	use thor && doins _thor
	use tmuxinator && doins _tmuxinator
	use vagrant && doins _vagrant
	use virtualbox && doins _virtualbox
	use vpnc && doins _vpnc
	use yaourt && doins _yaourt
}

pkg_postinst() {
	elog
	elog "If you happen to compile your functions, you may need to delete"
	elog "~/.zcompdump{,.zwc} and recompile to make zsh-completion available"
	elog "to your shell."
	elog
}
