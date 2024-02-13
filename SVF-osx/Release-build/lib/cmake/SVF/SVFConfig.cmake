
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was .config.cmake.in                            ########

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

set_and_check(SVF_INSTALL_ROOT "${PACKAGE_PREFIX_DIR}")
set_and_check(SVF_INSTALL_BIN_DIR "${PACKAGE_PREFIX_DIR}/bin")
set_and_check(SVF_INSTALL_LIB_DIR "${PACKAGE_PREFIX_DIR}/lib")
set_and_check(SVF_INSTALL_INCLUDE_DIR "${PACKAGE_PREFIX_DIR}/include")

set_and_check(SVF_INSTALL_EXTAPI_DIR "${PACKAGE_PREFIX_DIR}/lib")
set_and_check(SVF_INSTALL_EXTAPI_FILE "${PACKAGE_PREFIX_DIR}/lib/extapi.bc")

set(SVF_SANITIZE "")

set(SVF_COVERAGE "OFF")
set(SVF_WARN_AS_ERROR "ON")
set(SVF_EXPORT_DYNAMIC "OFF")
set(SVF_ENABLE_ASSERTIONS "true")

set(SVF_BUILD_TYPE "Release")
set(SVF_CXX_STANDARD "17")

set(SVF_ENABLE_RTTI "ON")
set(SVF_ENABLE_EXCEPTIONS "ON")

include("${CMAKE_CURRENT_LIST_DIR}/SVFTargets.cmake")
