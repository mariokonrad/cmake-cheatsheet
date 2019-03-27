cmake_minimum_required(VERSION 3.13)
project(executable_with_libs)
find_package(ZLIB REQUIRED)
find_package(Boost 1.58 COMPONENTS program_options REQUIRED)
add_executable(${PROJECT_NAME})
target_sources(${PROJECT_NAME}
  PRIVATE src/main.cpp)
target_link_libraries(${PROJECT_NAME}
  PRIVATE ZLIB::ZLIB Boost::program_options)
