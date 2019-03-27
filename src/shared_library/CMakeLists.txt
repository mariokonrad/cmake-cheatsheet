cmake_minimum_required(VERSION 3.13)
project(shared_library)
add_library(${PROJECT_NAME} SHARED)
target_sources(${PROJECT_NAME}
  PUBLIC include/simple/echo.hpp
  PRIVATE src/echo.cpp src/echo_private.hpp)
target_include_directories(${PROJECT_NAME}
  PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>)
