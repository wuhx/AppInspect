///
//  Generated code. Do not modify.
//  source: android_manager.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use hookListModulesReqDescriptor instead')
const HookListModulesReq$json = const {
  '1': 'HookListModulesReq',
  '2': const [
    const {'1': 'pkg_name', '3': 1, '4': 1, '5': 9, '10': 'pkgName'},
  ],
};

/// Descriptor for `HookListModulesReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hookListModulesReqDescriptor = $convert.base64Decode('ChJIb29rTGlzdE1vZHVsZXNSZXESGQoIcGtnX25hbWUYASABKAlSB3BrZ05hbWU=');
@$core.Deprecated('Use moduleInfoDescriptor instead')
const ModuleInfo$json = const {
  '1': 'ModuleInfo',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'path', '3': 2, '4': 1, '5': 9, '10': 'path'},
    const {'1': 'base_addr', '3': 3, '4': 1, '5': 4, '10': 'baseAddr'},
    const {'1': 'size', '3': 4, '4': 1, '5': 4, '10': 'size'},
  ],
};

/// Descriptor for `ModuleInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moduleInfoDescriptor = $convert.base64Decode('CgpNb2R1bGVJbmZvEhIKBG5hbWUYASABKAlSBG5hbWUSEgoEcGF0aBgCIAEoCVIEcGF0aBIbCgliYXNlX2FkZHIYAyABKARSCGJhc2VBZGRyEhIKBHNpemUYBCABKARSBHNpemU=');
@$core.Deprecated('Use hookListModulesRespDescriptor instead')
const HookListModulesResp$json = const {
  '1': 'HookListModulesResp',
  '2': const [
    const {'1': 'modules', '3': 1, '4': 3, '5': 11, '6': '.android_manager.ModuleInfo', '10': 'modules'},
  ],
};

/// Descriptor for `HookListModulesResp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hookListModulesRespDescriptor = $convert.base64Decode('ChNIb29rTGlzdE1vZHVsZXNSZXNwEjUKB21vZHVsZXMYASADKAsyGy5hbmRyb2lkX21hbmFnZXIuTW9kdWxlSW5mb1IHbW9kdWxlcw==');
@$core.Deprecated('Use hookListSymbolsReqDescriptor instead')
const HookListSymbolsReq$json = const {
  '1': 'HookListSymbolsReq',
  '2': const [
    const {'1': 'module_name', '3': 1, '4': 1, '5': 9, '10': 'moduleName'},
  ],
};

/// Descriptor for `HookListSymbolsReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hookListSymbolsReqDescriptor = $convert.base64Decode('ChJIb29rTGlzdFN5bWJvbHNSZXESHwoLbW9kdWxlX25hbWUYASABKAlSCm1vZHVsZU5hbWU=');
@$core.Deprecated('Use hookSymbolInfoDescriptor instead')
const HookSymbolInfo$json = const {
  '1': 'HookSymbolInfo',
  '2': const [
    const {'1': 'module_name', '3': 1, '4': 1, '5': 9, '10': 'moduleName'},
    const {'1': 'symbol_name', '3': 2, '4': 1, '5': 9, '10': 'symbolName'},
    const {'1': 'address', '3': 3, '4': 1, '5': 4, '10': 'address'},
    const {'1': 'size', '3': 4, '4': 1, '5': 4, '10': 'size'},
  ],
};

/// Descriptor for `HookSymbolInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hookSymbolInfoDescriptor = $convert.base64Decode('Cg5Ib29rU3ltYm9sSW5mbxIfCgttb2R1bGVfbmFtZRgBIAEoCVIKbW9kdWxlTmFtZRIfCgtzeW1ib2xfbmFtZRgCIAEoCVIKc3ltYm9sTmFtZRIYCgdhZGRyZXNzGAMgASgEUgdhZGRyZXNzEhIKBHNpemUYBCABKARSBHNpemU=');
@$core.Deprecated('Use hookListSymbolsRespDescriptor instead')
const HookListSymbolsResp$json = const {
  '1': 'HookListSymbolsResp',
  '2': const [
    const {'1': 'symbols', '3': 1, '4': 3, '5': 11, '6': '.android_manager.HookSymbolInfo', '10': 'symbols'},
  ],
};

/// Descriptor for `HookListSymbolsResp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hookListSymbolsRespDescriptor = $convert.base64Decode('ChNIb29rTGlzdFN5bWJvbHNSZXNwEjkKB3N5bWJvbHMYASADKAsyHy5hbmRyb2lkX21hbmFnZXIuSG9va1N5bWJvbEluZm9SB3N5bWJvbHM=');
@$core.Deprecated('Use hookArgDescriptor instead')
const HookArg$json = const {
  '1': 'HookArg',
  '2': const [
    const {'1': 'arg_index', '3': 1, '4': 1, '5': 5, '10': 'argIndex'},
    const {'1': 'arg_Name', '3': 2, '4': 1, '5': 9, '10': 'argName'},
    const {'1': 'arg_type', '3': 3, '4': 1, '5': 9, '10': 'argType'},
    const {'1': 'hooked', '3': 4, '4': 1, '5': 8, '10': 'hooked'},
  ],
};

