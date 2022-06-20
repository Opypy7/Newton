cmake_minimum_required(VERSION 3.16)

if (WIN32)
    project(Newton LANGUAGES CXX VERSION 1.0)
elseif(UNIX)
    project(Newton VERSION 1.0)
endif()

set(CMAKE_CONFIGURATION_TYPES "Release;RelWithDebInfo;Debug" CACHE STRING "" FORCE)

#======================= INCLUSION OF Qt =======================#
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_PREFIX_PATH $ENV{QTDIR})

find_package(Qt6 COMPONENTS Core)
find_package(Qt6 COMPONENTS Gui)
find_package(Qt6 COMPONENTS Widgets)
find_package(Qt6 COMPONENTS OpenGL)
find_package(Qt6 COMPONENTS OpenGLWidgets)

#=================== INCLUSION OF Project Files ====================#
set(FORMS_DIR "${CMAKE_SOURCE_DIR}/forms")
set(INCLUDE_DIR "${CMAKE_SOURCE_DIR}/include")
set(SOURCE_DIR "${CMAKE_SOURCE_DIR}/src")

include_directories(${FORMS_DIR})
include_directories(${INCLUDE_DIR})
include_directories(${SOURCE_DIR})

file(GLOB_RECURSE SOURCES
    "${FORMS_DIR}/*.ui"
    "${FORMS_DIR}/*.qrc"
    "${INCLUDE_DIR}/*.h"
    "${SOURCE_DIR}/*.cpp"
)

#=================== SETUP EXECTUABLE ====================#
# Enable debug logging on RELWITHDEBINFO configuration
set_property(DIRECTORY APPEND PROPERTY COMPILE_DEFINITIONS
    $<$<CONFIG:RELWITHDEBINFO>:QT_MESSAGELOGCONTEXT>
)

# Add the forms directory to the AUTOUIC search paths
set(CMAKE_AUTOUIC_SEARCH_PATHS ${CMAKE_AUTOUIC_SEARCH_PATHS} ${FORMS_DIR})

# Add the executable
if (WIN32) 
    add_executable(Newton WIN32 ${SOURCES})
elseif(UNIX)
    add_executable(Newton ${SOURCES})
endif()

# Add the target includes for Newton
target_include_directories(Newton PRIVATE ${FORMS_DIR})
target_include_directories(Newton PRIVATE ${INCLUDE_DIR})
target_include_directories(Newton PRIVATE ${SOURCE_DIR})

#===================== LINKING LIBRARIES =======================#


target_link_libraries(Newton PUBLIC
    Qt6::Core
    Qt6::Gui
    Qt6::OpenGL
    Qt6::OpenGLWidgets
    Qt6::Widgets
)
set_target_properties(Newton PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)

install(TARGETS Newton DESTINATION bin)
install(FILES "${INCLUDE_DIR}/mainwindow.h" DESTINATION include)

include(InstallRequiredSystemLibraries)
set(CPACK_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
set(CPACK_DESKTOP_SHORTCUTS)
set(CPACK_RESOURCE_FILE_LICENCE "{CMAKE_CURRENT_SOURCE_DIR}/License.txt")
set(CPACK_PACKAGE_VERSION_MAJOR)
set(CPACK_PACKAGE_VERSION_MINOR)
include(CPack)

