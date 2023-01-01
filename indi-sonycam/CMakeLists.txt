cmake_minimum_required(VERSION 3.0)
PROJECT(indi_sonycam CXX C)

LIST(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../cmake_modules/")
LIST(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake_modules/")
include(GNUInstallDirs)

find_package(SONYCAM REQUIRED)
find_package(CFITSIO REQUIRED)
find_package(INDI REQUIRED)
find_package(ZLIB REQUIRED)
# find_package(USB1 REQUIRED)
find_package(Threads REQUIRED)

set(SONYCAM_VERSION_MAJOR 1)
set(SONYCAM_VERSION_MINOR 0)

include_directories( ${CMAKE_CURRENT_BINARY_DIR})
include_directories( ${CMAKE_CURRENT_SOURCE_DIR})
include_directories( ${SONYCAM_INCLUDE_DIR})
include_directories( ${CFITSIO_INCLUDE_DIR})
include_directories( ${INDI_INCLUDE_DIR})

include(CMakeCommon)

########### Remote CLI ###########

set(cli_srcs
    CameraDevice.cpp
    ConnectionInfo.cpp
    PropertyValueTable.cpp
    RemoteCli.cpp
    Text.cpp
    MessageDefine.cpp
)

set (remotecli_SRCS
    ${cli_srcs}
)

add_executable(remotecli ${remotecli_SRCS})
set_target_properties(remotecli PROPERTIES
    CXX_STANDARD 17
    CXX_STANDARD_REQUIRED YES
    CXX_EXTENSIONS NO
    BUILD_RPATH "$ORIGIN"
    INSTALL_RPATH "$ORIGIN"
)

target_link_libraries(remotecli
    PRIVATE ${SONYCAM_LIBRARIES}
)

######## INDI Driver ########

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/config.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/config.h )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/indi_sonycam.xml.cmake ${CMAKE_CURRENT_BINARY_DIR}/indi_sonycam.xml )

set(sonycam_SRCS
    ${CMAKE_CURRENT_SOURCE_DIR}/sonycam.cpp
    # ${cli_srcs}
)

add_executable(indi_sonycam ${sonycam_SRCS})
set_target_properties(indi_sonycam PROPERTIES
    CXX_STANDARD 17
    CXX_STANDARD_REQUIRED YES
    CXX_EXTENSIONS NO
    BUILD_RPATH "$ORIGIN"
    INSTALL_RPATH "$ORIGIN"
)


target_link_libraries(indi_sonycam
    PRIVATE ${SONYCAM_LIBRARIES}
    PRIVATE ${INDI_LIBRARIES} ${CFITSIO_LIBRARIES} ${ZLIB_LIBRARY}
)

install(TARGETS indi_sonycam RUNTIME DESTINATION bin)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/indi_sonycam.xml DESTINATION ${INDI_DATA_DIR})
