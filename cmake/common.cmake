macro(build_documentation PROJECT_NAME)
    # Copy some files over

    set(RELATIVE_DESTINATION_DIR html)
    set(ABSOLUTE_DESTINATION_DIR ${CMAKE_SOURCE_DIR}/${RELATIVE_DESTINATION_DIR})
    set(FILES)

    file(GLOB_RECURSE FILES RELATIVE ${ABSOLUTE_DESTINATION_DIR}
        ${ABSOLUTE_DESTINATION_DIR}/*.css
        ${ABSOLUTE_DESTINATION_DIR}/*.html
        ${ABSOLUTE_DESTINATION_DIR}/*.jpg
        ${ABSOLUTE_DESTINATION_DIR}/*.js
        ${ABSOLUTE_DESTINATION_DIR}/*.php
        ${ABSOLUTE_DESTINATION_DIR}/*.png
    )

    foreach(FILE ${FILES})
        get_filename_component(DESTINATION_DIR ${CMAKE_BINARY_DIR}/${RELATIVE_DESTINATION_DIR}/${ARGN}/${FILE} DIRECTORY)

        file(COPY ${ABSOLUTE_DESTINATION_DIR}/${FILE} DESTINATION ${DESTINATION_DIR})
    endforeach()

    # Configure some files

    set(PROJECT_NAME ${PROJECT_NAME})

    if("${PROJECT_NAME}" STREQUAL "libOpenCOR")
        set(PROJECT_URL "https://opencor.ws/libopencor/index.html")
        set(PROJECT_DESCRIPTION "the backend library to <a href=\"https://opencor.ws/\">OpenCOR</a>, an <a href=\"licensing.html\">open source</a> <a href=\"supportedPlatforms.html\">cross-platform</a> modelling environment")
        set(PROJECT_TUTORIAL)
    else()
        set(PROJECT_URL "https://opencor.ws/")
        set(PROJECT_DESCRIPTION "an <a href=\"licensing.html\">open source</a> <a href=\"supportedPlatforms.html\">cross-platform</a> modelling environment (and a replacement for <a href=\"cor/index.html\">COR</a>)")
        set(PROJECT_TUTORIAL "
            <ul>
                <li><a href=\"https://tutorial-on-cellml-opencor-and-pmr.readthedocs.io/en/latest/index.html\">OpenCOR tutorial</a></li>
            </ul>
")
    endif()

    configure_file(${ABSOLUTE_DESTINATION_DIR}/index.html.in ${CMAKE_BINARY_DIR}/${RELATIVE_DESTINATION_DIR}/${ARGN}/index.html)
endmacro()
