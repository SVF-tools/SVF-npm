# Initialise the package config helper (sets the install prefix in a relocatable way)

####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was SVFConfig.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

macro(set_and_check _var _file)
  set(${_var} "${_file}")
  if(NOT EXISTS "${_file}")
    message(FATAL_ERROR "File or directory ${_file} referenced by variable ${_var} does not exist !")
  endif()
endmacro()

macro(check_required_components _NAME)
  foreach(comp ${${_NAME}_FIND_COMPONENTS})
    if(NOT ${_NAME}_${comp}_FOUND)
      if(${_NAME}_FIND_REQUIRED_${comp})
        set(${_NAME}_FOUND FALSE)
      endif()
    endif()
  endforeach()
endmacro()

####################################################################################

# Ensure the CMake files in this package's directory can be found
list(PREPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}" "${CMAKE_CURRENT_LIST_DIR}/Modules")

# Ensure SVF's targets & settings are available publicly
include("${CMAKE_CURRENT_LIST_DIR}/SVFTargets.cmake")

# Set basic variables from this SVF build
set(SVF_VERSION 3.1)
set(SVF_BUILD_TYPE Release)
set(SVF_SHARED_LIBS ON)
set(SVF_C_STANDARD 11)
set(SVF_CXX_STANDARD 17)
set(SVF_C_EXTENSIONS ON)
set(SVF_CXX_EXTENSIONS ON)
set(SVF_C_STANDARD_REQUIRED ON)
set(SVF_CXX_STANDARD_REQUIRED ON)

# Expose SVF's build opts
set(SVF_USE_PIC ON)
set(SVF_USE_LTO OFF)
set(SVF_USE_LLD OFF)
set(SVF_COVERAGE OFF)
set(SVF_DEBUG_INFO OFF)
set(SVF_WARN_AS_ERROR ON)
set(SVF_EXPORT_DYNAMIC OFF)
set(SVF_ENABLE_ASSERTIONS true)
set(SVF_ENABLE_EXCEPTIONS ON)
set(SVF_ENABLE_RTTI ON)

# Set the basic SVF paths based on the installed location (relocatable)
set_and_check(SVF_INSTALL_ROOT "${PACKAGE_PREFIX_DIR}")
set_and_check(SVF_INSTALL_PREFIX "${PACKAGE_PREFIX_DIR}")
set_and_check(SVF_INSTALL_BINDIR "${PACKAGE_PREFIX_DIR}/bin")
set_and_check(SVF_INSTALL_LIBDIR "${PACKAGE_PREFIX_DIR}/lib")
set_and_check(SVF_INSTALL_EXTAPIDIR "${PACKAGE_PREFIX_DIR}/lib")
set_and_check(SVF_INSTALL_INCLUDEDIR "${PACKAGE_PREFIX_DIR}/include")
set_and_check(SVF_INSTALL_PKGCONFDIR "${PACKAGE_PREFIX_DIR}/lib/pkgconfig")
set_and_check(SVF_INSTALL_CMAKECONFIGDIR "${PACKAGE_PREFIX_DIR}/lib/cmake/SVF")

# If SVF is used directly from a build-from-scratch directory (not installed),
# append the source include paths (SVF_INCLUDE_PATH and SVF_LLVM_INCLUDE_PATH)
# to SVF_INSTALL_INCLUDEDIR. This allows users to debug with in-tree headers.
set(SVF_INCLUDE_PATH "${PACKAGE_PREFIX_DIR}/include/../../svf/include")
set(SVF_LLVM_INCLUDE_PATH "${PACKAGE_PREFIX_DIR}/include/../../svf-llvm/include")
if(EXISTS ${SVF_INCLUDE_PATH} AND EXISTS ${SVF_LLVM_INCLUDE_PATH})
    set(SVF_INSTALL_INCLUDEDIR "${SVF_INCLUDE_PATH};${SVF_LLVM_INCLUDE_PATH};${PACKAGE_PREFIX_DIR}/include")
endif()

# For legacy support, also allow the "*_DIR" suffix for the above paths
set(SVF_INSTALL_BIN_DIR "${SVF_INSTALL_BINDIR}")
set(SVF_INSTALL_LIB_DIR "${SVF_INSTALL_LIBDIR}")
set(SVF_INSTALL_EXTAPI_DIR "${SVF_INSTALL_EXTAPIDIR}")
set(SVF_INSTALL_INCLUDE_DIR "${SVF_INSTALL_INCLUDEDIR}")
set(SVF_INSTALL_PKGCONF_DIR "${SVF_INSTALL_PKGCONFDIR}")
set(SVF_INSTALL_CMAKECONFIG_DIR "${SVF_INSTALL_CMAKECONFIGDIR}")

# Expose the installed location of the extapi.bc file (plus some legacy aliases)
set_and_check(SVF_INSTALL_EXTAPI_BC "${PACKAGE_PREFIX_DIR}/lib/extapi.bc")
set(SVF_INSTALL_EXTAPI_FILE "${SVF_INSTALL_EXTAPI_BC}")

# Shouldn't be used, but also expose source tree location
set(SVF_SOURCE_DIR "/home/runner/work/SVF/SVF")
set(SVF_BUILD_DIR "/home/runner/work/SVF/SVF/Release-build")

# Similarly expose the location of extapi.bc in the build tree
set(SVF_BUILD_EXTAPI_BC "/home/runner/work/SVF/SVF/Release-build/lib/extapi.bc")
set(SVF_EXTAPI_BC_NAME "extapi.bc")

# Add the absolute paths of the extapi.bc bitcode file to the imported target's compiler definitions interface
target_compile_definitions(SVF::SvfFlags INTERFACE SVF_INSTALL_EXTAPI_BC="${SVF_INSTALL_EXTAPI_BC}")

# Make `find_dependency()` available
include(CMakeFindDependencyMacro)

# Find Z3 (required)
find_dependency(Z3 REQUIRED)

# Find upstream LLVM (required)
find_dependency(LLVM CONFIG REQUIRED)

# Make the include/link directories & definitions available globally for users of SVF
separate_arguments(_LLVM_DEFINITIONS NATIVE_COMMAND ${LLVM_DEFINITIONS})
include_directories(SYSTEM ${LLVM_INCLUDE_DIRS})
link_directories(${LLVM_LIBRARY_DIRS})
add_definitions(${_LLVM_DEFINITIONS})

check_required_components("SVF")
