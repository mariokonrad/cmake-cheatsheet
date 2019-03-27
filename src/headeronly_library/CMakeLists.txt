cmake_minimum_required(VERSION 3.13)
project(headeronly_library)

add_library(${PROJECT_NAME} INTERFACE)
target_include_directories(${PROJECT_NAME}
  INTERFACE
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/library/include>)

add_executable(example)
target_sources(example
  PRIVATE src/main.cpp)
target_link_libraries(example
  PRIVATE ${PROJECT_NAME})
