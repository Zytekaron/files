cmake_minimum_required(VERSION 3.6)
set(EXE "executable_name")
project(${EXE})

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c17")
set(CMAKE_EXPORT_COMPILE_COMMANDS on)

aux_source_directory("src" srcdir)
add_executable(${EXE} ${srcdir})
