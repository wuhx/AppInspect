///
//  Generated code. Do not modify.
//  source: android_manager.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class HookListModulesReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HookListModulesReq', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'android_manager'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pkgName')
    ..hasRequiredFields = false
  ;

  HookListModulesReq._() : super();
  factory HookListModulesReq({
    $core.String? pkgName,
  }) {
    final _result = create();
    if (pkgName != null) {
      _result.pkgName = pkgName;
    }
    return _result;
  }
  factory HookListModulesReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HookListModulesReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HookListModulesReq clone() => HookListModulesReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HookListModulesReq copyWith(void Function(HookListModulesReq) updates) => super.copyWith((message) => updates(message as HookListModulesReq)) as HookListModulesReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HookListModulesReq create() => HookListModulesReq._();
  HookListModulesReq createEmptyInstance() => create();
  static $pb.PbList<HookListModulesReq> createRepeated() => $pb.PbList<HookListModulesReq>();
  @$core.pragma('dart2js:noInline')
  static HookListModulesReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HookListModulesReq>(create);
  static HookListModulesReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get pkgName => $_getSZ(0);
  @$pb.TagNumber(1)
  set pkgName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPkgName() => $_has(0);
  @$pb.TagNumber(1)
  void clearPkgName() => clearField(1);
}

class ModuleInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ModuleInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'android_manager'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'path')
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'baseAddr', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'size', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  ModuleInfo._() : super();
  factory ModuleInfo({
    $core.String? name,
    $core.String? path,
    $fixnum.Int64? baseAddr,
    $fixnum.Int64? size,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (path != null) {
      _result.path = path;
    }
    if (baseAddr != null) {
      _result.baseAddr = baseAddr;
    }
    if (size != null) {
      _result.size = size;
    }
    return _result;
  }
  factory ModuleInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ModuleInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ModuleInfo clone() => ModuleInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ModuleInfo copyWith(void Function(ModuleInfo) updates) => super.copyWith((message) => updates(message as ModuleInfo)) as ModuleInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ModuleInfo create() => ModuleInfo._();
  ModuleInfo createEmptyInstance() => create();
  static $pb.PbList<ModuleInfo> createRepeated() => $pb.PbList<ModuleInfo>();
  @$core.pragma('dart2js:noInline')
  static ModuleInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ModuleInfo>(create);
  static ModuleInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get path => $_getSZ(1);
  @$pb.TagNumber(2)
  set path($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearPath() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get baseAddr => $_getI64(2);
  @$pb.TagNumber(3)
  set baseAddr($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBaseAddr() => $_has(2);
  @$pb.TagNumber(3)
  void clearBaseAddr() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get size => $_getI64(3);
  @$pb.TagNumber(4)
  set size($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSize() => $_has(3);
  @$pb.TagNumber(4)
  void clearSize() => clearField(4);
}

class HookListModulesResp extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HookListModulesResp', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'android_manager'), createEmptyInstance: create)
    ..pc<ModuleInfo>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'modules', $pb.PbFieldType.PM, subBuilder: ModuleInfo.create)
    ..hasRequiredFields = false
  ;

  HookListModulesResp._() : super();
  factory HookListModulesResp({
    $core.Iterable<ModuleInfo>? modules,
  }) {
    final _result = create();
    if (modules != null) {
      _result.modules.addAll(modules);
    }
    return _result;
  }
  factory HookListModulesResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HookListModulesResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HookListModulesResp clone() => HookListModulesResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HookListModulesResp copyWith(void Function(HookListModulesResp) updates) => super.copyWith((message) => updates(message as HookListModulesResp)) as HookListModulesResp; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HookListModulesResp create() => HookListModulesResp._();
  HookListModulesResp createEmptyInstance() => create();
  static $pb.PbList<HookListModulesResp> createRepeated() => $pb.PbList<HookListModulesResp>();
  @$core.pragma('dart2js:noInline')
  static HookListModulesResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HookListModulesResp>(create);
  static HookListModulesResp? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ModuleInfo> get modules => $_getList(0);
}

class HookListSymbolsReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HookListSymbolsReq', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'android_manager'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'moduleName')
    ..hasRequiredFields = false
  ;

  HookListSymbolsReq._() : super();
  factory HookListSymbolsReq({
    $core.String? moduleName,
  }) {
    final _result = create();
    if (moduleName != null) {
      _result.moduleName = moduleName;
    }
    return _result;
  }
  factory HookListSymbolsReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HookListSymbolsReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HookListSymbolsReq clone() => HookListSymbolsReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HookListSymbolsReq copyWith(void Function(HookListSymbolsReq) updates) => super.copyWith((message) => updates(message as HookListSymbolsReq)) as HookListSymbolsReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HookListSymbolsReq create() => HookListSymbolsReq._();
  HookListSymbolsReq createEmptyInstance() => create();
  static $pb.PbList<HookListSymbolsReq> createRepeated() => $pb.PbList<HookListSymbolsReq>();
  @$core.pragma('dart2js:noInline')
  static HookListSymbolsReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HookListSymbolsReq>(create);
  static HookListSymbolsReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get moduleName => $_getSZ(0);
  @$pb.TagNumber(1)
  set moduleName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasModuleName() => $_has(0);
  @$pb.TagNumber(1)
  void clearModuleName() => clearField(1);
}

class HookSymbolInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HookSymbolInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'android_manager'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'moduleName')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'symbolName')
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'address', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'size', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  HookSymbolInfo._() : super();
  factory HookSymbolInfo({
    $core.String? moduleName,
    $core.String? symbolName,
    $fixnum.Int64? address,
    $fixnum.Int64? size,
  }) {
    final _result = create();
    if (moduleName != null) {
      _result.moduleName = moduleName;
    }
    if (symbolName != null) {
      _result.symbolName = symbolName;
    }
    if (address != null) {
      _result.address = address;
    }
    if (size != null) {
      _result.size = size;
    }
    return _result;
  }
  factory HookSymbolInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HookSymbolInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HookSymbolInfo clone() => HookSymbolInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HookSymbolInfo copyWith(void Function(HookSymbolInfo) updates) => super.copyWith((message) => updates(message as HookSymbolInfo)) as HookSymbolInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HookSymbolInfo create() => HookSymbolInfo._();
  HookSymbolInfo createEmptyInstance() => create();
  static $pb.PbList<HookSymbolInfo> createRepeated() => $pb.PbList<HookSymbolInfo>();
  @$core.pragma('dart2js:noInline')
  static HookSymbolInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HookSymbolInfo>(create);
  static HookSymbolInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get moduleName => $_getSZ(0);
  @$pb.TagNumber(1)
  set moduleName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasModuleName() => $_has(0);
  @$pb.TagNumber(1)
  void clearModuleName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get symbolName => $_getSZ(1);
  @$pb.TagNumber(2)
  set symbolName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSymbolName() => $_has(1);
  @$pb.TagNumber(2)
  void clearSymbolName() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get address => $_getI64(2);
  @$pb.TagNumber(3)
  set address($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAddress() => $_has(2);
  @$pb.TagNumber(3)
  void clearAddress() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get size => $_getI64(3);
  @$pb.TagNumber(4)
  set size($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSize() => $_has(3);
  @$pb.TagNumber(4)
  void clearSize() => clearField(4);
}

class HookListSymbolsResp extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HookListSymbolsResp', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'android_manager'), createEmptyInstance: create)
    ..pc<HookSymbolInfo>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'symbols', $pb.PbFieldType.PM, subBuilder: HookSymbolInfo.create)
    ..hasRequiredFields = false
  ;

  HookListSymbolsResp._() : super();
  factory HookListSymbolsResp({
    $core.Iterable<HookSymbolInfo>? symbols,
  }) {
    final _result = create();
    if (symbols != null) {
      _result.symbols.addAll(symbols);
    }
    return _result;
  }
  factory HookListSymbolsResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HookListSymbolsResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HookListSymbolsResp clone() => HookListSymbolsResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HookListSymbolsResp copyWith(void Function(HookListSymbolsResp) updates) => super.copyWith((message) => updates(message as HookListSymbolsResp)) as HookListSymbolsResp; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HookListSymbolsResp create() => HookListSymbolsResp._();
  HookListSymbolsResp createEmptyInstance() => create();
  static $pb.PbList<HookListSymbolsResp> createRepeated() => $pb.PbList<HookListSymbolsResp>();
  @$core.pragma('dart2js:noInline')
  static HookListSymbolsResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HookListSymbolsResp>(create);
  static HookListSymbolsResp? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<HookSymbolInfo> get symbols => $_getList(0);
}

