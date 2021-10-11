macro(build_documentation PROJECT_NAME)
    # Copy some files over, after filtering out COR-related files in the case of
    # libOpenCOR

    set(RELATIVE_DESTINATION_DIR html)
    set(ABSOLUTE_DESTINATION_DIR ${CMAKE_SOURCE_DIR}/${RELATIVE_DESTINATION_DIR})
    set(FILES)

    file(GLOB_RECURSE FILES RELATIVE ${ABSOLUTE_DESTINATION_DIR}
        ${ABSOLUTE_DESTINATION_DIR}/*.css
        ${ABSOLUTE_DESTINATION_DIR}/*.html
        ${ABSOLUTE_DESTINATION_DIR}/*.ico
        ${ABSOLUTE_DESTINATION_DIR}/*.jpg
        ${ABSOLUTE_DESTINATION_DIR}/*.js
        ${ABSOLUTE_DESTINATION_DIR}/*.php
        ${ABSOLUTE_DESTINATION_DIR}/*.png
    )

    if("${PROJECT_NAME}" STREQUAL "libOpenCOR")
        list(FILTER FILES EXCLUDE REGEX "^cor/")
    endif()

    foreach(FILE ${FILES})
        get_filename_component(DESTINATION_DIR ${CMAKE_BINARY_DIR}/${RELATIVE_DESTINATION_DIR}/${ARGN}/${FILE} DIRECTORY)

        file(COPY ${ABSOLUTE_DESTINATION_DIR}/${FILE} DESTINATION ${DESTINATION_DIR})
    endforeach()

    # Configure some files

    set(PROJECT_NAME ${PROJECT_NAME})

    string(TOLOWER ${PROJECT_NAME} PROJECT_REPOSITORY_NAME)

    if("${PROJECT_NAME}" STREQUAL "libOpenCOR")
        set(PROJECT_ADDITIONAL_TEAM_MEMBERS)
        set(PROJECT_URL "https://opencor.ws/libopencor/index.html")
        set(PROJECT_DESCRIPTION "the backend library to <a href=\"https://opencor.ws/\">OpenCOR</a>, an <a href=\"licensing.html\">open source</a> <a href=\"supportedPlatforms.html\">cross-platform</a> modelling environment")
        set(PROJECT_LICENSE "<a href=\"https://opensource.org/licenses/Apache-2.0\">Apache v2.0 license</a>")
        set(PROJECT_TUTORIAL_LISTING_ENTRY)
        set(PROJECT_API_DOCUMENTATION_LISTING_ENTRY "                <li><a href=\"api/index.html\">API documentation</a></li>
")
        set(PROJECT_TUTORIAL_MENU_ENTRY)

        set(ADDITIONAL_COPIED_FILES)
    else()
        set(PROJECT_ADDITIONAL_TEAM_MEMBERS "
                <tr>
                    <td>
                        <img src=\"res/pics/davidBrooks.jpg\" width=60 height=70 alt=\"David Brooks\">
                    </td>
                    <td>
                        <div>
                            Senior developer
                        </div>

                        <a href=\"mailto: David Brooks <d.brooks@auckland.ac.nz>?subject=About ${PROJECT_NAME}\">David Brooks</a>
                    </td>
                </tr>")
        set(PROJECT_URL "https://opencor.ws/")
        set(PROJECT_DESCRIPTION "an <a href=\"licensing.html\">open source</a> <a href=\"supportedPlatforms.html\">cross-platform</a> modelling environment (and a replacement for <a href=\"cor/index.html\">COR</a>)")
        set(PROJECT_LICENSE "<a href=\"https://opensource.org/licenses/GPL-3.0\">GPL v3.0 license</a>")
        set(PROJECT_TUTORIAL_LISTING_ENTRY "
            <ul>
                <li><a href=\"https://tutorial-on-cellml-opencor-and-pmr.readthedocs.io/en/latest/index.html\">OpenCOR tutorial</a></li>
            </ul>
")
        set(PROJECT_API_DOCUMENTATION_LISTING_ENTRY)
        set(PROJECT_TUTORIAL_MENU_ENTRY "
                                { \"separator\": true },
                                { \"level\": 0, \"label\": \"OpenCOR tutorial\", \"link\": \"https://tutorial-on-cellml-opencor-and-pmr.readthedocs.io/en/latest/index.html\", \"directLink\": true },")

        set(ADDITIONAL_COPIED_FILES
            res/pics/davidBrooks.jpg
        )
    endif()

    if(ENABLE_DOWNLOADS)
        set(ADDITIONAL_CONFIGURED_FILES
            downloads/index.html
            downloads/previousSnapshots.html
        )

        list(APPEND ADDITIONAL_COPIED_FILES
            downloads/index.js
            downloads/previousSnapshots.js
        )
    else()
        if("${PROJECT_NAME}" STREQUAL "libOpenCOR")
            set(DOWNLOADS_DIR libopencor/downloads)
        else()
            set(DOWNLOADS_DIR downloads)
        endif()

        set(DOWNLOADS_TITLE "Downloads")
        set(DOWNLOADS_PAGE index.html)
        set(DOWNLOADS_WHAT "Official versions of ${PROJECT_NAME} and the latest snapshot, if any,")

        configure_file(${ABSOLUTE_DESTINATION_DIR}/downloads/disabled.html.in ${CMAKE_BINARY_DIR}/${RELATIVE_DESTINATION_DIR}/${ARGN}/downloads/index.html)

        set(DOWNLOADS_TITLE "Previous snapshots")
        set(DOWNLOADS_PAGE previousSnapshots.html)
        set(DOWNLOADS_WHAT "Previous snapshots of ${PROJECT_NAME}")

        configure_file(${ABSOLUTE_DESTINATION_DIR}/downloads/disabled.html.in ${CMAKE_BINARY_DIR}/${RELATIVE_DESTINATION_DIR}/${ARGN}/downloads/previousSnapshots.html)
    endif()

    foreach(CONFIGURED_FILE res/menu.js
                            contactUs.html
                            index.html
                            licensing.html
                            supportedPlatforms.html
                            team.html
                            ${ADDITIONAL_CONFIGURED_FILES})
        configure_file(${ABSOLUTE_DESTINATION_DIR}/${CONFIGURED_FILE}.in ${CMAKE_BINARY_DIR}/${RELATIVE_DESTINATION_DIR}/${ARGN}/${CONFIGURED_FILE})
    endforeach()

    foreach(COPIED_FILE res/pics/logo.png
                        supportedPlatforms.js
                        whatIsNew.js
                        ${ADDITIONAL_COPIED_FILES})
        configure_file(${ABSOLUTE_DESTINATION_DIR}/${COPIED_FILE}.${PROJECT_REPOSITORY_NAME} ${CMAKE_BINARY_DIR}/${RELATIVE_DESTINATION_DIR}/${ARGN}/${COPIED_FILE} COPYONLY)
    endforeach()
endmacro()
