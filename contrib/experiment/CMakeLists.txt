build_lib(
    LIBNAME experiment
    SOURCE_FILES model/experiment.cc
                 helper/experiment-helper.cc
                 model/exp-data-header.cc
                 model/seq-header.cc
                 model/compression-app-layer.cc
                 model/compression-packet-gen.cc
                 model/compression-sender.cc
                 model/compression-receiver.cc
                 helper/compression-sender-receiver-helper.cc
    HEADER_FILES model/experiment.h
                 helper/experiment-helper.h
                 model/exp-data-header.h
                 model/seq-header.h
                 model/compression-app-layer.h
                 model/compression-packet-gen.h
                 model/compression-sender.h
                 model/compression-receiver.h
                 model/custom-tcp-socket-base.h
                 helper/compression-sender-receiver-helper.h
    LIBRARIES_TO_LINK ${libcore}
                      ${libinternet}
                      ${libapplications}
                      ${libpoint-to-point}
                      ${libnetwork}
)
