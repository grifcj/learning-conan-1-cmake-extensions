include_guard(GLOBAL)

################################################################################
# FIND PACKAGE

macro(declare_source_package name)
	list(APPEND SRC_PKGS ${name})
endmacro()

macro(find_package name)
	if (${name} IN_LIST SRC_PKGS)
		message(STATUS "find_package ignored for ${name}")
	else()
		unset(${name}_DIR CACHE)
		_find_package(${ARGV})
	endif()
endmacro()

################################################################################
# INSTALL HELPERS

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

function(install_project_config)
   set(name ${PROJECT_NAME})

   configure_package_config_file(
		${CMAKE_CURRENT_LIST_DIR}/cmake/${name}Config.cmake.in
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
      DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/include/${name}
      DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
   )
endfunction()

function(install_project)
   install_project_config()
   install_project_targets()
   install_project_headers()
endfunction()

function(generate_cpp_info)
	foreach(target ${ARGV})
		message(STATUS "Evaluate target: ${target}")
		if (NOT TARGET ${target})
			message(FATAL_ERROR "Argument \"${target}\" is not a target. Cannot export cpp_info.")
		endif()

		get_target_property(INCLUDE_DIRS ${target} INTERFACE_INCLUDE_DIRECTORIES)
		string(REPLACE "$<BUILD_INTERFACE:" "$<1:" BUILD_INCLUDE_DIRS "${INCLUDE_DIRS}")
		string(REPLACE "$<INSTALL_INTERFACE:" "$<0:" BUILD_INCLUDE_DIRS "${BUILD_INCLUDE_DIRS}")
		string(REPLACE "$<BUILD_INTERFACE:" "$<0:" INSTALL_INCLUDE_DIRS "${INCLUDE_DIRS}")
		string(REPLACE "$<INSTALL_INTERFACE:" "$<1:" INSTALL_INCLUDE_DIRS "${INSTALL_INCLUDE_DIRS}")

		find_file(template_file "target-cpp-info-template.json.in")
		if (template_file)
			configure_file(
				${template_file}
				${CMAKE_BINARY_DIR}/target-${target}-cpp-info-template.json
				)
			file(GENERATE
				OUTPUT ${CMAKE_BINARY_DIR}/target-${target}-cpp-info.json
				INPUT ${CMAKE_BINARY_DIR}/target-${target}-cpp-info-template.json)

			# Erase cache variable set by find
			unset(template_file CACHE)
		else()
			message(FATAL_ERROR "Template file not found. Have CMAKE_INCLUDE_PATH "
				"or CMAKE_MODULE_PATH been set to include package directory?")
		endif()
	endforeach()
endfunction()

