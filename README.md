このoverlayの使い方
=======
laymanを使うと非常に簡単です
    # emerge app-portage/layman
で導入が可能です

次に
    /etc/layman/layman.cfg
のファイルを開いて
    overlays  : http://www.gentoo.org/proj/en/overlays/repositories.xml
の下に最初にスペースを空けて
    https://raw.github.com/silenvx/portage/master/overlays.xml
を追加して

    # layman -L|grep silenvx
をして出てきたら登録はできているので

    # layman -a silenvx
をしてlaymanに登録してください

後はいつも通りemergeを使うだけです
