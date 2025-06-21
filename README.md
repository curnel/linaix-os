# linaix-os

![linaix-os](./docs/img/logo/linaix-os.png)

a unix-like os.

## reference

[reference](./docs/reference/)

## start this os

### packages

LLVM(clang,lld,lldb,clang-format,clang-tidy)
xorriso(genisoimage)
CMake(ninja)
QEMU

``` shell
# if you on the archlinux
sudo pacman -S llvm clang lld lldb xorriso cdrtools qemu cmake ninja
```

### build

``` shell
cmake -B build -G Ninja -DCMAKE_BUILD_TYPE={Release|Debug}
cd build
ninja -j $(nproc)
```

### run

``` shell
cd build
ninja run
```

## license

linaix-os use [MIT License](./LICENSE)
