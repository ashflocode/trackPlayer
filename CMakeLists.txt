cmake_minimum_required(VERSION 3.26)
project(trackInfo)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

#Qt
set(CMAKE_PREFIX_PATH "/Users/aevans/Qt/Qt-DJ-5.15.2-436dfc17c8")
find_package(Qt5 CONFIG REQUIRED COMPONENTS Widgets Quick)
set(CMAKE_AUTOMOC ON) #qt headers (Q_OBJECT etc)
set(CMAKE_AUTORCC ON) #qt qrc files
#set(CMAKE_AUTOUIC ON) #qt: ui files (qt designer)
set(CMAKE_INCLUDE_CURRENT_DIR ON) #look for headers in current dir

#taglib
add_subdirectory(external/taglib)

add_executable(${PROJECT_NAME}
        main.cpp
        MainWindow.cpp
        MainWindow.h
        resources/resources.qrc
)

target_link_libraries(trackInfo PUBLIC
        taglib
        Qt5::Widgets
        Qt5::Quick
)

target_include_directories(trackInfo PUBLIC
        "${PROJECT_SOURCE_DIR}"
        "${PROJECT_SOURCE_DIR}/external/taglib"
)
