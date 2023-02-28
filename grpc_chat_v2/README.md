# grpc_chat_v2

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

https://medium.com/flutter-community/tutorial-asynchronous-flutter-chat-client-with-go-chat-server-which-are-powered-by-grpc-simple-ce913066861c

```
❯ protoc --dart_out=grpc:/Users/khuzemakhomosi/Documents/grpc_chat_v2/lib/protos --proto_path=/Users/khuzemakhomosi/Documents/grpc_chat_v2/lib/protos /Users/khuzemakhomosi/Documents/grpc_chat_v2/lib/protos/chat.proto
❯ protoc --dart_out=grpc:/Users/khuzemakhomosi/Documents/grpc_chat_v2/lib/protos/chat --proto_path=/Users/khuzemakhomosi/Documents/grpc_chat_v2/lib/protos/chat /Users/khuzemakhomosi/Documents/grpc_chat_v2/lib/protos/chat/chat.proto
❯ protoc --dart_out=grpc:/Users/khuzemakhomosi/Documents/grpc_chat_v2/lib/protos/chat/google/protobuf --proto_path=/Users/khuzemakhomosi/Documents/grpc_chat_v2/lib/protos/chat/google/protobuf /Users/khuzemakhomosi/Documents/grpc_chat_v2/lib/protos/chat/google/protobuf/empty.proto
❯ protoc --dart_out=grpc:/Users/khuzemakhomosi/Documents/grpc_chat_v2/lib/protos/chat/google/protobuf --proto_path=/Users/khuzemakhomosi/Documents/grpc_chat_v2/lib/protos/chat/google/protobuf /Users/khuzemakhomosi/Documents/grpc_chat_v2/lib/protos/chat/google/protobuf/timestamp.proto
❯ protoc --dart_out=grpc:/Users/khuzemakhomosi/Documents/grpc_chat_v2/lib/protos/chat/google/protobuf --proto_path=/Users/khuzemakhomosi/Documents/grpc_chat_v2/lib/protos/chat/google/protobuf /Users/khuzemakhomosi/Documents/grpc_chat_v2/lib/protos/chat/google/protobuf/wrappers.proto
```