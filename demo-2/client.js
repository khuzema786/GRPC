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
var client = new chat.Chat('0.tcp.in.ngrok.io:16353', grpc.ChannelCredentials.createInsecure());

const main = () => {
    var msg = prompt("> ")
    if(msg === ":q") return;
    client.sendMsg({
      id : "123ddsd",
      content: msg,
      timestamp: new Date().toTimeString()
    }, (err, response) => {
      if (err) console.log(err)
      else main();
    });
}

main()