#!/bin/bash
SVFHOME=$(pwd)
sysOS=`uname -s`
arch=`uname -m`
MajorLLVMVer=21
LLVMVer=${MajorLLVMVer}.1.0
Z3Ver=4.15.4
UbuntuLLVM_RTTI="https://github.com/bjjwwang/SVF-LLVM/releases/download/${LLVMVer}/llvm-${LLVMVer}-ubuntu22-rtti-x86-64.tar.gz"
UbuntuArmLLVM_RTTI="https://github.com/bjjwwang/SVF-LLVM/releases/download/${LLVMVer}/llvm-${LLVMVer}-ubuntu22-rtti-aarch64.tar.gz"

Z3PrebuiltBase="https://github.com/SVF-tools/SVF-npm/raw/prebuilt-libs"
UbuntuZ3Arm="${Z3PrebuiltBase}/z3-${Z3Ver}-arm64-ubuntu-22.04.zip"
UbuntuZ3="${Z3PrebuiltBase}/z3-${Z3Ver}-x86_64-ubuntu-22.04.zip"
MacOSZ3Arm="${Z3PrebuiltBase}/z3-${Z3Ver}-arm64-macos-14.zip"
Z3Home="z3.obj"
LLVMHome="llvm-${LLVMVer}.obj"

function download_file {
    if [[ $# -ne 2 ]]; then
        echo "$0: bad args to download_file!"
        exit 1
    fi

    local url="$1"
    local out="$2"

    local download_failed=false
    if command -v curl >/dev/null 2>&1; then
        if ! curl -fL "$url" -o "$out"; then
            download_failed=true
        fi
    elif command -v wget >/dev/null 2>&1; then
        if ! wget -c "$url" -O "$out"; then
            download_failed=true
        fi
    else
        echo "Cannot find curl or wget."
        exit 1
    fi

    if $download_failed; then
        echo "Failed to download $url"
        rm -f "$out"
        exit 1
    fi
}

function find_z3_root {
    local search_dir="$1"
    local candidate=""

    while IFS= read -r -d '' candidate; do
        if [[ -d "$candidate/include" && -d "$candidate/bin" ]]; then
            echo "$candidate"
            return 0
        fi
    done < <(find "$search_dir" -type d -print0)

    return 1
}

function unpack_z3_package {
    if [[ $# -ne 2 ]]; then
        echo "$0: bad args to unpack_z3_package!"
        exit 1
    fi

    local archive="$1"
    local target_dir="$2"
    local unpack_dir="z3-unpack"
    local nested_zip=""
    local nested_dir=""
    local z3_dir=""

    rm -rf "$unpack_dir" "$target_dir"
    mkdir "$unpack_dir"
    unzip -q "$archive" -d "$unpack_dir"

    while IFS= read -r -d '' nested_zip; do
        nested_dir="$unpack_dir/nested-$(basename "$nested_zip" .zip)"
        mkdir -p "$nested_dir"
        unzip -q "$nested_zip" -d "$nested_dir"
    done < <(find "$unpack_dir" -type f -name 'z3-*.zip' -print0)

    if ! z3_dir=$(find_z3_root "$unpack_dir"); then
        rm -rf "$unpack_dir"
        echo "Z3 package did not contain the expected bin/ and include/ layout."
        exit 1
    fi

    mv "$z3_dir" "$target_dir"
    rm -rf "$unpack_dir"
}

function fix_linux_z3_links {
    if [[ "$sysOS" != "Linux" ]]; then
        return
    fi

    if [[ -f "$Z3_DIR/bin/libz3.so" ]]; then
        ln -sf libz3.so "$Z3_DIR/bin/libz3.so.4"
    fi
}

function fix_macos_z3_load_paths {
    if [[ "$sysOS" != "Darwin" ]]; then
        return
    fi

    local z3_dylib="$Z3_DIR/bin/libz3.dylib"
    local z3_rpath="@loader_path/../../../${Z3Home}/bin"
    local binary=""

    if [[ -f "$z3_dylib" ]]; then
        install_name_tool -id "@rpath/libz3.dylib" "$z3_dylib"
    fi

    while IFS= read -r -d '' binary; do
        install_name_tool -change "/opt/homebrew/opt/z3/lib/libz3.4.15.dylib" "@rpath/libz3.dylib" "$binary" 2>/dev/null || true
        install_name_tool -change "/opt/homebrew/opt/z3/lib/libz3.dylib" "@rpath/libz3.dylib" "$binary" 2>/dev/null || true
        install_name_tool -change "libz3.dylib" "@rpath/libz3.dylib" "$binary" 2>/dev/null || true
        install_name_tool -add_rpath "$z3_rpath" "$binary" 2>/dev/null || true
    done < <(find "$SVFHOME/SVF-osx/bin" "$SVFHOME/SVF-osx/lib" \( -type f -perm -111 -o -name '*.dylib' \) -print0)
}

if [[ $sysOS == "Darwin" ]]
then
  # Create soft links for SvfLLVM
  lib=$(find "$SVFHOME/SVF-osx/lib" -name "libSvfLLVM.*.*.dylib" -type f)
  if [ -n "$lib" ]; then
    filename=$(basename "$lib")
    major_version=$(echo "$filename" | sed -E 's/libSvfLLVM\.([0-9]+)\.[0-9]+\.dylib/\1/')
    minor_version=$(echo "$filename" | sed -E 's/libSvfLLVM\.[0-9]+\.([0-9]+)\.dylib/\1/')
    # Create links for SvfLLVM
    ln -sf "$filename" "$SVFHOME/SVF-osx/lib/libSvfLLVM.$major_version.dylib"
    ln -sf "libSvfLLVM.$major_version.dylib" "$SVFHOME/SVF-osx/lib/libSvfLLVM.dylib"
    # Create links for SvfCore using the same version
    ln -sf "libSvfCore.$major_version.$minor_version.dylib" "$SVFHOME/SVF-osx/lib/libSvfCore.$major_version.dylib"
    ln -sf "libSvfCore.$major_version.dylib" "$SVFHOME/SVF-osx/lib/libSvfCore.dylib"
  fi
elif [[ $sysOS == "Linux" ]]
then
  # resume softlink libSvfLLVM.so since npm pack would ignore softlink
  lib=$(find "$SVFHOME/SVF-linux-${arch}/lib" -name "libSvfLLVM.so.*.*" -type f)
  if [ -n "$lib" ]; then
    filename=$(basename "$lib")
    major_version=$(echo "$filename" | sed -E 's/libSvfLLVM\.so\.([0-9]+)\.[0-9]+/\1/')
    minor_version=$(echo "$filename" | sed -E 's/libSvfLLVM\.so\.[0-9]+\.([0-9]+)/\1/')
    # Create links for SvfLLVM
    ln -sf "$filename" "$SVFHOME/SVF-linux-${arch}/lib/libSvfLLVM.so.$major_version"
    ln -sf "libSvfLLVM.so.$major_version" "$SVFHOME/SVF-linux-${arch}/lib/libSvfLLVM.so"
    # Create links for SvfCore using the same version
    ln -sf "libSvfCore.so.$major_version.$minor_version" "$SVFHOME/SVF-linux-${arch}/lib/libSvfCore.so.$major_version"
    ln -sf "libSvfCore.so.$major_version" "$SVFHOME/SVF-linux-${arch}/lib/libSvfCore.so"
  fi
fi

cd $SVFHOME
cd ..
install_path=$(pwd)

function check_and_install_brew {
    if command -v brew >/dev/null 2>&1; then
        echo "Homebrew is already installed."
    else
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        if [ $? -eq 0 ]; then
            echo "Homebrew installation completed."
        else
            echo "Homebrew installation failed."
            exit 1
        fi
    fi
}

########
# Download LLVM binary
########
if [[ $sysOS == "Darwin" ]]
then
       check_and_install_brew
       echo "Installing LLVM binary"
       brew install llvm@${MajorLLVMVer}
       # check whether llvm is installed
       if [ $? -eq 0 ]; then
              echo "LLVM binary installation completed."
       else
              echo "LLVM binary installation failed."
              exit 1
       fi
       mkdir -p $install_path/$LLVMHome
       ln -s $(brew --prefix llvm@${MajorLLVMVer})/* $install_path/$LLVMHome
elif [[ $sysOS == "Linux" ]]
then
     if [[ $arch == "aarch64" ]]
     then
       echo 'Downloading LLVM binary for Ubuntu arm64'
       LLVM_URL=$UbuntuArmLLVM_RTTI
     else
       echo 'Downloading LLVM binary for Ubuntu x86_64'
       LLVM_URL=$UbuntuLLVM_RTTI
     fi
     if [ ! -d "$install_path/$LLVMHome" ]
     then
         echo 'Downloading LLVM binary for Ubuntu'
         wget -c $LLVM_URL -O llvm-ubuntu.tar.xz
         mkdir $install_path/$LLVMHome
		     echo 'Unzipping LLVM binary for Ubuntu'
		     tar -xf "llvm-ubuntu.tar.xz" -C $install_path/$LLVMHome --strip-components 1
		     rm llvm-ubuntu.tar.xz
     fi
else
	echo 'not support llvm builds in OS other than Ubuntu and Mac'
fi
export LLVM_DIR="$install_path/$LLVMHome"
echo "LLVM_DIR=$LLVM_DIR"
########
# Download z3 binary
########
urlZ3=""
if [[ $sysOS == "Darwin" ]]
then
       if [ ! -d "$install_path/$Z3Home" ]
       then
         if [[ $arch == "arm64" ]]
         then
           urlZ3=$MacOSZ3Arm
         else
           echo "No prebuilt z3 binary is available for MacOS ${arch}."
           exit 1
         fi
         echo 'Downloading z3 binary for MacOS arm64'
         download_file "$urlZ3" z3.zip
         echo 'Unzipping z3 binary for MacOS'
         unpack_z3_package z3.zip "$install_path/$Z3Home"
         rm z3.zip
       fi
elif [[ $sysOS == "Linux" ]]
then
       if [[ $arch == "aarch64" ]]
       then
         echo 'Downloading z3 binary for Ubuntu arm64'
         urlZ3=$UbuntuZ3Arm
       else
         echo 'Downloading z3 binary for Ubuntu x86_64'
         urlZ3=$UbuntuZ3
       fi
       if [ ! -d "$install_path/$Z3Home" ]
       then
         echo 'Downloading z3 binary for Ubuntu'
         download_file "$urlZ3" z3.zip
         echo 'Unzipping z3 binary for Ubuntu'
         unpack_z3_package z3.zip "$install_path/$Z3Home"
         rm z3.zip
       fi
else
	echo 'not support z3 builds in OS other than Ubuntu and Mac'
fi
export Z3_DIR="$install_path/$Z3Home"
fix_linux_z3_links
fix_macos_z3_load_paths
echo "Z3_DIR=$Z3_DIR"
export SVF_DIR="$install_path/SVF"
echo "SVF_DIR=$SVF_DIR"

if [[ $sysOS == "Darwin" ]]
then
ln -s $install_path/svf-lib/SVF-osx $SVF_DIR
echo -e "Build your own project with the following cmake command:\n cmake -DSVF_DIR=$SVF_DIR -DLLVM_DIR=$LLVM_DIR"
elif [[ $sysOS == "Linux" ]]
then
ln -s $install_path/svf-lib/SVF-linux-${arch} $SVF_DIR
echo -e "Build your own project with the following cmake command:\n cmake -DSVF_DIR=$SVF_DIR -DLLVM_DIR=$LLVM_DIR"
fi
