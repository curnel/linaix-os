#
#   Copyleft (C) 2025 linaix-os project.
#   Follow MIT License.
#

macro(add_c_flags)
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${ARGN}")
endmacro(add_c_flags)

macro(add_cxx_flags)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${ARGN}")
endmacro(add_cxx_flags)

macro(add_compile_flags)
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${ARGN}")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${ARGN}")
endmacro(add_compile_flags)

macro(reset_compile_flags)
  set(CMAKE_C_FLAGS "")
  set(CMAKE_CXX_FLAGS "")
endmacro(reset_compile_flags)

macro(add_exe_link_flags)
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${ARGN}")
endmacro(add_exe_link_flags)

macro(add_shared_link_flags)
  set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} ${ARGN}")
endmacro(add_shared_link_flags)

macro(add_link_flags)
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${ARGN}")
  set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} ${ARGN}")
endmacro(add_link_flags)

macro(reset_link_flags)
  set(CMAKE_EXE_LINKER_FLAGS "")
  set(CMAKE_SHARED_LINKER_FLAGS "")
endmacro(reset_link_flags)

macro(set_compile_flags cflags cppflags)
  set(CMAKE_C_FLAGS "${cflags}")
  set(CMAKE_CXX_FLAGS "${cppflags}")
endmacro(set_compile_flags)

macro(set_link_flags flags)
  set(CMAKE_EXE_LINKER_FLAGS "${flags}")
  set(CMAKE_SHARED_LINKER_FLAGS "${flags}")
endmacro(set_link_flags)

macro(set_optim_flags flags)
  set(CMAKE_C_FLAGS_RELEASE "${flags}")
  set(CMAKE_CXX_FLAGS_RELEASE "${flags}")
  set(CMAKE_C_FLAGS_DEBUG "${flags}")
  set(CMAKE_CXX_FLAGS_DEBUG "${flags}")
endmacro(set_optim_flags)