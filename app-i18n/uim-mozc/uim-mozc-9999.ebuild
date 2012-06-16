# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI="3"
PYTHON_DEPEND="2"
inherit python

DESCRIPTION="input method for use the mozc on the uim"
HOMEPAGE="http://code.google.com/p/mozc/ https://code.google.com/p/macuim/"

LICENSE="Apache-2.0 BSD Boost-1.0 ipadic public-domain unicode"
SLOT="0"
KEYWORDS="~x86"
IUSE="qt4"

RDEPEND="app-i18n/uim
	qt4? (
		x11-libs/qt-gui:4
		app-i18n/zinnia
	)"

DEPEND="${RDEPEND}
	=dev-lang/python-2*
	dev-vcs/subversion"
RESTRICT="test"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	svn export --force https://macuim.googlecode.com/svn/trunk/Mozc "${S}/Mozc" || die
	cd "${S}/Mozc" || die
	bash "${S}/Mozc/build" --apply-patch || die
	#replace file
	find "${S}/Moz"c -type f -print|\
		while read FILE
		do
			grep -G "\(mozc_server\|mozc_tool\)" "${FILE}" > /dev/null
			if [ $? -eq 0 ]
			then
				sed 's/mozc_server/mozc_server_uim/g' "${FILE}"|\
					sed 's/mozc_tool/mozc_tool_uim/g' > "${FILE}.bak"
				mv "${FILE}.bak" "${FILE}"
				echo "replace ${FILE}"
			fi
		done

	#rename file
	find "${S}/Mozc" -print|grep -G "/[^\/]*mozc_server[^\/]*$"|sort -r|\
		while read SOURCE
		do
			DEST="$(echo "${SOURCE##*/}"|sed -e 's/mozc_server/mozc_server_uim/g')"
			DEST="$(echo $SOURCE|sed -e 's/\/[^/]*$//'|cat)/${DEST}"
			mv ${SOURCE} ${DEST}
			echo "${SOURCE} -> ${DEST}"
		done

	find "${S}/Mozc" -print|grep -G "/[^\/]*mozc_tool[^\/]*$"|sort -r|\
		while read SOURCE
		do
			DEST="$(echo "${SOURCE##*/}"|sed -e 's/mozc_tool/mozc_tool_uim/g')"
			DEST="$(echo $SOURCE|sed -e 's/\/[^/]*$//'|cat)/${DEST}"
			mv ${SOURCE} ${DEST}
			echo "${SOURCE} -> ${DEST}"
		done
}

src_compile() {
	cd "${S}/Mozc" || die
	bash "${S}/Mozc/build" || die
}

src_install() {
	exeinto "/usr/$(get_libdir)/uim/plugin" || die
	doexe "${S}/Mozc/mozc/src/out_linux/Release/libuim-mozc.so" || die

	exeinto "/usr/$(get_libdir)/mozc" || die
	doexe "${S}/Mozc/mozc/src/out_linux/Release/mozc_server_uim" || die

	if use qt4 ; then
		exeinto "/usr/$(get_libdir)/mozc" || die
		doexe "${S}/Mozc/mozc/src/out_linux/Release/mozc_tool_uim" || die
	fi

	insinto "/usr/share/uim" || die
	doins "${S}/Mozc/scm/mozc-custom.scm" "${S}/Mozc/scm/mozc-key-custom.scm" "${S}/Mozc/scm/mozc.scm" ||die

	insinto "/usr/share/uim/pixmaps/" || die
	newins "${S}/Mozc/mozc/src/data/images/unix/ui-tool.png" "mozc_tool_uim_selector.png" || die
	newins "${S}/Mozc/mozc/src/data/images/unix/ime_product_icon_opensource-32.png" "mozc.png" || die
	newins "${S}/Mozc/mozc/src/data/images/unix/ui-properties.png" "mozc_tool_uim_config_dialog.png" || die
	newins "${S}/Mozc/mozc/src/data/images/unix/ui-dictionary.png" "mozc_tool_uim_dictionary_tool.png" || die
}

pkg_postinst() {
	uim-module-manager --register mozc
	echo
	einfo "use the uim-mozc on framebuffer,please run the following command"
	einfo "uim-fep -u mozc"
	echo
}

pkg_postrm() {
	uim-module-manager --unregister mozc
}
