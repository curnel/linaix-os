#
#   Copyleft (C) 2025 linaix-os project.
#   Follow MIT License.
#

cmake_minimum_required(VERSION 3.30)

# set compiler
set(CMAKE_C_COMPILER "/usr/bin/clang")
set(CMAKE_CXX_COMPILER "/usr/bin/clang++")
set(CMAKE_EXE_LINKER "/usr/bin/ld.lld")

# generate compile_commans.json
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# set ISA
set(OS_ARCH "x86")

# os name
project(linaix-os)

# language support
enable_language(C)
enable_language(CXX)
enable_language(ASM)

# language standard
set(CMAKE_C_STANDARD 17)
set(CMAKE_CXX_STANDARD 23)

# import utils
include(${CMAKE_SOURCE_DIR}/cmake/utils.cmake)

# compiler kernel
add_subdirectory(${CMAKE_SOURCE_DIR}/kernel)

# make ISO
add_custom_target(ISO ALL DEPENDS kernel
    COMMAND mkdir -p ${CMAKE_BINARY_DIR}/ISO/efi/boot
    COMMAND mkdir -p ${CMAKE_BINARY_DIR}/ISO/${PROJECT_NAME}
    COMMAND cp -r ${CMAKE_SOURCE_DIR}/assets/limine/bootx64.efi ${CMAKE_BINARY_DIR}/ISO/efi/boot/
    COMMAND cp -r ${CMAKE_SOURCE_DIR}/assets/limine/limine-bios.sys ${CMAKE_BINARY_DIR}/ISO/
    COMMAND cp -r ${CMAKE_SOURCE_DIR}/assets/limine/limine-uefi-cd.bin ${CMAKE_BINARY_DIR}/ISO/
    COMMAND cp -r ${CMAKE_SOURCE_DIR}/assets/limine/limine-bios-cd.bin ${CMAKE_BINARY_DIR}/ISO/
    
    COMMAND cp -r ${CMAKE_SOURCE_DIR}/assets/limine/limine.conf ${CMAKE_BINARY_DIR}/ISO/
    
    COMMAND cp -r ${CMAKE_BINARY_DIR}/kernel/kernel ${CMAKE_BINARY_DIR}/ISO/${PROJECT_NAME}/

    COMMAND xorriso -as mkisofs -R -r -J -b limine-bios-cd.bin -no-emul-boot -boot-load-size 4 -boot-info-table -hfsplus -apm-block-size 2048 --efi-boot limine-uefi-cd.bin -efi-boot-part --efi-boot-image --protective-msdos-label ${CMAKE_BINARY_DIR}/ISO/ -o ${CMAKE_BINARY_DIR}/${PROJECT_NAME}.iso
    COMMAND ${CMAKE_SOURCE_DIR}/assets/limine/limine bios-install ${CMAKE_BINARY_DIR}/${PROJECT_NAME}.iso

    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
)

# debug linaix-os with QEMU
add_custom_target(run DEPENDS ISO
    COMMAND qemu-system-x86_64 -enable-kvm -m 2G -bios ${CMAKE_SOURCE_DIR}/assets/ovmf/ovmf_code.fd -net none -cdrom ${CMAKE_BINARY_DIR}/${PROJECT_NAME}.iso -name ${PROJECT_NAME}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
)