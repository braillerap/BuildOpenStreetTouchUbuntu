# BuildOpenStreetTouchUbuntu
A docker configuration to build OpenStreetTouch for ubuntu base os

# usage

## building docker image
    export HOST_UID=$(id -u)
    export HOST_GID=$(id -g)

    docker build  UID=$HOST_UID --build-arg GID=$HOST_GID -t buildopenstreettouchubuntu .

## use docker image to build OpenStreetTouch
    docker run --rm -it --name openstreettouch_ubuntu_build -e BRANCH_BUILD=<branch|main> -v ./dist/:/home/builduser/dist buildopenstreettouchubuntu
