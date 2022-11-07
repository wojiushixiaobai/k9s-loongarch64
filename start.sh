docker build -t k9s-loongarch64 .
docker run --rm -v "$(pwd)"/dist:/dist k9s-loongarch64
ls -al "$(pwd)"/dist
