dotvim
======

My Vim configuration. (Contains a few key mappings for Colemak)

To get started:

    git clone https://github.com/omidmnz/dotvim.git ~/.vim
    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc
    cd ~/.vim/
    git submodule init
    git submodule update
    cd bundle/ternjs/
    npm install

And install Source Code Pro font, from http://sourceforge.net/projects/sourcecodepro.adobe/files/SourceCodePro_FontsOnly-1.017.zip/download

I personally map Caps Lock key, to be and extra ESC key from the OS.

ConqueTerm plugin needs python support. Syntastic needs pylint, gcc, jshint(npm install -g jshint). TernJS should be installed as shown in the commands above.
