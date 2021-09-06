import 'package:Ran/generated/app_manager.pbgrpc.dart';
import 'package:Ran/grpc/grpc_stub.dart';
import 'package:grpc/grpc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:grpc/grpc_connection_interface.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

class GrpcClient {
  static final endpoint = getEndpoint();
  static final channel = GrpcUtils.open(endpoint);

  static String getEndpoint() {
    if (kIsWeb) {
      // print("is web: ${Uri.base}");
      return 'http://${Uri.base.host}:10010';
    } else {
      // print("is native");
      return 'tcp://127.0.0.1:10010';
    }
  }

  static String token = "com.cloudmonad.inspect.debug";
  // static const token = String.fromEnvironment('GRPC_TOKEN');

  static final grpcClient = AppManagerClient(channel,
      options: CallOptions(metadata: {'authorization': 'Bearer $token'}));

  // static Future<AppControlResp> appControl(AppControlReq req) {
  //   var resp = grpcClient.appControl(req, options: CallOptions());
  //   return resp;
  // }
}
