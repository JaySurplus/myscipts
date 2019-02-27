############################################################################
#                                                                          #
#                                                                          #
#                                                                          #
#                                                                          #
#                                                                          #
#                                                                          #
#                                                                          #
############################################################################

# Dare you change this!!!
if which tput >/dev/null 2>&1; then
      ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
fi

# Now you can change!

opencvVersion="4.0.1"

printf "$GREEN$BOLD"
echo "Installing opencv-$opencvVersion"
printf "$NORMAL"

printf ""
printf "$GREEN"
echo "Installing opencv prerequisities."
printf "$NORMAL"
exit 1
./opencv_prerequisites.sh
#git clone https://github.com/opencv/opencv.git

printf "$RED"
echo "Cleaning up opencv and opencv_contrib directories."
printf "$NORMAL"
if [ -d ./opencv ]; then
    rm -rf ./opencv
fi

if [ -d ./opencv_contrib ]; then
    rm -rf ./opencv_contrib
fi

printf "$GREEN"
echo "Fetching opencv and opencv_contrib source code."
if [ -f opencv-$opencvVersion.zip ]; then
    unzip opencv-$opencvVersion
    mv opencv-$opencvVersion opencv
else
    git clone https://github.com/opencv/opencv.git
    cd ./opencv
    git checkout $opencvVersion
    cd ..
fi

if [ -f opencv_contrib-$opencvVersion.zip ]; then
    unzip opencv_contrib-$opencvVersion
    mv opencv_contrib-$opencvVersion opencv_contrib
else
    git clone https://github.com/opencv/opencv_contrib.git
    cd ./opencv_contrib
    git checkout $opencvVersion
    cd ..
fi
printf "$NORMAL"

printf "$GREEN"
echo "Installing opencv and opencv_contrib to selected python enviorment."
cd opencv
mkdir build
cd build

cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=/usr/local \
	-D INSTALL_PYTHON_EXAMPLES=ON \
    -D INSTALL_C_EXAMPLES=OFF \
    -D WITH_INF_ENGINE=ON \
    -D ENABLE_CXX11=ON \
    -D WITH_OPENGL=ON \
    -D WITH_TBB=ON \
    -D WITH_V4L=ON \
    -D OPENCV_ENABLE_NONFREE=ON \
    -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
    -D PYTHON_EXECUTABLE=/home/$(whoami)/.pyenv/shims/python \
    -D PYTHON_INCLUDE_DIR=$(python -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())")  \
    -D PYTHON3_INCLUDE_DIRS=$(python -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())")  \
    -D PYTHON3_INCLUDE_DIRS2=$(python -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())")  \
    -D PYTHON3_LIBRARY=$(python -c "import distutils.sysconfig as sysconfig; print(sysconfig.get_config_var('LIBDIR'))") \
    -D PYTHON3_PACKAGES_PATH=$(python -c "import site; print(site.getsitepackages()[0])") \
	-D BUILD_EXAMPLES=ON ..


make -j$(nproc)
sudo make install
sudo ldconfig
printf "$NORMAL"


