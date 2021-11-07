# openssl_crypto_exp
OpenSSL crypto experiment


# Setup

https://wiki.openssl.org/index.php/Compilation_and_Installation#OS_X

```
git submodule add https://github.com/openssl/openssl

./Configure darwin64-x86_64-cc shared enable-ec_nistp_64_gcc_128 no-ssl2 no-ssl3 no-comp --openssldir=/usr/local/ssl/macos-x86_64
make depend
make build_crypto
```