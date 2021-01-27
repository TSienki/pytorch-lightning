#!/usr/bin/env bash

ROOT=$PWD

python -m pip install protobuf
git clone https://github.com/onnx/onnx.git
cd onnx
git submodule update --init --recursive
python setup.py install
cd $ROOT
rm -rf onnx


# https://github.com/microsoft/onnxruntime/blob/master/BUILD.md
git clone --recursive https://github.com/Microsoft/onnxruntime
cd onnxruntime

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    ./build.sh --config RelWithDebInfo --build_shared_lib --parallel
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    ./build.sh --config RelWithDebInfo --build_shared_lib --parallel --use_xcode
elif [[ "$OSTYPE" == "cygwin" ]]; then
    # POSIX compatibility layer and Linux environment emulation for Windows
    ./build.sh --config RelWithDebInfo --build_shared_lib --parallel
elif [[ "$OSTYPE" == "msys" ]]; then
    # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
    .\build.bat --config RelWithDebInfo --build_shared_lib --parallel
elif [[ "$OSTYPE" == "win32" ]]; then
    .\build.bat --config RelWithDebInfo --build_shared_lib --parallel
else
    echo $OSTYPE  # Unknown.
fi

cd $ROOT
rm -rf onnxruntime