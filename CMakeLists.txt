cmake_minimum_required(VERSION 3.11)

# Project definition

project(GeneralDocumentation
    LANGUAGES NONE
)

# Copy some files over

set(HTML_DIR ${CMAKE_SOURCE_DIR}/html)

file(GLOB_RECURSE FILES RELATIVE ${HTML_DIR} *.css *.html *.jpg *.js *.php *.png)

foreach(FILE ${FILES})
    get_filename_component(DESTINATION_DIR ${CMAKE_BINARY_DIR}/html/${FILE} DIRECTORY)

    file(COPY ${HTML_DIR}/${FILE} DESTINATION ${DESTINATION_DIR})
endforeach()
