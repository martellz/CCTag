cd build_android
NDK=/home/zyf/Android/Sdk/ndk/23.1.7779620/build/cmake/android.toolchain.cmake conan create .. zyf/testing -s os=Android -s os.api_level=21 -s arch=armv8 -s compiler=clang -s compiler.version=11 -s compiler.libcxx=libstdc++11 -b missing
