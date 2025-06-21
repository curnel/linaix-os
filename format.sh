#!/usr/bin/sh

#
#   Copyleft (C) 2025 linaix-os project.
#   Follow MIT License.
#

find kernel/ -type f \( -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" \) -exec clang-format -i {} +