# Install script for directory: /Users/aevans/trackInfo/external/taglib-2.0.1/taglib

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Debug")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/Library/Developer/CommandLineTools/usr/bin/objdump")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/Users/aevans/trackInfo/cmake-build-debug/external/taglib-2.0.1/taglib/libtag.a")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libtag.a" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libtag.a")
    execute_process(COMMAND "/Library/Developer/CommandLineTools/usr/bin/ranlib" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libtag.a")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/taglib" TYPE FILE FILES
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/tag.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/fileref.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/audioproperties.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/taglib_export.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/toolkit/taglib.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/toolkit/tstring.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/toolkit/tlist.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/toolkit/tlist.tcc"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/toolkit/tstringlist.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/toolkit/tbytevector.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/toolkit/tbytevectorlist.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/toolkit/tvariant.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/toolkit/tbytevectorstream.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/toolkit/tiostream.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/toolkit/tfile.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/toolkit/tfilestream.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/toolkit/tmap.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/toolkit/tmap.tcc"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/toolkit/tpicturetype.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/toolkit/tpropertymap.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/toolkit/tdebuglistener.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/toolkit/tversionnumber.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/mpegfile.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/mpegproperties.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/mpegheader.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/xingheader.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/id3v1/id3v1tag.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/id3v1/id3v1genres.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/id3v2/id3v2.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/id3v2/id3v2extendedheader.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/id3v2/id3v2frame.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/id3v2/id3v2header.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/id3v2/id3v2synchdata.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/id3v2/id3v2footer.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/id3v2/id3v2framefactory.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/id3v2/id3v2tag.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/id3v2/frames/attachedpictureframe.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/id3v2/frames/commentsframe.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/id3v2/frames/eventtimingcodesframe.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/id3v2/frames/generalencapsulatedobjectframe.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/id3v2/frames/ownershipframe.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/id3v2/frames/popularimeterframe.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/id3v2/frames/privateframe.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/id3v2/frames/relativevolumeframe.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/id3v2/frames/synchronizedlyricsframe.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/id3v2/frames/textidentificationframe.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/id3v2/frames/uniquefileidentifierframe.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/id3v2/frames/unknownframe.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/id3v2/frames/unsynchronizedlyricsframe.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/id3v2/frames/urllinkframe.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/id3v2/frames/chapterframe.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/id3v2/frames/tableofcontentsframe.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpeg/id3v2/frames/podcastframe.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/ogg/oggfile.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/ogg/oggpage.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/ogg/oggpageheader.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/ogg/xiphcomment.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/ogg/vorbis/vorbisfile.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/ogg/vorbis/vorbisproperties.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/ogg/flac/oggflacfile.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/ogg/speex/speexfile.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/ogg/speex/speexproperties.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/ogg/opus/opusfile.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/ogg/opus/opusproperties.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/flac/flacfile.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/flac/flacpicture.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/flac/flacproperties.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/flac/flacmetadatablock.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/ape/apefile.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/ape/apeproperties.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/ape/apetag.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/ape/apefooter.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/ape/apeitem.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpc/mpcfile.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mpc/mpcproperties.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/wavpack/wavpackfile.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/wavpack/wavpackproperties.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/trueaudio/trueaudiofile.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/trueaudio/trueaudioproperties.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/riff/rifffile.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/riff/aiff/aifffile.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/riff/aiff/aiffproperties.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/riff/wav/wavfile.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/riff/wav/wavproperties.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/riff/wav/infotag.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/asf/asffile.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/asf/asfproperties.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/asf/asftag.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/asf/asfattribute.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/asf/asfpicture.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mp4/mp4file.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mp4/mp4atom.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mp4/mp4tag.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mp4/mp4item.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mp4/mp4properties.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mp4/mp4coverart.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mp4/mp4itemfactory.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mod/modfilebase.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mod/modfile.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mod/modtag.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/mod/modproperties.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/it/itfile.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/it/itproperties.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/s3m/s3mfile.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/s3m/s3mproperties.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/xm/xmfile.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/xm/xmproperties.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/dsf/dsffile.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/dsf/dsfproperties.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/dsdiff/dsdifffile.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/dsdiff/dsdiffproperties.h"
    "/Users/aevans/trackInfo/external/taglib-2.0.1/taglib/dsdiff/dsdiffdiintag.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/taglib/taglib-targets.cmake")
    file(DIFFERENT _cmake_export_file_changed FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/taglib/taglib-targets.cmake"
         "/Users/aevans/trackInfo/cmake-build-debug/external/taglib-2.0.1/taglib/CMakeFiles/Export/398eef5e047a0959864f2888198961bf/taglib-targets.cmake")
    if(_cmake_export_file_changed)
      file(GLOB _cmake_old_config_files "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/taglib/taglib-targets-*.cmake")
      if(_cmake_old_config_files)
        string(REPLACE ";" ", " _cmake_old_config_files_text "${_cmake_old_config_files}")
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/taglib/taglib-targets.cmake\" will be replaced.  Removing files [${_cmake_old_config_files_text}].")
        unset(_cmake_old_config_files_text)
        file(REMOVE ${_cmake_old_config_files})
      endif()
      unset(_cmake_old_config_files)
    endif()
    unset(_cmake_export_file_changed)
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/taglib" TYPE FILE FILES "/Users/aevans/trackInfo/cmake-build-debug/external/taglib-2.0.1/taglib/CMakeFiles/Export/398eef5e047a0959864f2888198961bf/taglib-targets.cmake")
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/taglib" TYPE FILE FILES "/Users/aevans/trackInfo/cmake-build-debug/external/taglib-2.0.1/taglib/CMakeFiles/Export/398eef5e047a0959864f2888198961bf/taglib-targets-debug.cmake")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/taglib" TYPE FILE FILES
    "/Users/aevans/trackInfo/cmake-build-debug/external/taglib-2.0.1/taglib-config.cmake"
    "/Users/aevans/trackInfo/cmake-build-debug/external/taglib-2.0.1/taglib-config-version.cmake"
    )
endif()

