include_directories(${CMAKE_CURRENT_LIST_DIR})
include_directories(${CMAKE_CURRENT_LIST_DIR}/../Formats)
include_directories(${CMAKE_CURRENT_LIST_DIR}/../Formats/exec)
include_directories(${CMAKE_CURRENT_LIST_DIR}/../Formats/formats)
include_directories(${CMAKE_CURRENT_LIST_DIR}/../Formats/images)
include_directories(${CMAKE_CURRENT_LIST_DIR}/../XOptions)

include(${CMAKE_CURRENT_LIST_DIR}/../XGithub/xgithub.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/../XOptions/xoptions.cmake)

# XUpdate downloads ZIP packages and therefore needs the complete ZIP core.
# Keep that dependency composed through the shared manifest: Formats/
# xformats.cmake publishes that core as XZIP_SOURCES -- XArchive/XZip, their
# family classifiers, shared Formats/XDEX helpers and every decoder reachable
# from XDecompress. A hand-picked copy of that source list drifted out of sync
# and made this standalone consumer fail to compile. Only XZIP_SOURCES is used
# below, so this stays the core, not all of Formats.
if (NOT DEFINED XZIP_SOURCES)
    set(XFORMATS_CORE_ONLY TRUE)
    include(${CMAKE_CURRENT_LIST_DIR}/../Formats/xformats.cmake)
    unset(XFORMATS_CORE_ONLY)
endif()

set(XUPDATE_SOURCES
    ${CMAKE_CURRENT_LIST_DIR}/xupdate.cpp
    ${CMAKE_CURRENT_LIST_DIR}/xupdate.h
    ${XZIP_SOURCES}
    ${XGITHUB_SOURCES}
    ${XOPTIONS_SOURCES}
)
