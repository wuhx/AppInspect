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
      // print("is web");
      return 'http://192.168.0.106:65535';
    } else {
      // print("is native");
      return 'tcp://192.168.0.106:65535';
    }
  }

  static const token = String.fromEnvironment('GRPC_TOKEN');

  static final grpcClient = RootManagerClient(channel,
      options: CallOptions(metadata: {'authorization': 'Bearer $token'}));
}
