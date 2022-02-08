
Conan create 
--------

Create a cctag/1.0.1@zyf/testing for android.

    export ANDROID_NDK=/home/zyf/Android/Sdk/ndk/22.1.7171670  # change to your own NDK path
    NDK=$ANDROID_NDK/build/cmake/android.toolchain.cmake conan create . zyf/testing -b missing \
    -s os=Android -s os.api_level=30 -s arch=armv8 -s compiler=clang -s compiler.version=11 -s compiler.libcxx=c++_shared

Possible problems 
--------

1.ERROR: The xxx (e.g. 'jbig/20160605') package has 'exports_sources' but sources not found in local cache.
    conan remove jbig/20160605
    conan install jbig/20160605@


Changes 
--------
1.change boost:header_only from False to True
If False, there are wired errors: <br>

    libs/context/src/asm/make_arm64_aapcs_elf_gas.S:61:5: error: unknown use of instruction mnemonic without a size suffix
        and x0, x0, ~0xF
        ^
    libs/context/src/asm/make_arm64_aapcs_elf_gas.S:64:17: error: unknown token in expression
        sub x0, x0, #0xb0
                    ^
    libs/context/src/asm/make_arm64_aapcs_elf_gas.S:68:16: error: expected ']' in brackets expression<br>
        str x2, [x0, #0xa0]
                   ^
    libs/context/src/asm/make_arm64_aapcs_elf_gas.S:72:5: error: invalid instruction mnemonic 'adr'<br>
        adr x1, finish
        ^
    libs/context/src/asm/make_arm64_aapcs_elf_gas.S:73:16: error: expected ']' in brackets expression<br>
        str x1, [x0, #0x98]
    ...
    
<br>
2.Comment BOOST_REQUIRED_COMPONENTS parts in CMakeLists.txt
If False, there are errors:

    CMake Error at FindBoost.cmake:6 (message):
      Conan: Component 'atomic' NOT found in package 'Boost'
    Call Stack (most recent call first):
      FindBoost.cmake:91 (conan_message)
      CMakeLists.txt:90 (find_package)

<br>
3.change opencv/4.1.2@oppen/testing to opencv/4.1.2
cmake errors like: Could NOT find JPEG, TIFF, Jasper...
After setting their options to False in conanfile.py of opencv, errors will be:

    /home/zyf/.conan/data/opencv/4.1.2/oppen/testing/build/42958629fa7ebf896be49380f745528e5b2b5040/source_subfolder/modules/core/src/check.cpp:62:23: error: implicit instantiation of undefined template 'std::__ndk1::basic_stringstream<char, std::__ndk1::char_traits<char>, std::__ndk1::allocator<char>>'
        std::stringstream ss;
                          ^
    /home/zyf/Android/Sdk/ndk/22.1.7171670/toolchains/llvm/prebuilt/linux-x86_64/bin/../sysroot/usr/include/c++/v1/iosfwd:139:32: note: template is declared here
        class _LIBCPP_TEMPLATE_VIS basic_stringstream;

I don't know how to fix them. Using opencv/4.1.2 will pass successfully.

