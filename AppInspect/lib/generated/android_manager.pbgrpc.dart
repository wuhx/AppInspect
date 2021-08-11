///
//  Generated code. Do not modify.
//  source: android_manager.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'android_manager.pb.dart' as $0;
export 'android_manager.pb.dart';

class AndroidManagerClient extends $grpc.Client {
  static final _$hookListModules =
      $grpc.ClientMethod<$0.HookListModulesReq, $0.HookListModulesResp>(
          '/android_manager.AndroidManager/HookListModules',
          ($0.HookListModulesReq value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.HookListModulesResp.fromBuffer(value));
  static final _$hookListSymbols =
      $grpc.ClientMethod<$0.HookListSymbolsReq, $0.HookListSymbolsResp>(
          '/android_manager.AndroidManager/HookListSymbols',
          ($0.HookListSymbolsReq value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.HookListSymbolsResp.fromBuffer(value));
  static final _$hookInfoAdd =
      $grpc.ClientMethod<$0.HookInfoAddReq, $0.HookInfoAddResp>(
          '/android_manager.AndroidManager/HookInfoAdd',
          ($0.HookInfoAddReq value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.HookInfoAddResp.fromBuffer(value));
  static final _$hookInfoList =
      $grpc.ClientMethod<$0.HookInfoListReq, $0.HookInfoListResp>(
          '/android_manager.AndroidManager/HookInfoList',
          ($0.HookInfoListReq value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.HookInfoListResp.fromBuffer(value));
  static final _$hookServerExit =
      $grpc.ClientMethod<$0.HookServerExitReq, $0.HookServerExitResp>(
          '/android_manager.AndroidManager/HookServerExit',
          ($0.HookServerExitReq value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.HookServerExitResp.fromBuffer(value));
  static final _$hookDumpMemRange =
      $grpc.ClientMethod<$0.HookDumpMemRangeReq, $0.HookDumpMemRangeResp>(
          '/android_manager.AndroidManager/HookDumpMemRange',
          ($0.HookDumpMemRangeReq value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.HookDumpMemRangeResp.fromBuffer(value));

  AndroidManagerClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.HookListModulesResp> hookListModules(
      $0.HookListModulesReq request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$hookListModules, request, options: options);
  }

  $grpc.ResponseFuture<$0.HookListSymbolsResp> hookListSymbols(
      $0.HookListSymbolsReq request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$hookListSymbols, request, options: options);
  }

  $grpc.ResponseFuture<$0.HookInfoAddResp> hookInfoAdd(
      $0.HookInfoAddReq request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$hookInfoAdd, request, options: options);
  }

  $grpc.ResponseFuture<$0.HookInfoListResp> hookInfoList(
      $0.HookInfoListReq request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$hookInfoList, request, options: options);
  }

  $grpc.ResponseFuture<$0.HookServerExitResp> hookServerExit(
      $0.HookServerExitReq request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$hookServerExit, request, options: options);
  }

  $grpc.ResponseFuture<$0.HookDumpMemRangeResp> hookDumpMemRange(
      $0.HookDumpMemRangeReq request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$hookDumpMemRange, request, options: options);
  }
}

abstract class AndroidManagerServiceBase extends $grpc.Service {
  $core.String get $name => 'android_manager.AndroidManager';

  AndroidManagerServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.HookListModulesReq, $0.HookListModulesResp>(
            'HookListModules',
            hookListModules_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.HookListModulesReq.fromBuffer(value),
            ($0.HookListModulesResp value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.HookListSymbolsReq, $0.HookListSymbolsResp>(
            'HookListSymbols',
            hookListSymbols_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.HookListSymbolsReq.fromBuffer(value),
            ($0.HookListSymbolsResp value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.HookInfoAddReq, $0.HookInfoAddResp>(
        'HookInfoAdd',
        hookInfoAdd_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.HookInfoAddReq.fromBuffer(value),
        ($0.HookInfoAddResp value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.HookInfoListReq, $0.HookInfoListResp>(
        'HookInfoList',
        hookInfoList_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.HookInfoListReq.fromBuffer(value),
        ($0.HookInfoListResp value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.HookServerExitReq, $0.HookServerExitResp>(
        'HookServerExit',
        hookServerExit_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.HookServerExitReq.fromBuffer(value),
        ($0.HookServerExitResp value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.HookDumpMemRangeReq, $0.HookDumpMemRangeResp>(
            'HookDumpMemRange',
            hookDumpMemRange_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.HookDumpMemRangeReq.fromBuffer(value),
            ($0.HookDumpMemRangeResp value) => value.writeToBuffer()));
  }

  $async.Future<$0.HookListModulesResp> hookListModules_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.HookListModulesReq> request) async {
    return hookListModules(call, await request);
  }

  $async.Future<$0.HookListSymbolsResp> hookListSymbols_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.HookListSymbolsReq> request) async {
    return hookListSymbols(call, await request);
  }

  $async.Future<$0.HookInfoAddResp> hookInfoAdd_Pre(
      $grpc.ServiceCall call, $async.Future<$0.HookInfoAddReq> request) async {
    return hookInfoAdd(call, await request);
  }

  $async.Future<$0.HookInfoListResp> hookInfoList_Pre(
      $grpc.ServiceCall call, $async.Future<$0.HookInfoListReq> request) async {
    return hookInfoList(call, await request);
  }

  $async.Future<$0.HookServerExitResp> hookServerExit_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.HookServerExitReq> request) async {
    return hookServerExit(call, await request);
  }

  $async.Future<$0.HookDumpMemRangeResp> hookDumpMemRange_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.HookDumpMemRangeReq> request) async {
    return hookDumpMemRange(call, await request);
  }

  $async.Future<$0.HookListModulesResp> hookListModules(
      $grpc.ServiceCall call, $0.HookListModulesReq request);
  $async.Future<$0.HookListSymbolsResp> hookListSymbols(
      $grpc.ServiceCall call, $0.HookListSymbolsReq request);
  $async.Future<$0.HookInfoAddResp> hookInfoAdd(
      $grpc.ServiceCall call, $0.HookInfoAddReq request);
  $async.Future<$0.HookInfoListResp> hookInfoList(
      $grpc.ServiceCall call, $0.HookInfoListReq request);
  $async.Future<$0.HookServerExitResp> hookServerExit(
      $grpc.ServiceCall call, $0.HookServerExitReq request);
  $async.Future<$0.HookDumpMemRangeResp> hookDumpMemRange(
      $grpc.ServiceCall call, $0.HookDumpMemRangeReq request);
}
