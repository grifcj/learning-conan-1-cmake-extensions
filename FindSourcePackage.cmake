macro(declare_source_package name)
  file(WRITE "${CMAKE_BINARY_DIR}/__pkg/${name}/${name}Config.cmake")
  set(${name}_DIR "${CMAKE_BINARY_DIR}/__pkg/${name}" CACHE PATH "")
endmacro()