/// Descriptor for `HookArg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hookArgDescriptor = $convert.base64Decode('CgdIb29rQXJnEhsKCWFyZ19pbmRleBgBIAEoBVIIYXJnSW5kZXgSGQoIYXJnX05hbWUYAiABKAlSB2FyZ05hbWUSGQoIYXJnX3R5cGUYAyABKAlSB2FyZ1R5cGUSFgoGaG9va2VkGAQgASgIUgZob29rZWQ=');
@$core.Deprecated('Use hookInfoDescriptor instead')
const HookInfo$json = const {
  '1': 'HookInfo',
  '2': const [
    const {'1': 'module_name', '3': 1, '4': 1, '5': 9, '10': 'moduleName'},
    const {'1': 'symbol_name', '3': 2, '4': 1, '5': 9, '10': 'symbolName'},
    const {'1': 'args', '3': 3, '4': 3, '5': 11, '6': '.android_manager.HookArg', '10': 'args'},
  ],
};

/// Descriptor for `HookInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hookInfoDescriptor = $convert.base64Decode('CghIb29rSW5mbxIfCgttb2R1bGVfbmFtZRgBIAEoCVIKbW9kdWxlTmFtZRIfCgtzeW1ib2xfbmFtZRgCIAEoCVIKc3ltYm9sTmFtZRIsCgRhcmdzGAMgAygLMhguYW5kcm9pZF9tYW5hZ2VyLkhvb2tBcmdSBGFyZ3M=');
@$core.Deprecated('Use hookInfoAddReqDescriptor instead')
const HookInfoAddReq$json = const {
  '1': 'HookInfoAddReq',
  '2': const [
    const {'1': 'info', '3': 1, '4': 1, '5': 11, '6': '.android_manager.HookInfo', '10': 'info'},
  ],
};

/// Descriptor for `HookInfoAddReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hookInfoAddReqDescriptor = $convert.base64Decode('Cg5Ib29rSW5mb0FkZFJlcRItCgRpbmZvGAEgASgLMhkuYW5kcm9pZF9tYW5hZ2VyLkhvb2tJbmZvUgRpbmZv');
@$core.Deprecated('Use hookInfoAddRespDescriptor instead')
const HookInfoAddResp$json = const {
  '1': 'HookInfoAddResp',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 5, '10': 'status'},
  ],
};

/// Descriptor for `HookInfoAddResp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hookInfoAddRespDescriptor = $convert.base64Decode('Cg9Ib29rSW5mb0FkZFJlc3ASFgoGc3RhdHVzGAEgASgFUgZzdGF0dXM=');
@$core.Deprecated('Use hookInfoListReqDescriptor instead')
const HookInfoListReq$json = const {
  '1': 'HookInfoListReq',
};

/// Descriptor for `HookInfoListReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hookInfoListReqDescriptor = $convert.base64Decode('Cg9Ib29rSW5mb0xpc3RSZXE=');
@$core.Deprecated('Use hookInfoListRespDescriptor instead')
const HookInfoListResp$json = const {
  '1': 'HookInfoListResp',
  '2': const [
    const {'1': 'hooks', '3': 1, '4': 3, '5': 11, '6': '.android_manager.HookInfo', '10': 'hooks'},
  ],
};

/// Descriptor for `HookInfoListResp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hookInfoListRespDescriptor = $convert.base64Decode('ChBIb29rSW5mb0xpc3RSZXNwEi8KBWhvb2tzGAEgAygLMhkuYW5kcm9pZF9tYW5hZ2VyLkhvb2tJbmZvUgVob29rcw==');
@$core.Deprecated('Use hookServerExitReqDescriptor instead')
const HookServerExitReq$json = const {
  '1': 'HookServerExitReq',
  '2': const [
    const {'1': 'newPkgName', '3': 1, '4': 1, '5': 9, '10': 'newPkgName'},
  ],
};

/// Descriptor for `HookServerExitReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hookServerExitReqDescriptor = $convert.base64Decode('ChFIb29rU2VydmVyRXhpdFJlcRIeCgpuZXdQa2dOYW1lGAEgASgJUgpuZXdQa2dOYW1l');
@$core.Deprecated('Use hookServerExitRespDescriptor instead')
const HookServerExitResp$json = const {
  '1': 'HookServerExitResp',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 9, '10': 'result'},
  ],
};

/// Descriptor for `HookServerExitResp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hookServerExitRespDescriptor = $convert.base64Decode('ChJIb29rU2VydmVyRXhpdFJlc3ASFgoGcmVzdWx0GAEgASgJUgZyZXN1bHQ=');
@$core.Deprecated('Use hookDumpMemRangeReqDescriptor instead')
const HookDumpMemRangeReq$json = const {
  '1': 'HookDumpMemRangeReq',
  '2': const [
    const {'1': 'start', '3': 1, '4': 1, '5': 4, '10': 'start'},
    const {'1': 'end', '3': 2, '4': 1, '5': 4, '10': 'end'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `HookDumpMemRangeReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hookDumpMemRangeReqDescriptor = $convert.base64Decode('ChNIb29rRHVtcE1lbVJhbmdlUmVxEhQKBXN0YXJ0GAEgASgEUgVzdGFydBIQCgNlbmQYAiABKARSA2VuZBISCgRuYW1lGAMgASgJUgRuYW1l');
@$core.Deprecated('Use hookDumpMemRangeRespDescriptor instead')
const HookDumpMemRangeResp$json = const {
  '1': 'HookDumpMemRangeResp',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 5, '10': 'status'},
    const {'1': 'dumpFileOnDevice', '3': 2, '4': 1, '5': 9, '10': 'dumpFileOnDevice'},
  ],
};

/// Descriptor for `HookDumpMemRangeResp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hookDumpMemRangeRespDescriptor = $convert.base64Decode('ChRIb29rRHVtcE1lbVJhbmdlUmVzcBIWCgZzdGF0dXMYASABKAVSBnN0YXR1cxIqChBkdW1wRmlsZU9uRGV2aWNlGAIgASgJUhBkdW1wRmlsZU9uRGV2aWNl');
