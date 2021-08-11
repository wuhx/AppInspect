///
//  Generated code. Do not modify.
//  source: app_manager.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

enum RequestApi_Req {
  packageInfoReq, 
  notSet
}

class RequestApi extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, RequestApi_Req> _RequestApi_ReqByTag = {
    1 : RequestApi_Req.packageInfoReq,
    0 : RequestApi_Req.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RequestApi', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'app_manager'), createEmptyInstance: create)
    ..oo(0, [1])
    ..aOM<PackageInfoReq>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'packageInfoReq', subBuilder: PackageInfoReq.create)
    ..hasRequiredFields = false
  ;

  RequestApi._() : super();
  factory RequestApi({
    PackageInfoReq? packageInfoReq,
  }) {
    final _result = create();
    if (packageInfoReq != null) {
      _result.packageInfoReq = packageInfoReq;
    }
    return _result;
  }
  factory RequestApi.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestApi.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestApi clone() => RequestApi()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestApi copyWith(void Function(RequestApi) updates) => super.copyWith((message) => updates(message as RequestApi)) as RequestApi; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RequestApi create() => RequestApi._();
  RequestApi createEmptyInstance() => create();
  static $pb.PbList<RequestApi> createRepeated() => $pb.PbList<RequestApi>();
  @$core.pragma('dart2js:noInline')
  static RequestApi getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestApi>(create);
  static RequestApi? _defaultInstance;

  RequestApi_Req whichReq() => _RequestApi_ReqByTag[$_whichOneof(0)]!;
  void clearReq() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  PackageInfoReq get packageInfoReq => $_getN(0);
  @$pb.TagNumber(1)
  set packageInfoReq(PackageInfoReq v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPackageInfoReq() => $_has(0);
  @$pb.TagNumber(1)
  void clearPackageInfoReq() => clearField(1);
  @$pb.TagNumber(1)
  PackageInfoReq ensurePackageInfoReq() => $_ensure(0);
}

class PackageInfoReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PackageInfoReq', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'app_manager'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notSystemApp')
    ..pPS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'selectedPackageList')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quick')
    ..hasRequiredFields = false
  ;

  PackageInfoReq._() : super();
  factory PackageInfoReq({
    $core.bool? notSystemApp,
    $core.Iterable<$core.String>? selectedPackageList,
    $core.bool? quick,
  }) {
    final _result = create();
    if (notSystemApp != null) {
      _result.notSystemApp = notSystemApp;
    }
    if (selectedPackageList != null) {
      _result.selectedPackageList.addAll(selectedPackageList);
    }
    if (quick != null) {
      _result.quick = quick;
    }
    return _result;
  }
  factory PackageInfoReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PackageInfoReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PackageInfoReq clone() => PackageInfoReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PackageInfoReq copyWith(void Function(PackageInfoReq) updates) => super.copyWith((message) => updates(message as PackageInfoReq)) as PackageInfoReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PackageInfoReq create() => PackageInfoReq._();
  PackageInfoReq createEmptyInstance() => create();
  static $pb.PbList<PackageInfoReq> createRepeated() => $pb.PbList<PackageInfoReq>();
  @$core.pragma('dart2js:noInline')
  static PackageInfoReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PackageInfoReq>(create);
  static PackageInfoReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get notSystemApp => $_getBF(0);
  @$pb.TagNumber(1)
  set notSystemApp($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNotSystemApp() => $_has(0);
  @$pb.TagNumber(1)
  void clearNotSystemApp() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.String> get selectedPackageList => $_getList(1);

  @$pb.TagNumber(3)
  $core.bool get quick => $_getBF(2);
  @$pb.TagNumber(3)
  set quick($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasQuick() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuick() => clearField(3);
}

class PackageInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PackageInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'app_manager'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pkgName')
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'icon', $pb.PbFieldType.OY)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uid', $pb.PbFieldType.O3)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'processName', protoName: 'processName')
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstInstallTime', protoName: 'firstInstallTime')
    ..aInt64(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastUpdateTime', protoName: 'lastUpdateTime')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceDir', protoName: 'sourceDir')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dataDir', protoName: 'dataDir')
    ..a<$core.int>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minSdkVersion', $pb.PbFieldType.O3, protoName: 'minSdkVersion')
    ..a<$core.int>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetSdkVersion', $pb.PbFieldType.O3, protoName: 'targetSdkVersion')
    ..a<$core.int>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'compileSdkVersion', $pb.PbFieldType.O3, protoName: 'compileSdkVersion')
    ..aOB(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'running')
    ..aOB(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hiding')
    ..hasRequiredFields = false
  ;

  PackageInfo._() : super();
  factory PackageInfo({
    $core.String? name,
    $core.String? pkgName,
    $core.List<$core.int>? icon,
    $core.int? uid,
    $core.String? processName,
    $fixnum.Int64? firstInstallTime,
    $fixnum.Int64? lastUpdateTime,
    $core.String? sourceDir,
    $core.String? dataDir,
    $core.int? minSdkVersion,
    $core.int? targetSdkVersion,
    $core.int? compileSdkVersion,
    $core.bool? running,
    $core.bool? hiding,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (pkgName != null) {
      _result.pkgName = pkgName;
    }
    if (icon != null) {
      _result.icon = icon;
    }
    if (uid != null) {
      _result.uid = uid;
    }
    if (processName != null) {
      _result.processName = processName;
    }
    if (firstInstallTime != null) {
      _result.firstInstallTime = firstInstallTime;
    }
    if (lastUpdateTime != null) {
      _result.lastUpdateTime = lastUpdateTime;
    }
    if (sourceDir != null) {
      _result.sourceDir = sourceDir;
    }
    if (dataDir != null) {
      _result.dataDir = dataDir;
    }
    if (minSdkVersion != null) {
      _result.minSdkVersion = minSdkVersion;
    }
    if (targetSdkVersion != null) {
      _result.targetSdkVersion = targetSdkVersion;
    }
    if (compileSdkVersion != null) {
      _result.compileSdkVersion = compileSdkVersion;
    }
    if (running != null) {
      _result.running = running;
    }
    if (hiding != null) {
      _result.hiding = hiding;
    }
    return _result;
  }
  factory PackageInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PackageInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PackageInfo clone() => PackageInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PackageInfo copyWith(void Function(PackageInfo) updates) => super.copyWith((message) => updates(message as PackageInfo)) as PackageInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PackageInfo create() => PackageInfo._();
  PackageInfo createEmptyInstance() => create();
  static $pb.PbList<PackageInfo> createRepeated() => $pb.PbList<PackageInfo>();
  @$core.pragma('dart2js:noInline')
  static PackageInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PackageInfo>(create);
  static PackageInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get pkgName => $_getSZ(1);
  @$pb.TagNumber(2)
  set pkgName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPkgName() => $_has(1);
  @$pb.TagNumber(2)
  void clearPkgName() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get icon => $_getN(2);
  @$pb.TagNumber(3)
  set icon($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIcon() => $_has(2);
  @$pb.TagNumber(3)
  void clearIcon() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get uid => $_getIZ(3);
  @$pb.TagNumber(4)
  set uid($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUid() => $_has(3);
  @$pb.TagNumber(4)
  void clearUid() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get processName => $_getSZ(4);
  @$pb.TagNumber(5)
  set processName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasProcessName() => $_has(4);
  @$pb.TagNumber(5)
  void clearProcessName() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get firstInstallTime => $_getI64(5);
  @$pb.TagNumber(6)
  set firstInstallTime($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFirstInstallTime() => $_has(5);
  @$pb.TagNumber(6)
  void clearFirstInstallTime() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get lastUpdateTime => $_getI64(6);
  @$pb.TagNumber(7)
  set lastUpdateTime($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasLastUpdateTime() => $_has(6);
  @$pb.TagNumber(7)
  void clearLastUpdateTime() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get sourceDir => $_getSZ(7);
  @$pb.TagNumber(8)
  set sourceDir($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasSourceDir() => $_has(7);
  @$pb.TagNumber(8)
  void clearSourceDir() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get dataDir => $_getSZ(8);
  @$pb.TagNumber(9)
  set dataDir($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasDataDir() => $_has(8);
  @$pb.TagNumber(9)
  void clearDataDir() => clearField(9);

  @$pb.TagNumber(10)
  $core.int get minSdkVersion => $_getIZ(9);
  @$pb.TagNumber(10)
  set minSdkVersion($core.int v) { $_setSignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasMinSdkVersion() => $_has(9);
  @$pb.TagNumber(10)
  void clearMinSdkVersion() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get targetSdkVersion => $_getIZ(10);
  @$pb.TagNumber(11)
  set targetSdkVersion($core.int v) { $_setSignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasTargetSdkVersion() => $_has(10);
  @$pb.TagNumber(11)
  void clearTargetSdkVersion() => clearField(11);

  @$pb.TagNumber(12)
  $core.int get compileSdkVersion => $_getIZ(11);
  @$pb.TagNumber(12)
  set compileSdkVersion($core.int v) { $_setSignedInt32(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasCompileSdkVersion() => $_has(11);
  @$pb.TagNumber(12)
  void clearCompileSdkVersion() => clearField(12);

  @$pb.TagNumber(20)
  $core.bool get running => $_getBF(12);
  @$pb.TagNumber(20)
  set running($core.bool v) { $_setBool(12, v); }
  @$pb.TagNumber(20)
  $core.bool hasRunning() => $_has(12);
  @$pb.TagNumber(20)
  void clearRunning() => clearField(20);

  @$pb.TagNumber(21)
  $core.bool get hiding => $_getBF(13);
  @$pb.TagNumber(21)
  set hiding($core.bool v) { $_setBool(13, v); }
  @$pb.TagNumber(21)
  $core.bool hasHiding() => $_has(13);
  @$pb.TagNumber(21)
  void clearHiding() => clearField(21);
}

class PackageInfoList extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PackageInfoList', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'app_manager'), createEmptyInstance: create)
    ..pc<PackageInfo>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pkgInfoList', $pb.PbFieldType.PM, subBuilder: PackageInfo.create)
    ..hasRequiredFields = false
  ;

  PackageInfoList._() : super();
  factory PackageInfoList({
    $core.Iterable<PackageInfo>? pkgInfoList,
  }) {
    final _result = create();
    if (pkgInfoList != null) {
      _result.pkgInfoList.addAll(pkgInfoList);
    }
    return _result;
  }
  factory PackageInfoList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PackageInfoList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PackageInfoList clone() => PackageInfoList()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PackageInfoList copyWith(void Function(PackageInfoList) updates) => super.copyWith((message) => updates(message as PackageInfoList)) as PackageInfoList; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PackageInfoList create() => PackageInfoList._();
  PackageInfoList createEmptyInstance() => create();
  static $pb.PbList<PackageInfoList> createRepeated() => $pb.PbList<PackageInfoList>();
  @$core.pragma('dart2js:noInline')
  static PackageInfoList getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PackageInfoList>(create);
  static PackageInfoList? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PackageInfo> get pkgInfoList => $_getList(0);
}

class AppControlReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AppControlReq', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'app_manager'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pkgName')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cmd')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'arg')
    ..hasRequiredFields = false
  ;

  AppControlReq._() : super();
  factory AppControlReq({
    $core.String? pkgName,
    $core.String? cmd,
    $core.String? arg,
  }) {
    final _result = create();
    if (pkgName != null) {
      _result.pkgName = pkgName;
    }
    if (cmd != null) {
      _result.cmd = cmd;
    }
    if (arg != null) {
      _result.arg = arg;
    }
    return _result;
  }
  factory AppControlReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AppControlReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AppControlReq clone() => AppControlReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AppControlReq copyWith(void Function(AppControlReq) updates) => super.copyWith((message) => updates(message as AppControlReq)) as AppControlReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AppControlReq create() => AppControlReq._();
  AppControlReq createEmptyInstance() => create();
  static $pb.PbList<AppControlReq> createRepeated() => $pb.PbList<AppControlReq>();
  @$core.pragma('dart2js:noInline')
  static AppControlReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AppControlReq>(create);
  static AppControlReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get pkgName => $_getSZ(0);
  @$pb.TagNumber(1)
  set pkgName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPkgName() => $_has(0);
  @$pb.TagNumber(1)
  void clearPkgName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get cmd => $_getSZ(1);
  @$pb.TagNumber(2)
  set cmd($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCmd() => $_has(1);
  @$pb.TagNumber(2)
  void clearCmd() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get arg => $_getSZ(2);
  @$pb.TagNumber(3)
  set arg($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasArg() => $_has(2);
  @$pb.TagNumber(3)
  void clearArg() => clearField(3);
}

class AppControlResp extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AppControlResp', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'app_manager'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pkgName')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..hasRequiredFields = false
  ;

  AppControlResp._() : super();
  factory AppControlResp({
    $core.String? pkgName,
    $core.String? status,
  }) {
    final _result = create();
    if (pkgName != null) {
      _result.pkgName = pkgName;
    }
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory AppControlResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AppControlResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AppControlResp clone() => AppControlResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AppControlResp copyWith(void Function(AppControlResp) updates) => super.copyWith((message) => updates(message as AppControlResp)) as AppControlResp; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AppControlResp create() => AppControlResp._();
  AppControlResp createEmptyInstance() => create();
  static $pb.PbList<AppControlResp> createRepeated() => $pb.PbList<AppControlResp>();
  @$core.pragma('dart2js:noInline')
  static AppControlResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AppControlResp>(create);
  static AppControlResp? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get pkgName => $_getSZ(0);
  @$pb.TagNumber(1)
  set pkgName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPkgName() => $_has(0);
  @$pb.TagNumber(1)
  void clearPkgName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);
}

