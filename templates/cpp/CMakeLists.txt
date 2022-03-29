cmake_minimum_required(VERSION 3.6)
set(EXE "executable_name")
project(${EXE})

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++20")
set(CMAKE_EXPORT_COMPILE_COMMANDS on)

aux_source_directory("src" srcdir)
add_executable(${EXE} ${srcdir})