class HookArg extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HookArg', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'android_manager'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'argIndex', $pb.PbFieldType.O3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'argName', protoName: 'arg_Name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'argType')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hooked')
    ..hasRequiredFields = false
  ;

  HookArg._() : super();
  factory HookArg({
    $core.int? argIndex,
    $core.String? argName,
    $core.String? argType,
    $core.bool? hooked,
  }) {
    final _result = create();
    if (argIndex != null) {
      _result.argIndex = argIndex;
    }
    if (argName != null) {
      _result.argName = argName;
    }
    if (argType != null) {
      _result.argType = argType;
    }
    if (hooked != null) {
      _result.hooked = hooked;
    }
    return _result;
  }
  factory HookArg.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HookArg.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HookArg clone() => HookArg()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HookArg copyWith(void Function(HookArg) updates) => super.copyWith((message) => updates(message as HookArg)) as HookArg; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HookArg create() => HookArg._();
  HookArg createEmptyInstance() => create();
  static $pb.PbList<HookArg> createRepeated() => $pb.PbList<HookArg>();
  @$core.pragma('dart2js:noInline')
  static HookArg getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HookArg>(create);
  static HookArg? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get argIndex => $_getIZ(0);
  @$pb.TagNumber(1)
  set argIndex($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasArgIndex() => $_has(0);
  @$pb.TagNumber(1)
  void clearArgIndex() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get argName => $_getSZ(1);
  @$pb.TagNumber(2)
  set argName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasArgName() => $_has(1);
  @$pb.TagNumber(2)
  void clearArgName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get argType => $_getSZ(2);
  @$pb.TagNumber(3)
  set argType($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasArgType() => $_has(2);
  @$pb.TagNumber(3)
  void clearArgType() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get hooked => $_getBF(3);
  @$pb.TagNumber(4)
  set hooked($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasHooked() => $_has(3);
  @$pb.TagNumber(4)
  void clearHooked() => clearField(4);
}

class HookInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HookInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'android_manager'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'moduleName')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'symbolName')
    ..pc<HookArg>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'args', $pb.PbFieldType.PM, subBuilder: HookArg.create)
    ..hasRequiredFields = false
  ;

  HookInfo._() : super();
  factory HookInfo({
    $core.String? moduleName,
    $core.String? symbolName,
    $core.Iterable<HookArg>? args,
  }) {
    final _result = create();
    if (moduleName != null) {
      _result.moduleName = moduleName;
    }
    if (symbolName != null) {
      _result.symbolName = symbolName;
    }
    if (args != null) {
      _result.args.addAll(args);
    }
    return _result;
  }
  factory HookInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HookInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HookInfo clone() => HookInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HookInfo copyWith(void Function(HookInfo) updates) => super.copyWith((message) => updates(message as HookInfo)) as HookInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HookInfo create() => HookInfo._();
  HookInfo createEmptyInstance() => create();
  static $pb.PbList<HookInfo> createRepeated() => $pb.PbList<HookInfo>();
  @$core.pragma('dart2js:noInline')
  static HookInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HookInfo>(create);
  static HookInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get moduleName => $_getSZ(0);
  @$pb.TagNumber(1)
  set moduleName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasModuleName() => $_has(0);
  @$pb.TagNumber(1)
  void clearModuleName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get symbolName => $_getSZ(1);
  @$pb.TagNumber(2)
  set symbolName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSymbolName() => $_has(1);
  @$pb.TagNumber(2)
  void clearSymbolName() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<HookArg> get args => $_getList(2);
}

class HookInfoAddReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HookInfoAddReq', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'android_manager'), createEmptyInstance: create)
    ..aOM<HookInfo>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'info', subBuilder: HookInfo.create)
    ..hasRequiredFields = false
  ;

  HookInfoAddReq._() : super();
  factory HookInfoAddReq({
    HookInfo? info,
  }) {
    final _result = create();
    if (info != null) {
      _result.info = info;
    }
    return _result;
  }
  factory HookInfoAddReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HookInfoAddReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HookInfoAddReq clone() => HookInfoAddReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HookInfoAddReq copyWith(void Function(HookInfoAddReq) updates) => super.copyWith((message) => updates(message as HookInfoAddReq)) as HookInfoAddReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HookInfoAddReq create() => HookInfoAddReq._();
  HookInfoAddReq createEmptyInstance() => create();
  static $pb.PbList<HookInfoAddReq> createRepeated() => $pb.PbList<HookInfoAddReq>();
  @$core.pragma('dart2js:noInline')
  static HookInfoAddReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HookInfoAddReq>(create);
  static HookInfoAddReq? _defaultInstance;

  @$pb.TagNumber(1)
  HookInfo get info => $_getN(0);
  @$pb.TagNumber(1)
  set info(HookInfo v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearInfo() => clearField(1);
  @$pb.TagNumber(1)
  HookInfo ensureInfo() => $_ensure(0);
}

