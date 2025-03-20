Xvfb :99 -screen 0 1024x768x16 &
DISPLAY=:99.0
export DISPLAY

# build virtual env and activate it
python3 -m venv venv
source ./venv/bin/activate

printf "\e[1;34m######################\e[0m\n"
printf "\e[1;34mplatform status\e[0m\n" 
printf "\e[1;34m######################\e[0m\n"
printf "python :%s %s\n" $(python --version)

git pull
git checkout $BRANCH_BUILD 

printf "\e[1;34m######################\e[0m\n"
printf "\e[1;34minstall python dependencies\e[0m\n" 
printf "\e[1;34m######################\e[0m\n"
#python -m pip install --upgrade pip
python -m pip install -r /home/builduser/OpenStreetTouch/requirement_linux.txt
#pip install --upgrade setuptools 
#pip install --upgrade pyinstaller

printf "\e[1;34m######################\e[0m\n"
printf "\e[1;34mplatform status\e[0m\n" 
printf "\e[1;34m######################\e[0m\n"
printf "python :%s %s\n" $(python --version)
printf "nodejs :%s\n" $(node --version)
printf "npm    :%s\n" $(npm --version)
printf "branch :%s\n" "$BRANCH_BUILD"


printf "\e[1;34m########################\e[0m\n"
printf "\e[1;34minstall npm dependencies\e[0m\n" 
printf "\e[1;34m########################\e[0m\n"

npm install

rm -r /home/builduser/dist/*

printf "writing python linux dependencies\n" 
pip freeze > /home/builduser/dist/requirement_test.txt





# !! delete .gitignore !!
#ls -lah /home/builduser/AccessBrailleRAP/package/debian/accessbraillerap-debian/bin/.*
#rm /home/builduser/AccessBrailleRAP/package/debian/accessbraillerap-debian/bin/.*

tree  -a /home/builduser/OpenStreetTouch/package

#printf "\e[1;34mBuild debug \e[0m\n"
#npm run builddev
printf "\e[1;34m######################\e[0m\n"
printf "\e[1;34mBuild production ready\e[0m\n"
printf "\e[1;34m######################\e[0m\n"
npm run buildubuntu
printf "\e[0mBuild finished\n"

printf "\e[1;34m######################\e[0m\n"
printf "\e[1;34mSome useful info\e[0m\n"
printf "\e[1;34m######################\e[0m\n"
ldd --version
ldd /home/builduser/OpenStreetTouch/dist/openstreettouch-ubuntu
dpkg -S 'libc.so.6'
dpkg -S 'libdl.so.2'
dpkg -S 'libpthread.so.0'
dpkg -S 'libz.so.1'

#npm run buildview
#npm run builddebian
 
 ls -la /home/builduser/OpenStreetTouch/dist/*


 if [ $(find /home/builduser/OpenStreetTouch/dist/ -name "openstreettouch-ubuntu-*.deb") ];
  then
    
    for f in /home/builduser/OpenStreetTouch/dist/openstreettouch-ubuntu-*.deb
    do
        md5sum $f > $f.md5sum
        sed -i -r "s/ .*\/(.+)/  \1/g" $f.md5sum
    done
    cp -r /home/builduser/OpenStreetTouch/dist/* /home/builduser/dist/
    printf "\e[0mCompilation: \e[1;32mSucceeded\n"
    printf "\n"
    printf "####### #    # \n"
    printf "#     # #   #  \n"
    printf "#     # #  #   \n"
    printf "#     # ###    \n"
    printf "#     # #  #   \n"
    printf "#     # #   #  \n"
    printf "####### #    # \n"
    printf "\n" 
  else
    printf "\e[0mCompilation: \e[0;31mFailed\n"
    printf "\n"
    printf "#    # #######\n"
    printf "#   #  #     #\n"
    printf "#  #   #     #\n"
    printf "# ###  #     #\n"
    printf "#  #   #     #\n"
    printf "#   #  #     #\n"
    printf "#    # #######\n"
    printf "\n" 
  fi
