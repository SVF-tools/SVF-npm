#ifndef CONFIG_H_IN
#define CONFIG_H_IN

// Directory structure of SVF build
#define SVF_ROOT "/home/runner/work/SVF/SVF"
#define SVF_BUILD_DIR "/home/runner/work/SVF/SVF/Release-build"
#define SVF_INSTALL_DIR "/usr/local"
#define SVF_BIN_DIR "/usr/local/bin"
#define SVF_LIB_DIR "/usr/local/lib"
#define SVF_INCLUDE_DIR "/usr/local/include/svf"
#define SVF_EXTAPI_DIR "/usr/local/include/svf/SVF-LLVM"
#define SVF_EXTAPI_BC "/usr/local/include/svf/SVF-LLVM/extapi.bc"

// Build mode used to build SVF
#define SVF_BUILD_TYPE "Release"

// Sanitiser mode used for building SVF
/* #undef SVF_SANITIZE */

// Build options used when building SVF
/* #undef SVF_COVERAGE */
#define SVF_WARN_AS_ERROR
/* #undef SVF_EXPORT_DYNAMIC */
#define SVF_ENABLE_ASSERTIONS

#endif // CONFIG_H_IN
