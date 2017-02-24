#!/bin/sh
set -e
cd `dirname "$0"`/..
if [ "$ARCH" = "i686" ]; then
  f=i686-4.9.2-release-win32-sjlj-rt_v3-rev1.7z
  if ! [ -e $f ]; then
    curl -LsSO http://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win32/Personal%20Builds/mingw-builds/4.9.2/threads-win32/sjlj/$f
  fi
  7z x $f > /dev/null
  export PATH=`pwd`/mingw32:$PATH
  echo "PATH is: $PATH"
else
  f=x86_64-4.9.2-release-win32-seh-rt_v3-rev1.7z
  if ! [ -e $f ]; then
    curl -LsSO http://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/4.9.2/threads-win32/seh/$f
  fi
  7z x $f > /dev/null
  export PATH=`pwd`/mingw64:$PATH
  echo "PATH is: $PATH"
fi
ls -Flas `pwd`/mingw32
ls -Flas `pwd`/mingw64
which gcc
gcc --version
cmake --version
cd build
cmake -D ENABLE_TRACE=ON -D BUILD_CLAR=ON .. -G"$GENERATOR"
cmake --build . --config RelWithDebInfo
