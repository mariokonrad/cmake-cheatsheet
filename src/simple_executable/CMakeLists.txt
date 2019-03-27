cmake_minimum_required(VERSION 3.13)
project(simple_executable)
add_executable(${PROJECT_NAME})
target_sources(${PROJECT_NAME} PRIVATE main.cpp)
