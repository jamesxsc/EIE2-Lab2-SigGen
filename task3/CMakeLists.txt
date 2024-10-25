cmake_minimum_required(VERSION 3.12)
cmake_policy(SET CMP0074 NEW)
project(lab2_task3)

find_package(verilator HINTS $ENV{VERILATOR_ROOT} ${VERILATOR_ROOT})

if (NOT verilator_FOUND)
    message(FATAL_ERROR "Verilator not found!")
endif()

add_executable(sigdelay ./sigdelay_tb.cpp)
target_compile_features(sigdelay PRIVATE cxx_std_17)

verilate(sigdelay TRACE
    VERILATOR_ARGS -Wall
    SOURCES ./sigdelay.sv
)
