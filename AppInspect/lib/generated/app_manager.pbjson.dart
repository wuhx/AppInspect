///
//  Generated code. Do not modify.
//  source: app_manager.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use requestApiDescriptor instead')
const RequestApi$json = const {
  '1': 'RequestApi',
  '2': const [
    const {'1': 'package_info_req', '3': 1, '4': 1, '5': 11, '6': '.app_manager.PackageInfoReq', '9': 0, '10': 'packageInfoReq'},
  ],
  '8': const [
    const {'1': 'req'},
  ],
};

/// Descriptor for `RequestApi`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestApiDescriptor = $convert.base64Decode('CgpSZXF1ZXN0QXBpEkcKEHBhY2thZ2VfaW5mb19yZXEYASABKAsyGy5hcHBfbWFuYWdlci5QYWNrYWdlSW5mb1JlcUgAUg5wYWNrYWdlSW5mb1JlcUIFCgNyZXE=');
@$core.Deprecated('Use packageInfoReqDescriptor instead')
const PackageInfoReq$json = const {
  '1': 'PackageInfoReq',
  '2': const [
    const {'1': 'not_system_app', '3': 1, '4': 1, '5': 8, '10': 'notSystemApp'},
    const {'1': 'selected_package_list', '3': 2, '4': 3, '5': 9, '10': 'selectedPackageList'},
    const {'1': 'quick', '3': 3, '4': 1, '5': 8, '10': 'quick'},
  ],
};

/// Descriptor for `PackageInfoReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List packageInfoReqDescriptor = $convert.base64Decode('Cg5QYWNrYWdlSW5mb1JlcRIkCg5ub3Rfc3lzdGVtX2FwcBgBIAEoCFIMbm90U3lzdGVtQXBwEjIKFXNlbGVjdGVkX3BhY2thZ2VfbGlzdBgCIAMoCVITc2VsZWN0ZWRQYWNrYWdlTGlzdBIUCgVxdWljaxgDIAEoCFIFcXVpY2s=');
@$core.Deprecated('Use packageInfoDescriptor instead')
const PackageInfo$json = const {
  '1': 'PackageInfo',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'pkg_name', '3': 2, '4': 1, '5': 9, '10': 'pkgName'},
    const {'1': 'icon', '3': 3, '4': 1, '5': 12, '10': 'icon'},
    const {'1': 'uid', '3': 4, '4': 1, '5': 5, '10': 'uid'},
    const {'1': 'processName', '3': 5, '4': 1, '5': 9, '10': 'processName'},
    const {'1': 'firstInstallTime', '3': 6, '4': 1, '5': 3, '10': 'firstInstallTime'},
    const {'1': 'lastUpdateTime', '3': 7, '4': 1, '5': 3, '10': 'lastUpdateTime'},
    const {'1': 'sourceDir', '3': 8, '4': 1, '5': 9, '10': 'sourceDir'},
    const {'1': 'dataDir', '3': 9, '4': 1, '5': 9, '10': 'dataDir'},
    const {'1': 'minSdkVersion', '3': 10, '4': 1, '5': 5, '10': 'minSdkVersion'},
    const {'1': 'targetSdkVersion', '3': 11, '4': 1, '5': 5, '10': 'targetSdkVersion'},
    const {'1': 'compileSdkVersion', '3': 12, '4': 1, '5': 5, '10': 'compileSdkVersion'},
    const {'1': 'running', '3': 20, '4': 1, '5': 8, '10': 'running'},
    const {'1': 'hiding', '3': 21, '4': 1, '5': 8, '10': 'hiding'},
  ],
};

/// Descriptor for `PackageInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List packageInfoDescriptor = $convert.base64Decode('CgtQYWNrYWdlSW5mbxISCgRuYW1lGAEgASgJUgRuYW1lEhkKCHBrZ19uYW1lGAIgASgJUgdwa2dOYW1lEhIKBGljb24YAyABKAxSBGljb24SEAoDdWlkGAQgASgFUgN1aWQSIAoLcHJvY2Vzc05hbWUYBSABKAlSC3Byb2Nlc3NOYW1lEioKEGZpcnN0SW5zdGFsbFRpbWUYBiABKANSEGZpcnN0SW5zdGFsbFRpbWUSJgoObGFzdFVwZGF0ZVRpbWUYByABKANSDmxhc3RVcGRhdGVUaW1lEhwKCXNvdXJjZURpchgIIAEoCVIJc291cmNlRGlyEhgKB2RhdGFEaXIYCSABKAlSB2RhdGFEaXISJAoNbWluU2RrVmVyc2lvbhgKIAEoBVINbWluU2RrVmVyc2lvbhIqChB0YXJnZXRTZGtWZXJzaW9uGAsgASgFUhB0YXJnZXRTZGtWZXJzaW9uEiwKEWNvbXBpbGVTZGtWZXJzaW9uGAwgASgFUhFjb21waWxlU2RrVmVyc2lvbhIYCgdydW5uaW5nGBQgASgIUgdydW5uaW5nEhYKBmhpZGluZxgVIAEoCFIGaGlkaW5n');
@$core.Deprecated('Use packageInfoListDescriptor instead')
const PackageInfoList$json = const {
  '1': 'PackageInfoList',
  '2': const [
    const {'1': 'pkg_info_list', '3': 1, '4': 3, '5': 11, '6': '.app_manager.PackageInfo', '10': 'pkgInfoList'},
  ],
};

/// Descriptor for `PackageInfoList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List packageInfoListDescriptor = $convert.base64Decode('Cg9QYWNrYWdlSW5mb0xpc3QSPAoNcGtnX2luZm9fbGlzdBgBIAMoCzIYLmFwcF9tYW5hZ2VyLlBhY2thZ2VJbmZvUgtwa2dJbmZvTGlzdA==');
@$core.Deprecated('Use appControlReqDescriptor instead')
const AppControlReq$json = const {
  '1': 'AppControlReq',
  '2': const [
    const {'1': 'pkg_name', '3': 1, '4': 1, '5': 9, '10': 'pkgName'},
    const {'1': 'cmd', '3': 2, '4': 1, '5': 9, '10': 'cmd'},
    const {'1': 'arg', '3': 3, '4': 1, '5': 9, '10': 'arg'},
  ],
};

/// Descriptor for `AppControlReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List appControlReqDescriptor = $convert.base64Decode('Cg1BcHBDb250cm9sUmVxEhkKCHBrZ19uYW1lGAEgASgJUgdwa2dOYW1lEhAKA2NtZBgCIAEoCVIDY21kEhAKA2FyZxgDIAEoCVIDYXJn');
@$core.Deprecated('Use appControlRespDescriptor instead')
const AppControlResp$json = const {
  '1': 'AppControlResp',
  '2': const [
    const {'1': 'pkg_name', '3': 1, '4': 1, '5': 9, '10': 'pkgName'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `AppControlResp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List appControlRespDescriptor = $convert.base64Decode('Cg5BcHBDb250cm9sUmVzcBIZCghwa2dfbmFtZRgBIAEoCVIHcGtnTmFtZRIWCgZzdGF0dXMYAiABKAlSBnN0YXR1cw==');
