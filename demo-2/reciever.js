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

var recieveCall = client.recieveMsg({
  user : {
    id : "",
    name : "Khuzema"
  },
  active : true
});

recieveCall.on("data", function (data) {
  console.log(`Got message from ${data.id} : ${data.content} on ${data.timestamp}`);
})