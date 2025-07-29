cmake_minimum_required(VERSION 3.14)
project(my_project)

# GoogleTest requires at least C++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(FetchContent)
FetchContent_Declare(
  googletest
	GIT_REPOSITORY  https://github.com/google/googletest.git
	GIT_TAG v1.17.0
)
# For Windows: Prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

enable_testing()

# if you want to use google test in C, add library of C code
# add_library(sample_lib, srcs/sample.c)

# -------------------------# Add the GoogleTest library -------------------------
# Create a test executable
add_executable(
	# Put the name of your test name and test source files here
	# example
	sample_test
	srcs/main.cpp
	tests/main_test.cpp

	#if you want to use C, write below
	# sample_test
	# tests/sample_test.c
)

target_link_libraries(
	# Link your test executable with GoogleTest
	# example 
	sample_test
  GTest::gtest_main

	# if you want to use C, write below
	# sample_test
	# PRIVATE sample_lib
	# GTest::gtest_main
)

add_test(
	# Add your test to CTest
	# example
	NAME sample_test 
	COMMAND sample_test 
)


# when you want to add your test, write it here 

# add_executabel(
	# other_test
	# srcs/other.cpp
	# tests/other_test.cpp
# )

# target_link_libraries(
	# other_test
	# GTest::gtest_main
# )

# add_test(
	# Add your test to CTest
	# example
	# NAME other_test it can change name of test
	# COMMAND other_test 
# )
# include(GoogleTest)

# -------------------------# Add the GoogleTest library path -------------------------
target_include_directories(sample_test PRIVATE ${CMAKE_SOURCE_DIR}/includes)
# if you want to use C, write below
# target_include_directories(sample_lib PRIVATE ${CMAKE_SOURCE_DIR}/includes)
# target_include_directories(othertest PRIVATE ${CMAKE_SOURCE_DIR}/includes)
