add_executable(test_lib lib/test_lib.cpp)
target_link_libraries(test_lib PRIVATE lib gcov)
add_test(NAME test_lib COMMAND test_lib)

add_executable(test_person person/test_person.cpp)
target_link_libraries(test_person PRIVATE person gcov)
add_test(NAME test_person COMMAND test_person)
