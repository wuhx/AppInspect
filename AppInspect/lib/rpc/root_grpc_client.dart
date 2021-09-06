import 'package:Ran/grpc/grpc_stub.dart';
import 'package:grpc/grpc.dart';
import 'package:Ran/generated/root_manager.pbgrpc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:grpc/grpc_connection_interface.dart';
import 'package:flutter/foundation.dart';

class RootGrpcClient {
  static final endpoint = getEndpoint();
  static final channel = GrpcUtils.open(endpoint);

  static String getEndpoint() {
    if (kIsWeb) {
      return 'http://${Uri.base.host}:65535';
    } else {
      // print("is native");
      return 'tcp://127.0.0.1:65535';
    }
  }

  static String token = "com.cloudmonad.inspect.debug";
  // static const token = String.fromEnvironment('GRPC_TOKEN');

  static final grpcClient = RootManagerClient(channel,
      options: CallOptions(metadata: {'authorization': 'Bearer $token'}));
}
