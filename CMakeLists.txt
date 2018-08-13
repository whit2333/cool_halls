cmake_minimum_required(VERSION 3.1)
#project(AC_SOFTWARE VERSION 1.6.0 LANGUAGES C CXX)

set(CMAKE_MODULE_PATH
   ${CMAKE_MODULE_PATH}
   ${PROJECT_SOURCE_DIR}/cmake
   ${PROJECT_SOURCE_DIR}/cmake/modules)

## OS Specific settings
include(cmake/os.cmake)

option(USE_CONTAINERS "Install a singularity container image instead of building source." OFF)

find_package(Singularity)

list(APPEND CMAKE_PREFIX_PATH ${CMAKE_INSTALL_PREFIX})

if( SINGULARITY_FOUND AND USE_CONTAINERS )

  set(COOL_HALLS_SINGULARITY_CACHE ${CMAKE_INSTALL_PREFIX}/singularity_cache)

  message(STATUS "${BoldYellow}Downloading singularity image instead of building from source.${ColourReset}")

  configure_file(src/hcana.in        hcana          @ONLY)
  configure_file(src/root.in         root           @ONLY)
  configure_file(src/analyzer.in     analyzer       @ONLY)
  configure_file(src/rootls.in       rootls         @ONLY)
  configure_file(src/root-config.in  root-config    @ONLY)


  add_custom_target(singularity_tgt ALL
    #OUTPUT cool_halls.img
    COMMAND export SINGULARITY_CACHEDIR=${COOL_HALLS_SINGULARITY_CACHE}
    COMMAND export SINGULARITY_PULLFOLDER=${CMAKE_CURRENT_BINARY_DIR}
    COMMAND SINGULARITY_CACHEDIR=. singularity pull --name cool_halls.simg shub://whit2333/cool_halls:latest 
    COMMENT "pulling singularity image"
    USES_TERMINAL
    )

  install(FILES 
    ${CMAKE_CURRENT_BINARY_DIR}/cool_halls.simg
    ${CMAKE_CURRENT_BINARY_DIR}/hcana 
    ${CMAKE_CURRENT_BINARY_DIR}/analyzer 
    ${CMAKE_CURRENT_BINARY_DIR}/root 
    ${CMAKE_CURRENT_BINARY_DIR}/rootls 
    ${CMAKE_CURRENT_BINARY_DIR}/root-config 
    DESTINATION bin
    PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE
  )
else() 

  message(STATUS "Building libraries from source.")

include(ExternalProject)
ExternalProject_Add(evio_project 
  GIT_REPOSITORY    https://github.com/whit2333/hallac_evio.git
  GIT_TAG           origin/testing
  SOURCE_DIR "${CMAKE_BINARY_DIR}/hallac_evio-src"
  BINARY_DIR "${CMAKE_BINARY_DIR}/hallac_evio-build"
  CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}" "-DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}"
  BUILD_COMMAND ${CMAKE_COMMAND} --build .  -- -j4
  TEST_COMMAND ""
  LOG_DOWNLOAD ON
  STEP_TARGETS download configure build install
  )
ExternalProject_Add(podd_project 
  DEPENDS evio_project-install
  GIT_REPOSITORY    https://github.com/whit2333/analyzer.git
  GIT_TAG           origin/cmake_demangled
  SOURCE_DIR "${CMAKE_BINARY_DIR}/podd-src"
  BINARY_DIR "${CMAKE_BINARY_DIR}/podd-build"
  CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}" "-DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}"
  BUILD_COMMAND ${CMAKE_COMMAND} --build .  -- -j4
  TEST_COMMAND ""
  LOG_DOWNLOAD ON
  STEP_TARGETS download configure build install
  )

ExternalProject_Add(hcana_project 
  DEPENDS podd_project-install
  GIT_REPOSITORY    https://github.com/whit2333/hcana.git
  GIT_TAG           origin/cmake_demangled
  SOURCE_DIR "${CMAKE_BINARY_DIR}/hcana-src"
  BINARY_DIR "${CMAKE_BINARY_DIR}/hcana-build"
  CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}" "-DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}"
  BUILD_COMMAND ${CMAKE_COMMAND} --build .  -- -j4
  TEST_COMMAND ""
  LOG_DOWNLOAD ON
  STEP_TARGETS download configure build install
  )
endif()


