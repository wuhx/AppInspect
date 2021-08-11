import 'package:grpc/grpc_connection_interface.dart';
import 'package:grpc/grpc_web.dart' as grpc_web;

class GrpcUtils {
  GrpcUtils._();

  static ClientChannelBase open(String url) {
    return grpc_web.GrpcWebClientChannel.xhr(Uri.parse(url));
  }
}
