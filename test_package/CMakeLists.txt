cmake_minimum_required(VERSION 2.8.12)
project(PackageTest CXX)

include("${CMAKE_BINARY_DIR}/conanbuildinfo.cmake")
conan_basic_setup()

include(CMakePrintHelpers)
set(CMAKE_INCLUDE_PATH ${CMAKE_MODULE_PATH})

add_library(target main.cpp)
target_include_directories(target
	PUBLIC
		$<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}>
		$<INSTALL_INTERFACE:include>
	PRIVATE
		${CMAKE_CURRENT_LIST_DIR}/SomeBullshit)

include(CMakeExtensions)
declare_source_package(package)
generate_cpp_info(target)
