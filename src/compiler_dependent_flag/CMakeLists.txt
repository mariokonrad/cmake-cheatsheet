cmake_minimum_required(VERSION 3.20)
project(some_library)

add_library(${PROJECT_NAME})
target_sources(${PROJECT_NAME}
  PUBLIC
  include/library/foo.hpp
  include/library/bar.hpp
  PRIVATE
  src/foo.cpp
  src/bar.cpp)
target_compile_options(${PROJECT_NAME}
  PRIVATE
  $<$<CXX_COMPILER_ID:GNU>:-Werror>
  $<$<CXX_COMPILER_ID:Clang>:-Werror>
  $<$<CXX_COMPILER_ID:MSVC>:/WX>)

