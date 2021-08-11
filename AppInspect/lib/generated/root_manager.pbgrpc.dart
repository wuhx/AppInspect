///
//  Generated code. Do not modify.
//  source: root_manager.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'root_manager.pb.dart' as $2;
export 'root_manager.pb.dart';

class RootManagerClient extends $grpc.Client {
  static final _$runRootCmd =
      $grpc.ClientMethod<$2.RunRootCmdReq, $2.RunRootCmdResp>(
          '/root_manager.RootManager/RunRootCmd',
          ($2.RunRootCmdReq value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.RunRootCmdResp.fromBuffer(value));

  RootManagerClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$2.RunRootCmdResp> runRootCmd($2.RunRootCmdReq request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$runRootCmd, request, options: options);
  }
}

abstract class RootManagerServiceBase extends $grpc.Service {
  $core.String get $name => 'root_manager.RootManager';

  RootManagerServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.RunRootCmdReq, $2.RunRootCmdResp>(
        'RunRootCmd',
        runRootCmd_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.RunRootCmdReq.fromBuffer(value),
        ($2.RunRootCmdResp value) => value.writeToBuffer()));
  }

  $async.Future<$2.RunRootCmdResp> runRootCmd_Pre(
      $grpc.ServiceCall call, $async.Future<$2.RunRootCmdReq> request) async {
    return runRootCmd(call, await request);
  }

  $async.Future<$2.RunRootCmdResp> runRootCmd(
      $grpc.ServiceCall call, $2.RunRootCmdReq request);
}
