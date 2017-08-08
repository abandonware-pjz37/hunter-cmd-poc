cmake_minimum_required(VERSION 3.0)

set(temp_dir "${CMAKE_CURRENT_LIST_DIR}/_Hunter_tmp")

file(REMOVE_RECURSE "${temp_dir}")

file(COPY ${CMAKE_CURRENT_LIST_DIR}/HunterGate.cmake DESTINATION ${temp_dir})

string(COMPARE EQUAL "${PACKAGE}" "" is_empty)
if(is_empty)
  message(FATAL_ERROR "PACKAGE is not defined")
endif()

configure_file(
   "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt.in"
   "${temp_dir}/CMakeLists.txt"
   @ONLY
)

execute_process(
    COMMAND ${CMAKE_COMMAND} -H${temp_dir} -B${temp_dir}/_builds -DHUNTER_ROOT=${temp_dir}/_HUNTER -DHUNTER_STATUS_DEBUG=ON
    WORKING_DIRECTORY ${temp_dir}
    RESULT_VARIABLE result
)

if(result EQUAL 0)
  return()
endif()

message(FATAL_ERROR "Build failed: ${result}")
