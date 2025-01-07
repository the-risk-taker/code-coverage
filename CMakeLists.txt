cmake_minimum_required(VERSION 3.20)
project(Coverage LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_COLOR_DIAGNOSTICS ON)
set(CMAKE_BUILD_TYPE DEBUG)

if(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    add_compile_options(-coverage)
    add_link_options(-coverage)
endif()

include(CTest)

add_subdirectory(lib)
add_subdirectory(app)
add_subdirectory(test)

if(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    include(cmake/coverage.cmake)
endif()
