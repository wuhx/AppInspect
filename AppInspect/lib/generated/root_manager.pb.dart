///
//  Generated code. Do not modify.
//  source: root_manager.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class RunRootCmdReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RunRootCmdReq', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'root_manager'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cmd')
    ..hasRequiredFields = false
  ;

  RunRootCmdReq._() : super();
  factory RunRootCmdReq({
    $core.String? cmd,
  }) {
    final _result = create();
    if (cmd != null) {
      _result.cmd = cmd;
    }
    return _result;
  }
  factory RunRootCmdReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RunRootCmdReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RunRootCmdReq clone() => RunRootCmdReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RunRootCmdReq copyWith(void Function(RunRootCmdReq) updates) => super.copyWith((message) => updates(message as RunRootCmdReq)) as RunRootCmdReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RunRootCmdReq create() => RunRootCmdReq._();
  RunRootCmdReq createEmptyInstance() => create();
  static $pb.PbList<RunRootCmdReq> createRepeated() => $pb.PbList<RunRootCmdReq>();
  @$core.pragma('dart2js:noInline')
  static RunRootCmdReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RunRootCmdReq>(create);
  static RunRootCmdReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cmd => $_getSZ(0);
  @$pb.TagNumber(1)
  set cmd($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCmd() => $_has(0);
  @$pb.TagNumber(1)
  void clearCmd() => clearField(1);
}

class RunRootCmdResp extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RunRootCmdResp', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'root_manager'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result')
    ..hasRequiredFields = false
  ;

  RunRootCmdResp._() : super();
  factory RunRootCmdResp({
    $core.String? result,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    return _result;
  }
  factory RunRootCmdResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RunRootCmdResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RunRootCmdResp clone() => RunRootCmdResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RunRootCmdResp copyWith(void Function(RunRootCmdResp) updates) => super.copyWith((message) => updates(message as RunRootCmdResp)) as RunRootCmdResp; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RunRootCmdResp create() => RunRootCmdResp._();
  RunRootCmdResp createEmptyInstance() => create();
  static $pb.PbList<RunRootCmdResp> createRepeated() => $pb.PbList<RunRootCmdResp>();
  @$core.pragma('dart2js:noInline')
  static RunRootCmdResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RunRootCmdResp>(create);
  static RunRootCmdResp? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get result => $_getSZ(0);
  @$pb.TagNumber(1)
  set result($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);
}

