opencvVersion="4.0.0"

git clone https://github.com/opencv/opencv.git
cd opencv
git checkout $opencvVersion

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
    -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-$opencvVersion/modules \
	-D PYTHON_EXECUTABLE=/home/jaysurplus/.pyenv/shims/python \
    -D PYTHON_INCLUDE_DIR=$(python -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())")  \
    -D PYTHON3_INCLUDE_DIRS=$(python -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())")  \
    -D PYTHON3_INCLUDE_DIRS2=$(python -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())")  \
    -D PYTHON3_LIBRARY=$(python -c "import distutils.sysconfig as sysconfig; print(sysconfig.get_config_var('LIBDIR'))") \
    -D PYTHON3_PACKAGES_PATH=$(python -c "import site; print(site.getsitepackages()[0])") \
	-D BUILD_EXAMPLES=ON ..