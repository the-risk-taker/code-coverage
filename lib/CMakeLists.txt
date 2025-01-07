add_library(lib library.hpp library.cpp)
target_include_directories(lib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

add_library(person person.hpp person.cpp)
target_include_directories(person PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