class HookInfoAddResp extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HookInfoAddResp', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'android_manager'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  HookInfoAddResp._() : super();
  factory HookInfoAddResp({
    $core.int? status,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory HookInfoAddResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HookInfoAddResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HookInfoAddResp clone() => HookInfoAddResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HookInfoAddResp copyWith(void Function(HookInfoAddResp) updates) => super.copyWith((message) => updates(message as HookInfoAddResp)) as HookInfoAddResp; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HookInfoAddResp create() => HookInfoAddResp._();
  HookInfoAddResp createEmptyInstance() => create();
  static $pb.PbList<HookInfoAddResp> createRepeated() => $pb.PbList<HookInfoAddResp>();
  @$core.pragma('dart2js:noInline')
  static HookInfoAddResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HookInfoAddResp>(create);
  static HookInfoAddResp? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get status => $_getIZ(0);
  @$pb.TagNumber(1)
  set status($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);
}

class HookInfoListReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HookInfoListReq', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'android_manager'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  HookInfoListReq._() : super();
  factory HookInfoListReq() => create();
  factory HookInfoListReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HookInfoListReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HookInfoListReq clone() => HookInfoListReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HookInfoListReq copyWith(void Function(HookInfoListReq) updates) => super.copyWith((message) => updates(message as HookInfoListReq)) as HookInfoListReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HookInfoListReq create() => HookInfoListReq._();
  HookInfoListReq createEmptyInstance() => create();
  static $pb.PbList<HookInfoListReq> createRepeated() => $pb.PbList<HookInfoListReq>();
  @$core.pragma('dart2js:noInline')
  static HookInfoListReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HookInfoListReq>(create);
  static HookInfoListReq? _defaultInstance;
}

class HookInfoListResp extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HookInfoListResp', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'android_manager'), createEmptyInstance: create)
    ..pc<HookInfo>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hooks', $pb.PbFieldType.PM, subBuilder: HookInfo.create)
    ..hasRequiredFields = false
  ;

  HookInfoListResp._() : super();
  factory HookInfoListResp({
    $core.Iterable<HookInfo>? hooks,
  }) {
    final _result = create();
    if (hooks != null) {
      _result.hooks.addAll(hooks);
    }
    return _result;
  }
  factory HookInfoListResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HookInfoListResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HookInfoListResp clone() => HookInfoListResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HookInfoListResp copyWith(void Function(HookInfoListResp) updates) => super.copyWith((message) => updates(message as HookInfoListResp)) as HookInfoListResp; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HookInfoListResp create() => HookInfoListResp._();
  HookInfoListResp createEmptyInstance() => create();
  static $pb.PbList<HookInfoListResp> createRepeated() => $pb.PbList<HookInfoListResp>();
  @$core.pragma('dart2js:noInline')
  static HookInfoListResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HookInfoListResp>(create);
  static HookInfoListResp? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<HookInfo> get hooks => $_getList(0);
}

class HookServerExitReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HookServerExitReq', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'android_manager'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newPkgName', protoName: 'newPkgName')
    ..hasRequiredFields = false
  ;

  HookServerExitReq._() : super();
  factory HookServerExitReq({
    $core.String? newPkgName,
  }) {
    final _result = create();
    if (newPkgName != null) {
      _result.newPkgName = newPkgName;
    }
    return _result;
  }
  factory HookServerExitReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HookServerExitReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HookServerExitReq clone() => HookServerExitReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HookServerExitReq copyWith(void Function(HookServerExitReq) updates) => super.copyWith((message) => updates(message as HookServerExitReq)) as HookServerExitReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HookServerExitReq create() => HookServerExitReq._();
  HookServerExitReq createEmptyInstance() => create();
  static $pb.PbList<HookServerExitReq> createRepeated() => $pb.PbList<HookServerExitReq>();
  @$core.pragma('dart2js:noInline')
  static HookServerExitReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HookServerExitReq>(create);
  static HookServerExitReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get newPkgName => $_getSZ(0);
  @$pb.TagNumber(1)
  set newPkgName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNewPkgName() => $_has(0);
  @$pb.TagNumber(1)
  void clearNewPkgName() => clearField(1);
}

