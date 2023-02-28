///
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use voidDescriptor instead')
const Void$json = const {
  '1': 'Void',
};

/// Descriptor for `Void`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List voidDescriptor = $convert.base64Decode('CgRWb2lk');
@$core.Deprecated('Use messageDescriptor instead')
const Message$json = const {
  '1': 'Message',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'content', '3': 2, '4': 1, '5': 9, '10': 'content'},
    const {'1': 'timestamp', '3': 3, '4': 1, '5': 9, '10': 'timestamp'},
  ],
};

/// Descriptor for `Message`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageDescriptor = $convert.base64Decode('CgdNZXNzYWdlEg4KAmlkGAEgASgJUgJpZBIYCgdjb250ZW50GAIgASgJUgdjb250ZW50EhwKCXRpbWVzdGFtcBgDIAEoCVIJdGltZXN0YW1w');
@$core.Deprecated('Use userDescriptor instead')
const User$json = const {
  '1': 'User',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode('CgRVc2VyEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1l');
@$core.Deprecated('Use connectDescriptor instead')
const Connect$json = const {
  '1': 'Connect',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.chat.User', '10': 'user'},
    const {'1': 'active', '3': 2, '4': 1, '5': 8, '10': 'active'},
  ],
};

/// Descriptor for `Connect`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectDescriptor = $convert.base64Decode('CgdDb25uZWN0Eh4KBHVzZXIYASABKAsyCi5jaGF0LlVzZXJSBHVzZXISFgoGYWN0aXZlGAIgASgIUgZhY3RpdmU=');
