set(CPACK_PACKAGE_VERSION ${PROJECT_VERSION})
set(CPACK_PACKAGE_NAME daggy)
set(CPACK_PACKAGE_VENDOR synacker)
set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}")

if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
  set(CPACK_GENERATOR DEB RPM ZIP)
else()     
  set(CPACK_GENERATOR ZIP NSIS)
endif()

# TGZ specific
set(CPACK_ARCHIVE_COMPONENT_INSTALL ON)
# DEB specific
set(CPACK_DEB_COMPONENT_INSTALL ON)
set(CPACK_DEBIAN_PACKAGE_MAINTAINER ${CPACK_PACKAGE_VENDOR})
# RPM specific
set(CPACK_RPM_COMPONENT_INSTALL ON)
set(CPACK_RPM_PACKAGE_AUTOREQ NO)
set(CPACK_SYSTEM_NAME ${CMAKE_SYSTEM_NAME})
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/../COPYING")
set(CPACK_RESOURCE_FILE_README "${CMAKE_CURRENT_SOURCE_DIR}/../README.md")

set(CPACK_NSIS_MUI_ICON "${CMAKE_CURRENT_SOURCE_DIR}/icons/daggy.ico")
set(CPACK_NSIS_MODIFY_PATH ON)
set(CPACK_NSIS_URL_INFO_ABOUT "https://daggy.dev")

set(CPACK_COMPONENTS_ALL application devel)

if(WIN32)
    set(CMAKE_INSTALL_UCRT_LIBRARIES ON)
    set(CMAKE_INSTALL_SYSTEM_RUNTIME_DESTINATION bin)
    set(CMAKE_INSTALL_SYSTEM_RUNTIME_COMPONENT "redist")
    include(InstallRequiredSystemLibraries)
    set(CPACK_COMPONENTS_ALL ${CPACK_COMPONENTS_ALL} redist)
    set(CPACK_PACKAGE_INSTALL_DIRECTORY daggy)
endif()

if(PACKACGE_DEPS)
    include(package_deps)
    set(CPACK_COMPONENTS_ALL ${CPACK_COMPONENTS_ALL} deps)
endif()
include(CPack)

cpack_add_component(application
                    DISPLAY_NAME "Daggy"
                    #DESCRIPTION "Daggy console application"
                    )
cpack_add_component(devel
                    DISPLAY_NAME "Daggy-devel"
                    #DESCRIPTION "Daggy devel lib"
                    DISABLED)

if(WIN32)
    cpack_add_component(redist
                        DISPLAY_NAME "MSVS-redist"
                        #DESCRIPTION "Daggy devel lib"
                        HIDDEN
                        REQUIRED)
endif()

if(PACKACGE_DEPS)
    cpack_add_component(deps
                        DISPLAY_NAME "Daggy-deps"
                        #DESCRIPTION "Daggy deps"
                        HIDDEN
                        REQUIRED)
endif()
