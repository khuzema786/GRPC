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
export 'chat.pb.dart';

class ChatClient extends $grpc.Client {
  static final _$sendMsg = $grpc.ClientMethod<$0.Message, $0.Void>(
      '/chat.Chat/SendMsg',
      ($0.Message value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Void.fromBuffer(value));
  static final _$recieveMsg = $grpc.ClientMethod<$0.Connect, $0.Message>(
      '/chat.Chat/RecieveMsg',
      ($0.Connect value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Message.fromBuffer(value));

  ChatClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Void> sendMsg($0.Message request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendMsg, request, options: options);
  }

  $grpc.ResponseStream<$0.Message> recieveMsg($0.Connect request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$recieveMsg, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class ChatServiceBase extends $grpc.Service {
  $core.String get $name => 'chat.Chat';

  ChatServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Message, $0.Void>(
        'SendMsg',
        sendMsg_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Message.fromBuffer(value),
        ($0.Void value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Connect, $0.Message>(
        'RecieveMsg',
        recieveMsg_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Connect.fromBuffer(value),
        ($0.Message value) => value.writeToBuffer()));
  }

  $async.Future<$0.Void> sendMsg_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Message> request) async {
    return sendMsg(call, await request);
  }

  $async.Stream<$0.Message> recieveMsg_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Connect> request) async* {
    yield* recieveMsg(call, await request);
  }

  $async.Future<$0.Void> sendMsg($grpc.ServiceCall call, $0.Message request);
  $async.Stream<$0.Message> recieveMsg(
      $grpc.ServiceCall call, $0.Connect request);
}
