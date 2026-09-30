find_package(ZLIB REQUIRED)

build_lib(
    LIBNAME compression
    SOURCE_FILES model/compression.cc
                 model/compression-net-device.cc
                 model/compression-header.cc
                 model/compression-channel.cc
                 model/compression-remote-channel.cc
                 helper/compression-helper.cc
    HEADER_FILES model/compression.h
                 model/compression-net-device.h
                 model/compression-header.h
                 model/compression-channel.h
                 model/compression-remote-channel.h
                 helper/compression-helper.h
    LIBRARIES_TO_LINK ${libcore}
                      ${libinternet}
                      ${libapplications}
                      ${libpoint-to-point}
                      ${libnetwork}
                      ${libmpi}
                      ZLIB::ZLIB
)
