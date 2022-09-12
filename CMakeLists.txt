cmake_minimum_required(VERSION 3.16)

project(Newton VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Widgets)
find_package(Qt6 REQUIRED COMPONENTS OpenGL)
find_package(Qt6 REQUIRED COMPONENTS OpenGLWidgets)

qt6_standard_project_setup()

add_subdirectory(src)

install(TARGETS Newton DESTINATION bin)
install(FILES "src/mainwindow.h" DESTINATION include)

include(InstallRequiredSystemLibraries)
set(CPACK_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
set(CPACK_DESKTOP_SHORTCUTS)
set(CPACK_RESOURCE_FILE_LICENCE "{CMAKE_CURRENT_SOURCE_DIR}/License.txt")
set(CPACK_PACKAGE_VERSION_MAJOR)
set(CPACK_PACKAGE_VERSION_MINOR)
include(CPack)