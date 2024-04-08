
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was .config.cmake.in                            ########

get_filename_component(PACKAGE_${CMAKE_FIND_PACKAGE_NAME}_COUNTER_1 "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

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

set_and_check(SVF_INSTALL_ROOT "${PACKAGE_${CMAKE_FIND_PACKAGE_NAME}_COUNTER_1}")
set_and_check(SVF_INSTALL_BIN_DIR "${PACKAGE_${CMAKE_FIND_PACKAGE_NAME}_COUNTER_1}/bin")
set_and_check(SVF_INSTALL_LIB_DIR "${PACKAGE_${CMAKE_FIND_PACKAGE_NAME}_COUNTER_1}/lib")

set(SVF_INCLUDE_PATH "${PACKAGE_${CMAKE_FIND_PACKAGE_NAME}_COUNTER_1}/../svf/include")
set(SVF_LLVM_INCLUDE_PATH "${PACKAGE_${CMAKE_FIND_PACKAGE_NAME}_COUNTER_1}/../svf-llvm/include")

if(EXISTS ${SVF_INCLUDE_PATH} AND EXISTS ${SVF_LLVM_INCLUDE_PATH})
    set(SVF_INSTALL_INCLUDE_DIR "${SVF_INCLUDE_PATH};${SVF_LLVM_INCLUDE_PATH};${PACKAGE_${CMAKE_FIND_PACKAGE_NAME}_COUNTER_1}/include")
else()
    set_and_check(SVF_INSTALL_INCLUDE_DIR "${PACKAGE_${CMAKE_FIND_PACKAGE_NAME}_COUNTER_1}/include")
endif()

message(STATUS "SVF_INSTALL_INCLUDE_DIR is set to: ${SVF_INSTALL_INCLUDE_DIR}")

set_and_check(SVF_INSTALL_EXTAPI_DIR "${PACKAGE_${CMAKE_FIND_PACKAGE_NAME}_COUNTER_1}/lib")
set_and_check(SVF_INSTALL_EXTAPI_FILE "${PACKAGE_${CMAKE_FIND_PACKAGE_NAME}_COUNTER_1}/lib/extapi.bc")

set(SVF_SANITIZE "")

set(SVF_COVERAGE "OFF")
set(SVF_WARN_AS_ERROR "ON")
set(SVF_EXPORT_DYNAMIC "OFF")
set(SVF_ENABLE_ASSERTIONS "true")

set(SVF_BUILD_TYPE "Release")
set(SVF_CXX_STANDARD "17")

set(SVF_ENABLE_RTTI "OFF")
set(SVF_ENABLE_EXCEPTIONS "OFF")


