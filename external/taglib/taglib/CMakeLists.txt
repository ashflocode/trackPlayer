cmake_minimum_required(VERSION 3.4.3)

set(CMAKE_AUTOMOC Off)

file(GLOB_RECURSE TAGLIB_HEADER_FILES RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" "*.h")
file(GLOB_RECURSE TAGLIB_SOURCE_FILES RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" "*.cpp")
set(TAGLIB_SRC ${TAGLIB_HEADER_FILES} ${TAGLIB_SOURCE_FILES})

if(NOT MSVC)
	include(CheckCXXCompilerFlag)
	check_cxx_compiler_flag(-mavx2  COMPILER_SUPPORTS_AVX2)
	check_cxx_compiler_flag(-mxsave COMPILER_SUPPORTS_XSAVE)
	set(IS_X86_BASED CMAKE_SYSTEM_PROCESSOR MATCHES "(x86)|(X86)|(amd64)|(AMD64)")

	if (COMPILER_SUPPORTS_AVX2 AND COMPILER_SUPPORTS_XSAVE AND IS_X86_BASED)
		set_source_files_properties(
			toolkit/avx2search.cpp 
			PROPERTIES 
				COMPILE_FLAGS "-mavx2 -mxsave"
		)
	endif()
endif()

add_library(taglib ${TAGLIB_SRC})

if(MSVC)
	target_compile_options(
		taglib
		PRIVATE
			"/wd4100" # unreferenced formal parameter
			"/wd4267" # conversion from 'size_t' to 't', possible loss of data
			"/wd4389" # '!=': signed/unsigned mismatch
			"/wd4456" # declaration of 'xxx' hides previous local declaration
			"/wd4458" # declaration of 'xxx' hides class member
	)
else()
	check_cxx_compiler_flag("-Wno-deprecated-copy" IGNORE_DEPRECIATED_COPY)
	check_cxx_compiler_flag("-Wno-implicit-fallthrough" IGNORE_FALLTHROUGH)
	check_cxx_compiler_flag("-Wno-sign-compare" IGNORE_SIGN_COMPARE)
	check_cxx_compiler_flag("-Wno-unused-parameter" IGNORE_UNUSED)


	target_compile_options(
		taglib
		PUBLIC
			$<$<BOOL:${IGNORE_DEPRECIATED_COPY}>:-Wno-deprecated-copy>
		PRIVATE
			$<$<BOOL:${IGNORE_FALLTHROUGH}>:-Wno-implicit-fallthrough>
			$<$<BOOL:${IGNORE_SIGN_COMPARE}>:-Wno-sign-compare>
			$<$<BOOL:${IGNORE_UNUSED}>:-Wno-unused-parameter>
	)
endif()

#target_link_libraries(taglib PUBLIC Boost::atomic airUtils)

target_compile_definitions(taglib PRIVATE WITH_ASF WITH_MP4 TAGLIB_NO_CONFIG HAVE_BOOST_ATOMIC)
target_compile_definitions(taglib PUBLIC TAGLIB_STATIC)
#target_compile_definitions(taglib PUBLIC TAGLIB_USE_EXTERNAL_FILE_IO)

target_include_directories(taglib INTERFACE ${CMAKE_CURRENT_LIST_DIR}/../)

target_include_directories(taglib PRIVATE ${CMAKE_CURRENT_LIST_DIR})
target_include_directories(taglib PRIVATE 
	toolkit
	asf
	mpeg
	ogg
	ogg/flac
	flac
	mpc
	mp4
	mod
	ogg/vorbis
	ogg/opus
	ogg/speex
	mpeg/id3v2
	mpeg/id3v2/frames
	mpeg/id3v1
	ape
	s3m
	it
	xm
	wavpack
	trueaudio
	riff
	riff/aiff
	riff/wav
	.
	)


if(ZLIB_FOUND)
	target_link_libraries(taglib PUBLIC ${ZLIB_LIBRARIES})
else()
	target_link_libraries(taglib PUBLIC Qt5::Core)
endif()

