cmake_minimum_required(VERSION 3.2)

add_library(MiniAudio MiniAudio.c)

target_include_directories(MiniAudio INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})
