///
//  Generated code. Do not modify.
//  source: app_manager.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'app_manager.pb.dart' as $1;
export 'app_manager.pb.dart';

class AppManagerClient extends $grpc.Client {
  static final _$listPackage =
      $grpc.ClientMethod<$1.PackageInfoReq, $1.PackageInfoList>(
          '/app_manager.AppManager/ListPackage',
          ($1.PackageInfoReq value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.PackageInfoList.fromBuffer(value));

  AppManagerClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.PackageInfoList> listPackage(
      $1.PackageInfoReq request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listPackage, request, options: options);
  }
}

abstract class AppManagerServiceBase extends $grpc.Service {
  $core.String get $name => 'app_manager.AppManager';

  AppManagerServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.PackageInfoReq, $1.PackageInfoList>(
        'ListPackage',
        listPackage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.PackageInfoReq.fromBuffer(value),
        ($1.PackageInfoList value) => value.writeToBuffer()));
  }

  $async.Future<$1.PackageInfoList> listPackage_Pre(
      $grpc.ServiceCall call, $async.Future<$1.PackageInfoReq> request) async {
    return listPackage(call, await request);
  }

  $async.Future<$1.PackageInfoList> listPackage(
      $grpc.ServiceCall call, $1.PackageInfoReq request);
}
