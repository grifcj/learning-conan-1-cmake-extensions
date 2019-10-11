cmake_minimum_required(VERSION 2.8.12)
project(PackageTest CXX)

include("${CMAKE_BINARY_DIR}/conan_paths.cmake")

include(CMakeExtensions)
declare_source_package(package)

if (package_DIR STREQUAL ${CMAKE_BINARY_DIR}/__pkg/package/packageConfig.cmake)
	message(FATAL_ERROR "Must define fake config to convert find_package to noop")
endif()
