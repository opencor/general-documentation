cmake_minimum_required(VERSION 3.11)

# Project definition

project(GeneralDocumentation
    LANGUAGES NONE
)

# Build the general documentation(s)

include(cmake/common.cmake)

if("${MODE}" STREQUAL "libOpenCOR" OR "${MODE}" STREQUAL "")
    if("${MODE}" STREQUAL "")
        set(DOCUMENTATION_DESTINATION libOpenCOR)
    endif()

    build_documentation(libOpenCOR ${DOCUMENTATION_DESTINATION})
endif()

if("${MODE}" STREQUAL "OpenCOR" OR "${MODE}" STREQUAL "")
    if("${MODE}" STREQUAL "")
        set(DOCUMENTATION_DESTINATION OpenCOR)
    endif()

    build_documentation(OpenCOR ${DOCUMENTATION_DESTINATION})
endif()
