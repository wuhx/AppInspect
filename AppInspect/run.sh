set -e

#flutter pub global activate protoc_plugin
./gen_proto.sh
#pushd libfastlane/
#./build.sh
#./build-release.sh
#popd

flutter run 

lr com.cloudmonad.inspect
