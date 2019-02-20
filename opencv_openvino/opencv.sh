opencvVersion="4.0.0"
echo "Installing opencv-$opencvVersion"
./opencv_prerequisites.sh
#git clone https://github.com/opencv/opencv.git
cd ./opencv
git checkout $opencvVersion
cd ..

#git clone https://github.com/opencv/opencv_contrib.git
#cd ./opencv_contrib
#git checkout $opencvVersion
#cd ..

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
    -d OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
	-D BUILD_EXAMPLES=ON ..


make -j$(nproc)
make install