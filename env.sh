sysOS=`uname -s`
LLVMHome="llvm-10.0.0.obj"
cd ..
install_path=$(pwd)
export LLVM_DIR=$install_path/$LLVMHome
if [[ $sysOS == "Darwin" ]]
then 
    export SVF_DIR=$install_path/SVF/SVF-osx
elif [[ $sysOS == "Linux" ]]
then 
    export SVF_DIR=$install_path/SVF/SVF-linux
fi 