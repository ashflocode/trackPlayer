cmake_minimum_required(VERSION 3.2)
project(Test)

add_definitions(-DQUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_SOURCE_DIR}")

find_package(Qt6 CONFIG REQUIRED COMPONENTS
        Widgets
        Quick
        Sql
        QuickTest
)

set(SOURCES
        TestApp.cpp
        ../Source/Audio.cpp
        ../Source/Database.cpp
        ../Source/Controller.cpp
)
set(HEADERS
        ../Include/Audio.h
        ../Include/Database.h
        ../Include/Controller.h
)
qt_add_resources(RESOURCES
        ../Resources/Resources.qrc
)

add_executable(${PROJECT_NAME}
        ${SOURCES}
        ${HEADERS}
        ${RESOURCES}
)

target_link_libraries(${PROJECT_NAME} PRIVATE
        Qt6::Widgets
        Qt6::Quick
        Qt6::Sql
        Qt6::QuickTest
        MiniAudio
        Taglib
)

configure_file(
        TestFile.mp3
        ${CMAKE_BINARY_DIR}/Tests/TestFile.mp3
        COPYONLY
)