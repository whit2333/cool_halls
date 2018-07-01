# Finds libSINGULARITY.
#
# This module defines:
# SINGULARITY_FOUND
# SINGULARITY_BINARY
# SINGULARITY_VERSION

find_program(SINGULARITY_BINARY NAMES singularity)

# We require SINGULARITY_compress_default() which was added in v1.7.0
if (SINGULARITY_BINARY)
  execute_process(
    COMMAND singularity --version
    COMMAND cut -c1-5
    OUTPUT_VARIABLE SINGULARITY_VERSION
    ERROR_VARIABLE SINGULARITY_VERSION_ERR
    OUTPUT_STRIP_TRAILING_WHITESPACE
    )
  message(STATUS  "SINGULARITY_VERSION : ${SINGULARITY_VERSION}")
  if(SINGULARITY_VERSION_ERR) 
    set(SINGULARITY_BINARY-NOTFOUND TRUE)
  elseif( SINGULARITY_VERSION VERSION_LESS "2.4.0" )
    set(SINGULARITY_BINARY-NOTFOUND TRUE)
    #<variable|string> VERSION_GREATER <variable|string>)
  else()
    set(SINGULARITY_GOOD_VERSION TRUE)
  endif(SINGULARITY_VERSION_ERR)
endif()

include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(SINGULARITY 
  DEFAULT_MSG
  SINGULARITY_BINARY SINGULARITY_GOOD_VERSION)

#if (NOT SINGULARITY_FOUND)
#  message(STATUS "SINGULARITY not found")
#else()
#  message(STATUS "Found SINGULARITY: ${SINGULARITY_BINARY}")
#endif (NOT SINGULARITY_FOUND)

mark_as_advanced(SINGULARITY_VERSION SINGULARITY_BINARY)
