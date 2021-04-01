cmake_minimum_required(VERSION 3.20)
project(lib_install VERSION 1.2.3)

add_library(${PROJECT_NAME} SHARED)
target_sources(${PROJECT_NAME}
  PRIVATE
    include/simple/echo.hpp
    src/echo.cpp
    src/echo_private.hpp)
target_include_directories(${PROJECT_NAME}
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>)

set_target_properties(${PROJECT_NAME}
  PROPERTIES
    VERSION ${PROJECT_VERSION}
    SOVERSION ${PROJECT_VERSION})

set(targets_export_name ${PROJECT_NAME}-targets)
set(include_install_dir include)

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include/
  DESTINATION ${include_install_dir})
install(TARGETS ${PROJECT_NAME}
  EXPORT ${targets_export_name}
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  INCLUDES DESTINATION ${include_install_dir})
install(EXPORT ${targets_export_name}
  DESTINATION lib/cmake/${PROJECT_NAME})
file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/config.cmake.in [==[
  include("${CMAKE_CURRENT_LIST_DIR}/@targets_export_name@.cmake")
]==])
include(CMakePackageConfigHelpers)
configure_package_config_file(
  ${CMAKE_CURRENT_BINARY_DIR}/config.cmake.in
  ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}-config.cmake
  INSTALL_DESTINATION lib/cmake/${PROJECT_NAME}
  PATH_VARS include_install_dir)
write_basic_package_version_file(
  ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}-config-version.cmake
  VERSION "${PROJECT_VERSION}" COMPATIBILITY SameMajorVersion)
install(
  FILES
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}-config.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}-config-version.cmake
  DESTINATION
    lib/cmake/${PROJECT_NAME})
