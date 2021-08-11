import 'dart:async';

import 'package:Ran/generated/app_manager.pbgrpc.dart';
import 'package:Ran/grpc/grpc_stub.dart';
import 'package:Ran/storage/state.dart';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:grpc/grpc_connection_interface.dart';
// import 'package:grpc/grpc_web.dart' as grpc_web;
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

class GrpcClient {
  static final endpoint = getEndpoint();
  static final channel = GrpcUtils.open(endpoint);

  static String getEndpoint() {
    if (kIsWeb) {
      // print("is web");
      return 'http://192.168.0.106:10010';
    } else {
      // print("is native");
      // return 'tcp://192.168.0.106:10010';
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
