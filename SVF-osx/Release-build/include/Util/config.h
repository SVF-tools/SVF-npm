#ifndef CONFIG_H_IN
#define CONFIG_H_IN

// Directory structure of SVF build
#define SVF_ROOT "/Users/runner/work/SVF/SVF"
#define SVF_BUILD_DIR "/Users/runner/work/SVF/SVF/Release-build"
#define SVF_INSTALL_DIR "/usr/local"
#define SVF_BIN_DIR SVF_INSTALL_DIR "/bin"
#define SVF_LIB_DIR SVF_INSTALL_DIR "/lib"
#define SVF_INCLUDE_DIR SVF_INSTALL_DIR "/include"
#define SVF_EXTAPI_DIR SVF_INCLUDE_DIR "/SVF-LLVM"
#define SVF_EXTAPI_BC SVF_EXTAPI_DIR "/extapi.bc"

// Build properties of current SVF build
#define SVF_BUILD_TYPE "Release"
/* #undef SVF_ASSERT_MODE */
/* #undef SVF_COVERAGE */
/* #undef SVF_SANITIZE */


#endif
