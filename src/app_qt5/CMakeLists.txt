cmake_minimum_required(VERSION 3.20)
project(app_qt5)

if(NOT EXISTS $ENV{QTHOME})
  message(FATAL_ERROR "directory QTHOME does not exist")
endif()

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt5Core REQUIRED)
find_package(Qt5Widgets REQUIRED)

add_executable(${PROJECT_NAME})
target_sources(${PROJECT_NAME}
  PRIVATE
    src/main.cpp
    src/demo_application.cpp)
target_link_libraries(${PROJECT_NAME}
  PRIVATE Qt5::Core Qt5::Widgets)
