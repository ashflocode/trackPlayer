# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/trackInfo_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/trackInfo_autogen.dir/ParseCache.txt"
  "external/taglib/bindings/c/CMakeFiles/tag_c_autogen.dir/AutogenUsed.txt"
  "external/taglib/bindings/c/CMakeFiles/tag_c_autogen.dir/ParseCache.txt"
  "external/taglib/bindings/c/tag_c_autogen"
  "external/taglib/taglib/taglib_autogen"
  "trackInfo_autogen"
  )
endif()
