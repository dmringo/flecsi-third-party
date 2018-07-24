set(SZIP_NAME szip)
string(TOLOWER ${SZIP_NAME} SZIP_PACKAGE_NAME)
set(SZIP_URL ${PROJECT_SOURCE_DIR}/files)
set(SZIP_TGZ SZip.tar.gz)
set(SZIP_MD5 "a966afca7fb9f9cc65568f35a7037f57")

message(STATUS "Building ${SZIP_NAME}")
ExternalProject_Add(${SZIP_NAME}
  URL ${SZIP_URL}/${SZIP_TGZ}
  URL_MD5 ${SZIP_MD5}
  PREFIX ${SZIP_NAME}
  INSTALL_DIR ${SZIP_NAME}/install
  UPDATE_COMMAND ""
  CMAKE_ARGS
    -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
    -DCMAKE_C_COMPILER:FILEPATH=${CMAKE_C_COMPILER}
    -DCMAKE_C_FLAGS:STRING=${CMAKE_C_FLAGS}
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}
  LOG_BUILD 1
)
ExternalProject_get_property(${SZIP_NAME} INSTALL_DIR)

set(SZIP_INCLUDE_DIR ${INSTALL_DIR}/include)
if (CMAKE_BUILD_TYPE MATCHES Debug)
	set(SZIP_LIBRARIES ${INSTALL_DIR}/lib/${CMAKE_LIBRARY_PREFIX}szip_debug${CMAKE_LIBRARY_SUFFIX})
else()
  set(SZIP_LIBRARIES ${INSTALL_DIR}/lib/${CMAKE_LIBRARY_PREFIX}szip${CMAKE_LIBRARY_SUFFIX})
endif()

install(DIRECTORY ${INSTALL_DIR}/ DESTINATION ${CMAKE_INSTALL_PREFIX} USE_SOURCE_PERMISSIONS)
