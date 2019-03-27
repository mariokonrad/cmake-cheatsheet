cmake_minimum_required(VERSION 3.13)
project(library_with_test)

add_library(${PROJECT_NAME} STATIC)
target_sources(${PROJECT_NAME}
  PUBLIC library/include/library/echo.hpp
  PRIVATE library/src/echo.cpp)
target_include_directories(${PROJECT_NAME}
  PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/library/include>)

add_executable(testrunner)
target_sources(testrunner
  PRIVATE testrunner/src/main.cpp)
target_link_libraries(testrunner
  PRIVATE ${PROJECT_NAME})

enable_testing()
add_test(
  NAME ${PROJECT_NAME}-test-1
  COMMAND testrunner "Hello World")
add_test(
  NAME ${PROJECT_NAME}-test-2
  COMMAND testrunner "Hallo Welt")
