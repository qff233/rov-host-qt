cmake_minimum_required(VERSION 3.16)

project(rov-host-qt VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 17)

include_directories(src)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(approv-host-qt
    main.cpp
)

qt_add_qml_module(approv-host-qt
    URI rov-host-qt
    VERSION 1.0
    QML_FILES Main.qml
    QML_FILES qml/slave_window/FlowBar.qml qml/slave_window/SlaveWindow.qml qml/slave_window/Setting.qml qml/About.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(approv-host-qt PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.approv-host-qt
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(approv-host-qt
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS approv-host-qt
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
