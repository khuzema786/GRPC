var PROTO_PATH = __dirname + '/chat.proto';

var prompt = require('prompt-sync')();
var _ = require('lodash');
var grpc = require('@grpc/grpc-js');
var protoLoader = require('@grpc/proto-loader');
var packageDefinition = protoLoader.loadSync(
  PROTO_PATH,
  {
    keepCase: true,
    longs: String,
    enums: String,
    defaults: true,
    oneofs: true
  });
var chat = grpc.loadPackageDefinition(packageDefinition).chat;
var client = new chat.Chat('localhost:50051',
  grpc.credentials.createInsecure());

threadId = process.argv[2];
threadIdId = process.argv[3];

console.log("ThreadId", threadId, threadIdId)
setInterval(() => {
  client.sendMsg({
    id : "",
    content: msg,
    timestamp: new Date().toTimeString()
  }, (err, response) => {
    console.log("Gaya", response)
  });
}, 10000)