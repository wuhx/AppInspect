set -e

export STATIC_SITE=../build/web
rustup target add aarch64-linux-android
rustup target add armv7-linux-androideabi

ln -s ../../protos ../ || true

