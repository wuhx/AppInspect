import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart';

class GrpcUtils {
  GrpcUtils._();

  static ClientChannelBase open(String url) {
    var uri = Uri.parse(url);

    var ch = ClientChannel(
      uri.host,
      port: uri.port,
      options: ChannelOptions(
        credentials: ChannelCredentials.insecure(),
        codecRegistry:
            CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
      ),
    );
    return ch;
  }
}
