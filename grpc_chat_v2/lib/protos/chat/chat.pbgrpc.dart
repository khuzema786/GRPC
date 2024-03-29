///
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'chat.pb.dart' as $0;
import 'google/protobuf/empty.pb.dart' as $1;
export 'chat.pb.dart';

class ChatServiceClient extends $grpc.Client {
  static final _$send = $grpc.ClientMethod<$0.Message, $1.Empty>(
      '/chat.ChatService/Send',
      ($0.Message value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$subscribe = $grpc.ClientMethod<$1.Empty, $0.Message>(
      '/chat.ChatService/Subscribe',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Message.fromBuffer(value));

  ChatServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.Empty> send($0.Message request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$send, request, options: options);
  }

  $grpc.ResponseStream<$0.Message> subscribe($1.Empty request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$subscribe, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class ChatServiceBase extends $grpc.Service {
  $core.String get $name => 'chat.ChatService';

  ChatServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Message, $1.Empty>(
        'Send',
        send_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Message.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.Message>(
        'Subscribe',
        subscribe_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.Message value) => value.writeToBuffer()));
  }

  $async.Future<$1.Empty> send_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Message> request) async {
    return send(call, await request);
  }

  $async.Stream<$0.Message> subscribe_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Empty> request) async* {
    yield* subscribe(call, await request);
  }

  $async.Future<$1.Empty> send($grpc.ServiceCall call, $0.Message request);
  $async.Stream<$0.Message> subscribe($grpc.ServiceCall call, $1.Empty request);
}
