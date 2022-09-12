qt_add_resources(NewtonResources "resources/Newton.qrc")

qt_add_executable(Newton      
    "forms/mainwindow.ui"
    ${NewtonResources}
    mainwindow.cpp
    main.cpp
)

target_link_libraries(Newton PRIVATE 
    Qt6::OpenGL
    Qt6::OpenGLWidgets
    Qt6::Widgets
)

set_target_properties(Newton PROPERTIES
    WIN32_EXECUTABLE ON
    MACOSX_BUNDLE ON
)