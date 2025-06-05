#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "SVF::SvfCore" for configuration "Release"
set_property(TARGET SVF::SvfCore APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(SVF::SvfCore PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libSvfCore.3.2.dylib"
  IMPORTED_SONAME_RELEASE "@rpath/libSvfCore.3.dylib"
  )

list(APPEND _cmake_import_check_targets SVF::SvfCore )
list(APPEND _cmake_import_check_files_for_SVF::SvfCore "${_IMPORT_PREFIX}/lib/libSvfCore.3.2.dylib" )

# Import target "SVF::SvfLLVM" for configuration "Release"
set_property(TARGET SVF::SvfLLVM APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(SVF::SvfLLVM PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libSvfLLVM.3.2.dylib"
  IMPORTED_SONAME_RELEASE "@rpath/libSvfLLVM.3.dylib"
  )

list(APPEND _cmake_import_check_targets SVF::SvfLLVM )
list(APPEND _cmake_import_check_files_for_SVF::SvfLLVM "${_IMPORT_PREFIX}/lib/libSvfLLVM.3.2.dylib" )

# Import target "SVF::ae" for configuration "Release"
set_property(TARGET SVF::ae APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(SVF::ae PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/bin/ae"
  )

list(APPEND _cmake_import_check_targets SVF::ae )
list(APPEND _cmake_import_check_files_for_SVF::ae "${_IMPORT_PREFIX}/bin/ae" )

# Import target "SVF::cfl" for configuration "Release"
set_property(TARGET SVF::cfl APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(SVF::cfl PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/bin/cfl"
  )

list(APPEND _cmake_import_check_targets SVF::cfl )
list(APPEND _cmake_import_check_files_for_SVF::cfl "${_IMPORT_PREFIX}/bin/cfl" )

# Import target "SVF::dvf" for configuration "Release"
set_property(TARGET SVF::dvf APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(SVF::dvf PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/bin/dvf"
  )

list(APPEND _cmake_import_check_targets SVF::dvf )
list(APPEND _cmake_import_check_files_for_SVF::dvf "${_IMPORT_PREFIX}/bin/dvf" )

# Import target "SVF::llvm2svf" for configuration "Release"
set_property(TARGET SVF::llvm2svf APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(SVF::llvm2svf PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/bin/llvm2svf"
  )

list(APPEND _cmake_import_check_targets SVF::llvm2svf )
list(APPEND _cmake_import_check_files_for_SVF::llvm2svf "${_IMPORT_PREFIX}/bin/llvm2svf" )

# Import target "SVF::mta" for configuration "Release"
set_property(TARGET SVF::mta APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(SVF::mta PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/bin/mta"
  )

list(APPEND _cmake_import_check_targets SVF::mta )
list(APPEND _cmake_import_check_files_for_SVF::mta "${_IMPORT_PREFIX}/bin/mta" )

# Import target "SVF::saber" for configuration "Release"
set_property(TARGET SVF::saber APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(SVF::saber PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/bin/saber"
  )

list(APPEND _cmake_import_check_targets SVF::saber )
list(APPEND _cmake_import_check_files_for_SVF::saber "${_IMPORT_PREFIX}/bin/saber" )

# Import target "SVF::svf-ex" for configuration "Release"
set_property(TARGET SVF::svf-ex APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(SVF::svf-ex PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/bin/svf-ex"
  )

list(APPEND _cmake_import_check_targets SVF::svf-ex )
list(APPEND _cmake_import_check_files_for_SVF::svf-ex "${_IMPORT_PREFIX}/bin/svf-ex" )

# Import target "SVF::wpa" for configuration "Release"
set_property(TARGET SVF::wpa APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(SVF::wpa PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/bin/wpa"
  )

list(APPEND _cmake_import_check_targets SVF::wpa )
list(APPEND _cmake_import_check_files_for_SVF::wpa "${_IMPORT_PREFIX}/bin/wpa" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
