cmake_minimum_required(VERSION 3.2)
project(TrackPlayer)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 CONFIG REQUIRED COMPONENTS Widgets Quick Sql)

add_subdirectory(Tests)
add_subdirectory(External/MiniAudio)
add_subdirectory(External/Taglib)

set(SOURCES
	Source/Audio.cpp
	Source/Controller.cpp
	Source/Database.cpp
	Source/Main.cpp
	Source/Playlist.cpp
	Source/Tracklist.cpp
)
set(HEADERS
	Include/Audio.h
	Include/Controller.h
	Include/Database.h
	Include/FxSuite.h
	Include/ImageProvider.h
	Include/Playlist.h
	Include/Tracklist.h
)
qt_add_resources(RESOURCES
	Resources/Resources.qrc
)

if(APPLE)
	set(APP_ICON ${CMAKE_SOURCE_DIR}/Resources/Images/TrackPlayer.icns)
	list(APPEND RESOURCES ${APP_ICON})

	set(MACOSX_BUNDLE_BUNDLE_NAME "Track Player")
	set(MACOSX_BUNDLE_ICON_FILE TrackPlayer.icns)
	set_source_files_properties(${APP_ICON}
		PROPERTIES MACOSX_PACKAGE_LOCATION "Resources"
	)
endif()

qt_add_executable(${PROJECT_NAME} MACOSX_BUNDLE
	${SOURCES}
	${HEADERS}
	${RESOURCES}
)

target_link_libraries(${PROJECT_NAME} PRIVATE
	Qt6::Widgets
	Qt6::Quick
	Qt6::Sql
	MiniAudio
	Taglib
)
