cmake_minimum_required(VERSION 3.20)
project(externalproject)

find_package(Boost 1.58 COMPONENTS program_options REQUIRED)

file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/local/include)

include(ExternalProject)
ExternalProject_Add(extern-zlib
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/zlib
  URL
    file://${CMAKE_CURRENT_SOURCE_DIR}/extern/zlib-1.2.8.tar.gz
  URL_HASH
    MD5=44d667c142d7cda120332623eab69f40
  CMAKE_ARGS
    -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_INSTALL_PREFIX=${CMAKE_CURRENT_BINARY_DIR}/local
  INSTALL_DIR ${CMAKE_CURRENT_BINARY_DIR}/local)

add_library(zlib::zlib STATIC IMPORTED)
add_dependencies(zlib::zlib extern-zlib)
set_target_properties(zlib::zlib PROPERTIES
  IMPORTED_LOCATION
    ${CMAKE_CURRENT_BINARY_DIR}/local/lib/${CMAKE_STATIC_LIBRARY_PREFIX}z${CMAKE_STATIC_LIBRARY_SUFFIX}
  INTERFACE_INCLUDE_DIRECTORIES
    ${CMAKE_CURRENT_BINARY_DIR}/local/include)

add_executable(${PROJECT_NAME})
target_sources(${PROJECT_NAME}
  PRIVATE src/main.cpp)
target_link_libraries(${PROJECT_NAME}
  PRIVATE zlib::zlib Boost::program_options)
