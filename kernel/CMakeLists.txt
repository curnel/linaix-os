#
#   Copyleft (C) 2025 linaix-os project.
#   Follow MIT License.
#

add_compile_flags("-nostdlib -ffreestanding -fno-stack-protector -fno-stack-check -mcmodel=kernel")
add_cxx_flags("-fno-exceptions -fno-rtti")
add_link_flags("-T ${CMAKE_SOURCE_DIR}/kernel/arch/${OS_ARCH}/linker.lds -fuse-ld=lld")

include_directories(${CMAKE_SOURCE_DIR}/kernel/includes)

set(KERNEL_SOURCES)

# get ISAs 
if(${OS_ARCH} STREQUAL "x86")
    add_compile_flags("-mno-red-zone")
    set(CMAKE_SYSTEM_PROCESSOR x86_64)
else()
    message(FATAL_ERROR "Unsupported architecture: ${OS_ARCH}")
endif()


# get build type
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    add_compile_flags("-Og -g")
elseif(CMAKE_BUILD_TYPE STREQUAL "Release")
    add_compile_flags("-O3")
    add_compile_flags("-flto=thin")
endif()

file(GLOB_RECURSE KERNEL_SOURCES "${CMAKE_SOURCE_DIR}/kernel/arch/${OS_ARCH}/*.cpp" "${CMAKE_SOURCE_DIR}/kernel/drivers/*.cpp" "${CMAKE_SOURCE_DIR}/kernel/init/*.cpp")

add_executable(kernel ${KERNEL_SOURCES})