PROTO_DIR=../protos
DART_OUT=lib/generated
# JAVA_OUT=android/app/src/main/java/com/defyun/pb
JAVA_OUT_BASE=android/app/src/main/java/
JAVA_OUT=android/app/src/main/java/com/defyun/pb


#find /opt/homebrew -name timestamp.proto
TIMESTAMP=/opt/homebrew/Cellar/protobuf/3.15.5/include/google/protobuf/timestamp.proto

#install
#dart pub global activate protoc_plugin

#RUST_OUT=libfastlane/src/pb

rm -fr $DART_OUT
mkdir -p $DART_OUT

rm -fr $JAVA_OUT
mkdir -p $JAVA_OUT

protoc -I $PROTO_DIR \
    --dart_out=grpc:$DART_OUT \
    --java_out=lite:$JAVA_OUT_BASE \
    $PROTO_DIR/*.proto 
    #$TIMESTAMP

