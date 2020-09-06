#!/bin/bash
SVFHOME=$(pwd)
sysOS=`uname -s`
MacLLVM="https://github.com/llvm/llvm-project/releases/download/llvmorg-10.0.0/clang+llvm-10.0.0-x86_64-apple-darwin.tar.xz"
UbuntuLLVM="https://github.com/llvm/llvm-project/releases/download/llvmorg-10.0.0/clang+llvm-10.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz"
LLVMHome="llvm-10.0.0.obj"
cd ..
########
# Download LLVM binary
########
if [[ $sysOS == "Darwin" ]]
then
       if [ ! -d "$HOME/$LLVMHome" ]
       then
       		echo 'Downloading LLVM binary for MacOS '
      		curl -L $MacLLVM > llvm-mac.tar.xz
      	 	mkdir $HOME/$LLVMHome 
		echo 'Unzipping LLVM binary for MacOS '
		tar -xf "llvm-mac.tar.xz" -C $HOME/$LLVMHome --strip-components 1
		rm llvm-mac.tar.xz
       fi
elif [[ $sysOS == "Linux" ]]
then
       if [ ! -d "$HOME/$LLVMHome" ]
       then
       		echo 'Downloading LLVM binary for Ubuntu'
      		wget -c $UbuntuLLVM -O llvm-ubuntu.tar.xz
      		mkdir $HOME/$LLVMHome 
		echo 'Unzipping LLVM binary for Ubuntu'
		tar -xf "llvm-ubuntu.tar.xz" -C $HOME/$LLVMHome --strip-components 1
		rm llvm-ubuntu.tar.xz
       fi
else
	echo 'not support builds in OS other than Ubuntu and Mac'
fi
cd $SVFHOME
cd ..
install_path=$(pwd)
echo "LLVM_DIR=$HOME/$LLVMHome"
if [[ $sysOS == "Darwin" ]]
then 
ln -s $install_path/svf-lib/SVF-osx $install_path/SVF
echo "SVF_DIR=$install_path/SVF/"
echo -e "Build your own project with the following cmake command:\n cmake -DSVF_DIR=$install_path/SVF/SVF-osx -DLLVM_DIR=$HOME/$LLVMHome"
elif [[ $sysOS == "Linux" ]]
then 
ln -s $install_path/svf-lib/SVF-linux $install_path/SVF
echo "SVF_DIR=$install_path/SVF/"
echo -e "Build your own project with the following cmake command:\n cmake -DSVF_DIR=$install_path/SVF/SVF-linux -DLLVM_DIR=$HOME/$LLVMHome"
fi
