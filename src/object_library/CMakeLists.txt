cmake_minimum_required(VERSION 3.20)
project(object_library)

add_library(${PROJECT_NAME}-obj OBJECT)
target_sources(${PROJECT_NAME}-obj
  PRIVATE src/echo.cpp include/simple/echo.hpp)
target_include_directories(${PROJECT_NAME}-obj
  PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>)

set_property(TARGET ${PROJECT_NAME}-obj
  PROPERTY POSITION_INDEPENDENT_CODE 1)

add_library(${PROJECT_NAME}-static STATIC
  $<TARGET_OBJECTS:${PROJECT_NAME}-obj>)
add_library(${PROJECT_NAME}-shared SHARED
  $<TARGET_OBJECTS:${PROJECT_NAME}-obj>)
