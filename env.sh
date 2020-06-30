sysOS=`uname -s`
LLVMHome="llvm-10.0.0.obj"
cd ..
install_path=$(dirname $(readlink -f $0))
export LLVM_DIR=$install_path/$LLVMHome
export PATH=$LLVM_DIR/bin:$PATH
if [[ $sysOS == "Darwin" ]]
then 
    export SVF_DIR=$install_path/SVF/SVF-osx
elif [[ $sysOS == "Linux" ]]
then 
    export SVF_DIR=$install_path/SVF/SVF-linux
fi 

echo $LLVM_DIR
echo $SVF_DIR