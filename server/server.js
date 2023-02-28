var PROTO_PATH = __dirname + '/chat.proto';

var grpc = require('@grpc/grpc-js');
var protoLoader = require('@grpc/proto-loader');
var packageDefinition = protoLoader.loadSync(
    PROTO_PATH,
    {keepCase: true,
     longs: String,
     enums: String,
     defaults: true,
     oneofs: true
    });
var chat = grpc.loadPackageDefinition(packageDefinition).chat;

const observers = {};

const send = (call, callback) => {
    observers.forEach((observer) => {
      observer.call.write(call.request);
    });
    callback(null, {});
  };

const subscribe = (call, callback) => {
  observers.push({
    call,
  });
};

function getServer() {
  var server = new grpc.Server();
  server.addService(chat.ChatService.service, {
    send: send,
    subscribe: subscribe
  });
  return server;
}

const port = "5001"

if (require.main === module) {
  var routeServer = getServer();
  routeServer.bindAsync(`0.0.0.0:${port}`, grpc.ServerCredentials.createInsecure(), () => {
    routeServer.start();
    console.log(`Server started on port : ${port}`)
  })
}

exports.getServer = getServer;
