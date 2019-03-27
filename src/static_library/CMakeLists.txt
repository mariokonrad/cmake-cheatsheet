cmake_minimum_required(VERSION 3.13)
project(static_library)
add_library(${PROJECT_NAME} STATIC)
target_sources(${PROJECT_NAME}
  PRIVATE
    src/echo.cpp
    include/simple/echo.hpp)
target_include_directories(${PROJECT_NAME}
  PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>)
