_find_package(${ARGS})
if(OPENSSL_FOUND)
    find_library(OPENSSL_DL_LIBRARY NAMES dl)
    if(OPENSSL_DL_LIBRARY)
        list(APPEND OPENSSL_LIBRARIES "dl")
        if(TARGET OpenSSL::Crypto)
            set_property(TARGET OpenSSL::Crypto APPEND PROPERTY INTERFACE_LINK_LIBRARIES "dl")
        endif()
    endif()
    find_package(Threads REQUIRED)
    find_package(ZLIB REQUIRED)
    list(APPEND OPENSSL_LIBRARIES ${CMAKE_THREAD_LIBS_INIT})
    list(APPEND OPENSSL_LIBRARIES ${ZLIB_LIBRARIES})
    target_link_libraries(OpenSSL::Crypto INTERFACE Threads::Threads)
    target_link_libraries(OpenSSL::SSL INTERFACE Threads::Threads)
    target_link_libraries(OpenSSL::Crypto INTERFACE ZLIB::ZLIB)
    target_link_libraries(OpenSSL::SSL INTERFACE ZLIB::ZLIB)
endif()