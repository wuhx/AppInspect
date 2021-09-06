// import 'package:Ran/grpc/native.dart';
import 'package:Ran/grpc/grpc_stub.dart';
import 'package:grpc/grpc.dart';
import 'package:Ran/generated/android_manager.pbgrpc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:grpc/grpc_connection_interface.dart';
import 'package:flutter/foundation.dart';
// import 'package:grpc/grpc_web.dart';

class HookGrpcClient {
  static final endpoint = getEndpoint();
  static final channel = GrpcUtils.open(endpoint);

  static String getEndpoint() {
    if (kIsWeb) {
      // print("is web");
      return 'http://${Uri.base.host}:10015';
    } else {
      // print("is native");
      return 'tcp://127.0.0.1:10015';
    }
  }

  static String token = "com.cloudmonad.inspect.debug";
  // static const token = String.fromEnvironment('GRPC_TOKEN');

  static final grpcClient = AndroidManagerClient(channel,
      options: CallOptions(metadata: {'authorization': 'Bearer $token'}));
}
