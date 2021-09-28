#!/bin/sh

if [ "$1" = "libOpenCOR" -o "$1" = "OpenCOR" ]; then
    mode=$1
elif [ "$1" != "" ]; then
    echo "Usage: $0 [libOpenCOR|OpenCOR]"

    exit 1
fi

if [ "`hash ninja 2>&1`" = "" ]; then
    ninjaFound=true
    generator="Ninja"
    cmakeGenerator="Ninja"
else
    ninjaFound=false
    generator="Make"
    cmakeGenerator="Unix Makefiles"
fi

if [ "$1" == "" ]; then
    echo "\033[44;37;1mMaking the general documentation for libOpenCOR and OpenCOR (using $generator)...\033[0m"
else
    echo "\033[44;37;1mMaking the general documentation for $mode (using $generator)...\033[0m"
fi

cd build

cmake -G "$cmakeGenerator" -DMODE=$mode ..

exitCode=$?

if [ $exitCode -ne 0 ]; then
    cd ..

    exit $exitCode
fi

if [ $# -gt 0 ]; then
    shift
fi

if [ $ninjaFound = true ]; then
    ninja $@
else
    make $@
fi

exitCode=$?

cd ..

if [ $exitCode -eq 0 ]; then
    echo "\033[42;37;1mAll done!\033[0m"
fi

exit $exitCode
