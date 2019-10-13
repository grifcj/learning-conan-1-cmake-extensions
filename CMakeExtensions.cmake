################################################################################
# FIND PACKAGE

macro(declare_source_package name)
   file(WRITE "${PROJECT_BINARY_DIR}/__pkg/${name}/${name}Config.cmake")
   set(${name}_DIR "${PROJECT_BINARY_DIR}/__pkg/${name}" CACHE PATH "")
endmacro()

################################################################################
# INSTALL HELPERS

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

function(install_project_config)
   set(name ${PROJECT_NAME})

   configure_package_config_file(
      ${PROJECT_SOURCE_DIR}/cmake/${name}Config.cmake.in
      ${PROJECT_BINARY_DIR}/cmake/${name}Config.cmake
      INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${name}
   )

   write_basic_package_version_file(
      ${PROJECT_BINARY_DIR}/cmake/${name}ConfigVersion.cmake
      VERSION ${LOGGER_VERSION}
      COMPATIBILITY AnyNewerVersion
   )

   install(
      FILES
         ${PROJECT_BINARY_DIR}/cmake/${name}Config.cmake
         ${PROJECT_BINARY_DIR}/cmake/${name}ConfigVersion.cmake
      DESTINATION
         ${CMAKE_INSTALL_LIBDIR}/cmake/${name}
   )
endfunction()

function(install_project_targets)
   set(name ${PROJECT_NAME})

   install(
      TARGETS ${name}
      EXPORT ${name}Targets
      ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
      LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
      RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
      INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
   )

   install(
      EXPORT ${name}Targets
      FILE ${name}Targets.cmake
      NAMESPACE ${name}::
      DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${name}
   )
endfunction()

function(install_project_headers)
   set(name ${PROJECT_NAME})

   install(
      DIRECTORY ${PROJECT_SOURCE_DIR}/include/${name}
      DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
   )
endfunction()

function(install_project)
   install_project_config()
   install_project_targets()
   install_project_headers()
endfunction()

