cmake_minimum_required(VERSION 3.10)
project(libsonycam)

# Using Camera Remote SDK 1.07.00 - 2022-10-27
# TODO: Camera Remote API beta
set (SCRSDK_VERSION "1.07.00")
set (SCRSDK_SOVERSION "1")

list (APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake_modules/")
list (APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../cmake_modules/")
include (GNUInstallDirs)
include (InstallImported)

add_library (Cr_Core SHARED IMPORTED)

set_target_properties (Cr_Core PROPERTIES VERSION ${SCRSDK_VERSION} SOVERSION ${SCRSDK_SOVERSION})

set_property (TARGET Cr_Core PROPERTY IMPORTED_LOCATION "x86_64/libCr_Core.so")

set(crsdk_hdr_dir ${CMAKE_CURRENT_SOURCE_DIR}/include)

set(crsdk_hdrs
    ${crsdk_hdr_dir}/CameraRemote_SDK.h
    ${crsdk_hdr_dir}/CrCommandData.h
    ${crsdk_hdr_dir}/CrDefines.h
    ${crsdk_hdr_dir}/CrDeviceProperty.h
    ${crsdk_hdr_dir}/CrError.h
    ${crsdk_hdr_dir}/CrImageDataBlock.h
    ${crsdk_hdr_dir}/CrTypes.h
    ${crsdk_hdr_dir}/ICrCameraObjectInfo.h
    ${crsdk_hdr_dir}/IDeviceCallback.h
)

install (
    FILES ${crsdk_hdrs} 
    DESTINATION include/libsonycam
)

install_imported (
    TARGETS Cr_Core
    DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

# install_imported (
#   TARGETS libCr_PTP_IP libCr_PTP_USB libssh2 libusb-1.0
#   DESTINATION ${CMAKE_INSTALL_LIBDIR}/CrAdapter
# )
