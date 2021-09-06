#!/bin/bash
SVFHOME=$(pwd)
sysOS=`uname -s`
MacLLVM="https://github.com/llvm/llvm-project/releases/download/llvmorg-12.0.0/clang+llvm-12.0.0-x86_64-apple-darwin.tar.xz"
UbuntuLLVM="https://github.com/llvm/llvm-project/releases/download/llvmorg-12.0.0/clang+llvm-12.0.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz"
MacZ3="https://github.com/Z3Prover/z3/releases/download/z3-4.8.8/z3-4.8.8-x64-osx-10.14.6.zip"
UbuntuZ3="https://github.com/Z3Prover/z3/releases/download/z3-4.8.8/z3-4.8.8-x64-ubuntu-16.04.zip"
Z3Home="z3.obj"
LLVMHome="llvm-12.0.0.obj"
cd $SVFHOME
cd ..
install_path=$(pwd)
########
# Download LLVM binary
########
if [[ $sysOS == "Darwin" ]]
then
       if [ ! -d "$install_path/$LLVMHome" ]
       then
       		echo 'Downloading LLVM binary for MacOS '
      		curl -L $MacLLVM > llvm-mac.tar.xz
      	 	mkdir $install_path/$LLVMHome 
		echo 'Unzipping LLVM binary for MacOS '
		tar -xf "llvm-mac.tar.xz" -C $install_path/$LLVMHome --strip-components 1
		rm llvm-mac.tar.xz
       fi
elif [[ $sysOS == "Linux" ]]
then
       if [ ! -d "$install_path/$LLVMHome" ]
       then
       		echo 'Downloading LLVM binary for Ubuntu'
      		wget -c $UbuntuLLVM -O llvm-ubuntu.tar.xz
      		mkdir $install_path/$LLVMHome 
		echo 'Unzipping LLVM binary for Ubuntu'
		tar -xf "llvm-ubuntu.tar.xz" -C $install_path/$LLVMHome --strip-components 1
		rm llvm-ubuntu.tar.xz
       fi
else
	echo 'not support llvm builds in OS other than Ubuntu and Mac'
fi
echo "LLVM_DIR=$install_path/$LLVMHome"
########
# Download z3 binary
########
if [[ $sysOS == "Darwin" ]]
then
       if [ ! -d "$install_path/$Z3Home" ]
       then
       		echo 'Downloading z3 binary for MacOS '
      		curl -L $MacZ3 > z3.zip
      	 	mkdir $install_path/$Z3Home 
		echo 'Unzipping z3 binary for MacOS '
        unzip -q "z3.zip" && mv ./z3-*/* $install_path/$Z3Home/
		rm z3.zip
       fi
elif [[ $sysOS == "Linux" ]]
then
       if [ ! -d "$install_path/$Z3Home" ]
       then
       		echo 'Downloading z3 binary for Ubuntu'
      		wget -c $UbuntuZ3 -O z3.zip
      		mkdir $install_path/$Z3Home 
		echo 'Unzipping z3 binary for Ubuntu'
        unzip -q "z3.zip" && mv ./z3-*/* $install_path/$Z3Home/
		rm z3.zip
       fi
else
	echo 'not support z3 builds in OS other than Ubuntu and Mac'
fi
echo "Z3_DIR=$install_path/$Z3Home"
if [[ $sysOS == "Darwin" ]]
then 
ln -s $install_path/svf-lib/SVF-osx $install_path/SVF
echo "SVF_DIR=$install_path/SVF/"
echo -e "Build your own project with the following cmake command:\n cmake -DSVF_DIR=$install_path/SVF/SVF-osx -DLLVM_DIR=$install_path/$LLVMHome"
elif [[ $sysOS == "Linux" ]]
then 
ln -s $install_path/svf-lib/SVF-linux $install_path/SVF
echo "SVF_DIR=$install_path/SVF/"
echo -e "Build your own project with the following cmake command:\n cmake -DSVF_DIR=$install_path/SVF/SVF-linux -DLLVM_DIR=$install_path/$LLVMHome"
fi
