cmake_minimum_required(VERSION 3.13)
project(import_library)

find_path(HO_LIBRARY_PATH
  NAMES library
  PATHS ${CMAKE_CURRENT_SOURCE_DIR}/../headeronly_library/library/include
  NO_DEFAULT_PATH
)

if(HO_LIBRARY_PATH)
  add_library(headeronly::headeronly INTERFACE IMPORTED)
  set_target_properties(headeronly::headeronly
    PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES ${HO_LIBRARY_PATH})
endif()

add_executable(example)
target_sources(example
  PRIVATE src/main.cpp)
target_link_libraries(example
  PRIVATE headeronly::headeronly)
