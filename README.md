Setting up a new Mac


APPLICATIONS:

Chrome: https://www.google.com/intl/en/chrome/browser/
Firefox: http://www.mozilla.org/en-US/firefox/new/#download-fx
Adobe Reader: http://get.adobe.com/reader/
Microsoft Silverlight: http://www.microsoft.com/silverlight/
Dropbox: https://www.dropbox.com/downloading?src=index
Text Wrangler:
http://www.barebones.com/products/textwrangler/download.html

Adium: https://adium.im/
VLC: http://www.videolan.org/vlc/download-macosx.html

Sublime Text 2: http://www.sublimetext.com/2
Virtualbox: https://www.virtualbox.org/wiki/Downloads
Vagrant: http://www.vagrantup.com/downloads.html
Solarized: http://ethanschoonover.com/solarized
MySQL: http://dev.mysql.com/downloads/mysql/
ElasticSearch: http://www.elasticsearch.org/download/
Java SDK:
http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html
X11: https://xquartz.macosforge.org/trac/wiki/X112.7.5
Induction (visualizing Postgres): http://inductionapp.com/


INTERMEDIATE STEPS:

Sign in to all new apps, configure.
Set screen saver lock
Map Caps Lock to ESC
Set sleep time/Energy Saver
Import solarized to Terminal.


DEV ENVIRONMENT:

Postgres.app: http://postgresapp.com/

Homebrew: http://brew.sh/
ruby -e "$(curl -fsSL
https://raw.github.com/Homebrew/homebrew/go/install)"

brew install ack gdbm openssl readline autoconf gettext libksba
ossp-uuid reattach-to-user-namespace automake ghostscript libmpdclient
pcre redis bsdmake git libpng phantomjs ruby-build coreutils libtiff
pidof sphinx cscope hub libtool pkg-config sqlite ctags imagemagick
libxml2 postgresql the_silver_searcher curl-ca-bundle jbig2dec libyaml
proctools tig elasticsearch jpeg little-cms2 pstree tmux fontconfig
keychain macvim python wget fontforge libevent memcached qt xz freetype
libgpg-error nginx rbenv gdal


RVM:

http://rvm.io/rvm/install

\curl -sSL https://get.rvm.io | bash
rvm list known
rvm install ruby-2.x.x-pXXX


MAKE SIDE AND WORK DIRECTORIES:

mkdir ~/side
mkdir ~/work


Clone dots into side directory: 

cd side
git clone git@github.com:harrisjosh/dots.git

cd into dots

ln -s .vim/janus/vim/vimrc ~/.vimrc
ln -s .janus/vimrc.after ~/.vimrc.after

Copy the rest of the dot files to the home directory. For example:

cp .irbrc ~/.irbrc

There are a ton of files, just do an ls -al to get an idea of what you
need to copy. Some of the files are directories, in these cases you’ll
want to copy the entire directory like this:

cp -R .vim ~/
cp -R .tmux ~/

POWERLINE FOR TMUX AND VIM:

Powerline docs: 

https://powerline.readthedocs.org/en/latest/installation/linux.html#font-installation

Powerline on github:

https://github.com/Lokaltog/vim-powerline

Setup symlink between your Mac’s FontBook and a ~/.fonts directory:
ln -s /Library/Fonts ~/.fonts

Fontconfig
Download the latest version of PowerlineSymbols 
https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf

and the latest version of the fontconfig file (should be saved as
10-powerline-symbols.conf)
https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf

Move PowerlineSymbols.otf to ~/.fonts/ (or another X font directory).
cp ~/Downloads/PowerlineSymbols.otf /Library/Fonts/

Run fc-cache -vf ~/.fonts to update your font cache.
fc-cache -vf ~/.fonts

Move 10-powerline-symbols.conf to either ~/.fonts.conf.d/ or
~/.config/fontconfig/conf.d/, depending on your fontconfig version.
mkdir ~/.fonts.conf.d
cp ~/Downloads/10-powerline-symbols.conf ~/.fonts.conf.d/


Patched font
Download the font of your choice from powerline-fonts at
https://github.com/Lokaltog/powerline-fonts. If you can’t find your
preferred font in the powerline-fonts repo, you’ll have to patch your
own font instead. See Font patching for instructions. Move your patched
font to ~/.fonts/ (or another X font directory).
Run fc-cache -vf ~/.fonts to update your font cache.

For vim, Install the font Inconsolata-dz-Powerline.otf:
git clone git@github.com:Lokaltog/powerline-fonts.git

https://gist.github.com/raw/1595572/51bdd743cc1cc551c49457fe1503061b9404183f/Inconsolata-dz-Powerline.otf
cp ~/Downloads/Inconsolata-dz-Powerline.otf ~/side/powerline-fonts

cp -R powerline-fonts/* /Library/Fonts/
fc-cache -vf ~/.fonts


At this point, you should have all the configs in place for VIM and TMUX
Powerline. Docs are here:
https://powerline.readthedocs.org/en/latest/introduction.html