class HookServerExitResp extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HookServerExitResp', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'android_manager'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result')
    ..hasRequiredFields = false
  ;

  HookServerExitResp._() : super();
  factory HookServerExitResp({
    $core.String? result,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    return _result;
  }
  factory HookServerExitResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HookServerExitResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HookServerExitResp clone() => HookServerExitResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HookServerExitResp copyWith(void Function(HookServerExitResp) updates) => super.copyWith((message) => updates(message as HookServerExitResp)) as HookServerExitResp; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HookServerExitResp create() => HookServerExitResp._();
  HookServerExitResp createEmptyInstance() => create();
  static $pb.PbList<HookServerExitResp> createRepeated() => $pb.PbList<HookServerExitResp>();
  @$core.pragma('dart2js:noInline')
  static HookServerExitResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HookServerExitResp>(create);
  static HookServerExitResp? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get result => $_getSZ(0);
  @$pb.TagNumber(1)
  set result($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);
}

class HookDumpMemRangeReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HookDumpMemRangeReq', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'android_manager'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'start', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'end', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  HookDumpMemRangeReq._() : super();
  factory HookDumpMemRangeReq({
    $fixnum.Int64? start,
    $fixnum.Int64? end,
    $core.String? name,
  }) {
    final _result = create();
    if (start != null) {
      _result.start = start;
    }
    if (end != null) {
      _result.end = end;
    }
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory HookDumpMemRangeReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HookDumpMemRangeReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HookDumpMemRangeReq clone() => HookDumpMemRangeReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HookDumpMemRangeReq copyWith(void Function(HookDumpMemRangeReq) updates) => super.copyWith((message) => updates(message as HookDumpMemRangeReq)) as HookDumpMemRangeReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HookDumpMemRangeReq create() => HookDumpMemRangeReq._();
  HookDumpMemRangeReq createEmptyInstance() => create();
  static $pb.PbList<HookDumpMemRangeReq> createRepeated() => $pb.PbList<HookDumpMemRangeReq>();
  @$core.pragma('dart2js:noInline')
  static HookDumpMemRangeReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HookDumpMemRangeReq>(create);
  static HookDumpMemRangeReq? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get start => $_getI64(0);
  @$pb.TagNumber(1)
  set start($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStart() => $_has(0);
  @$pb.TagNumber(1)
  void clearStart() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get end => $_getI64(1);
  @$pb.TagNumber(2)
  set end($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEnd() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnd() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);
}

class HookDumpMemRangeResp extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HookDumpMemRangeResp', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'android_manager'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.O3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dumpFileOnDevice', protoName: 'dumpFileOnDevice')
    ..hasRequiredFields = false
  ;

  HookDumpMemRangeResp._() : super();
  factory HookDumpMemRangeResp({
    $core.int? status,
    $core.String? dumpFileOnDevice,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    if (dumpFileOnDevice != null) {
      _result.dumpFileOnDevice = dumpFileOnDevice;
    }
    return _result;
  }
  factory HookDumpMemRangeResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HookDumpMemRangeResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HookDumpMemRangeResp clone() => HookDumpMemRangeResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HookDumpMemRangeResp copyWith(void Function(HookDumpMemRangeResp) updates) => super.copyWith((message) => updates(message as HookDumpMemRangeResp)) as HookDumpMemRangeResp; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HookDumpMemRangeResp create() => HookDumpMemRangeResp._();
  HookDumpMemRangeResp createEmptyInstance() => create();
  static $pb.PbList<HookDumpMemRangeResp> createRepeated() => $pb.PbList<HookDumpMemRangeResp>();
  @$core.pragma('dart2js:noInline')
  static HookDumpMemRangeResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HookDumpMemRangeResp>(create);
  static HookDumpMemRangeResp? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get status => $_getIZ(0);
  @$pb.TagNumber(1)
  set status($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get dumpFileOnDevice => $_getSZ(1);
  @$pb.TagNumber(2)
  set dumpFileOnDevice($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDumpFileOnDevice() => $_has(1);
  @$pb.TagNumber(2)
  void clearDumpFileOnDevice() => clearField(2);
}

