#----------------------------------------------------------------
# Generated CMake target import file for configuration "MinSizeRel".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "SVF::SvfCoreExtra" for configuration "MinSizeRel"
set_property(TARGET SVF::SvfCoreExtra APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(SVF::SvfCoreExtra PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_MINSIZEREL "CXX"
  IMPORTED_LOCATION_MINSIZEREL "${_IMPORT_PREFIX}/lib/SvfCoreExtra.lib"
  )

list(APPEND _cmake_import_check_targets SVF::SvfCoreExtra )
list(APPEND _cmake_import_check_files_for_SVF::SvfCoreExtra "${_IMPORT_PREFIX}/lib/SvfCoreExtra.lib" )

# Import target "SVF::SvfCore" for configuration "MinSizeRel"
set_property(TARGET SVF::SvfCore APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(SVF::SvfCore PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_MINSIZEREL "CXX"
  IMPORTED_LOCATION_MINSIZEREL "${_IMPORT_PREFIX}/lib/SvfCore.lib"
  )

list(APPEND _cmake_import_check_targets SVF::SvfCore )
list(APPEND _cmake_import_check_files_for_SVF::SvfCore "${_IMPORT_PREFIX}/lib/SvfCore.lib" )

# Import target "SVF::SvfLLVM" for configuration "MinSizeRel"
set_property(TARGET SVF::SvfLLVM APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(SVF::SvfLLVM PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_MINSIZEREL "CXX"
  IMPORTED_LOCATION_MINSIZEREL "${_IMPORT_PREFIX}/lib/SvfLLVM.lib"
  )

list(APPEND _cmake_import_check_targets SVF::SvfLLVM )
list(APPEND _cmake_import_check_files_for_SVF::SvfLLVM "${_IMPORT_PREFIX}/lib/SvfLLVM.lib" )

# Import target "SVF::ae" for configuration "MinSizeRel"
set_property(TARGET SVF::ae APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(SVF::ae PROPERTIES
  IMPORTED_LOCATION_MINSIZEREL "${_IMPORT_PREFIX}/bin/ae.exe"
  )

list(APPEND _cmake_import_check_targets SVF::ae )
list(APPEND _cmake_import_check_files_for_SVF::ae "${_IMPORT_PREFIX}/bin/ae.exe" )

# Import target "SVF::cfl" for configuration "MinSizeRel"
set_property(TARGET SVF::cfl APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(SVF::cfl PROPERTIES
  IMPORTED_LOCATION_MINSIZEREL "${_IMPORT_PREFIX}/bin/cfl.exe"
  )

list(APPEND _cmake_import_check_targets SVF::cfl )
list(APPEND _cmake_import_check_files_for_SVF::cfl "${_IMPORT_PREFIX}/bin/cfl.exe" )

# Import target "SVF::dvf" for configuration "MinSizeRel"
set_property(TARGET SVF::dvf APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(SVF::dvf PROPERTIES
  IMPORTED_LOCATION_MINSIZEREL "${_IMPORT_PREFIX}/bin/dvf.exe"
  )

list(APPEND _cmake_import_check_targets SVF::dvf )
list(APPEND _cmake_import_check_files_for_SVF::dvf "${_IMPORT_PREFIX}/bin/dvf.exe" )

# Import target "SVF::llvm2svf" for configuration "MinSizeRel"
set_property(TARGET SVF::llvm2svf APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(SVF::llvm2svf PROPERTIES
  IMPORTED_LOCATION_MINSIZEREL "${_IMPORT_PREFIX}/bin/llvm2svf.exe"
  )

list(APPEND _cmake_import_check_targets SVF::llvm2svf )
list(APPEND _cmake_import_check_files_for_SVF::llvm2svf "${_IMPORT_PREFIX}/bin/llvm2svf.exe" )

# Import target "SVF::mta" for configuration "MinSizeRel"
set_property(TARGET SVF::mta APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(SVF::mta PROPERTIES
  IMPORTED_LOCATION_MINSIZEREL "${_IMPORT_PREFIX}/bin/mta.exe"
  )

list(APPEND _cmake_import_check_targets SVF::mta )
list(APPEND _cmake_import_check_files_for_SVF::mta "${_IMPORT_PREFIX}/bin/mta.exe" )

# Import target "SVF::saber" for configuration "MinSizeRel"
set_property(TARGET SVF::saber APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(SVF::saber PROPERTIES
  IMPORTED_LOCATION_MINSIZEREL "${_IMPORT_PREFIX}/bin/saber.exe"
  )

list(APPEND _cmake_import_check_targets SVF::saber )
list(APPEND _cmake_import_check_files_for_SVF::saber "${_IMPORT_PREFIX}/bin/saber.exe" )

# Import target "SVF::svf-ex" for configuration "MinSizeRel"
set_property(TARGET SVF::svf-ex APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(SVF::svf-ex PROPERTIES
  IMPORTED_LOCATION_MINSIZEREL "${_IMPORT_PREFIX}/bin/svf-ex.exe"
  )

list(APPEND _cmake_import_check_targets SVF::svf-ex )
list(APPEND _cmake_import_check_files_for_SVF::svf-ex "${_IMPORT_PREFIX}/bin/svf-ex.exe" )

# Import target "SVF::wpa" for configuration "MinSizeRel"
set_property(TARGET SVF::wpa APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(SVF::wpa PROPERTIES
  IMPORTED_LOCATION_MINSIZEREL "${_IMPORT_PREFIX}/bin/wpa.exe"
  )

list(APPEND _cmake_import_check_targets SVF::wpa )
list(APPEND _cmake_import_check_files_for_SVF::wpa "${_IMPORT_PREFIX}/bin/wpa.exe" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
