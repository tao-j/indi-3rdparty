# - Try to find SONYCAM Library
# Once done this will define
#
#  SONYCAM_FOUND - system has SONYCAM
#  SONYCAM_INCLUDE_DIR - the SONYCAM include directory
#  SONYCAM_LIBRARIES - Link these to use SONYCAM

# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.

if (SONYCAM_INCLUDE_DIR AND SONYCAM_LIBRARIES)

  # in cache already
  set(SONYCAM_FOUND TRUE)
  message(STATUS "Found libsonycam: ${SONYCAM_LIBRARIES}")

else (SONYCAM_INCLUDE_DIR AND SONYCAM_LIBRARIES)

  find_path(SONYCAM_INCLUDE_DIR CameraRemote_SDK.h CrCommandData.h CrDefines.h CrDeviceProperty.h CrError.h CrImageDataBlock.h CrTypes.h ICrCameraObjectInfo.h IDeviceCallback.h
    PATH_SUFFIXES libsonycam
    ${_obIncDir}
    ${GNUWIN32_DIR}/include
  )

  find_library(SONYCAM_LIBRARIES NAMES Cr_Core
    PATHS
    ${_obLinkDir}
    ${GNUWIN32_DIR}/lib
  )

  if (SONYCAM_LIBRARIES)
    set(SONYCAM_LIBRARIES ${SONYCAM_LIBRARIES})
  endif (SONYCAM_LIBRARIES)


  if(SONYCAM_INCLUDE_DIR AND SONYCAM_LIBRARIES)
    set(SONYCAM_FOUND TRUE)
  else (SONYCAM_INCLUDE_DIR AND SONYCAM_LIBRARIES)
    set(SONYCAM_FOUND FALSE)
  endif(SONYCAM_INCLUDE_DIR AND SONYCAM_LIBRARIES)


  if (SONYCAM_FOUND)
    if (NOT SONYCAM_FIND_QUIETLY)
      message(STATUS "Found SONYCAM: ${SONYCAM_LIBRARIES}")
    endif (NOT SONYCAM_FIND_QUIETLY)
  else (SONYCAM_FOUND)
    if (SONYCAM_FIND_REQUIRED)
      message(FATAL_ERROR "SONYCAM not found. Please install libsonycam http://www.indilib.org")
    endif (SONYCAM_FIND_REQUIRED)
  endif (SONYCAM_FOUND)

  mark_as_advanced(SONYCAM_INCLUDE_DIR SONYCAM_LIBRARIES)

endif (SONYCAM_INCLUDE_DIR AND SONYCAM_LIBRARIES)
