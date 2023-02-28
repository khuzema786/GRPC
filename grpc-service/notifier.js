var PROTO_PATH = __dirname + '/notification.proto';

var prompt = require('prompt-sync')();
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
var notification = grpc.loadPackageDefinition(packageDefinition).notification;
let client = new notification.NotificationService('0.tcp.in.ngrok.io:18160', grpc.ChannelCredentials.createInsecure());

let counter = 0;

const sendNotification = async (counter, msg) => {
    const { createHmac } = await import('node:crypto');

    if (!client) {
        client = new notification.NotificationService('0.tcp.in.ngrok.io:18160', grpc.ChannelCredentials.createInsecure());
    }

    client.sendNotification({
        id: createHmac('sha256', "secret")
            .update(counter.toString())
            .digest('hex'),
        content: msg,
        timestamp: new Date().toTimeString(),
        validity: 30000
    }, (err, response) => {
        if (err) {
            console.log(`[Error] : ${err}`);
            client = null;
            sendNotification(counter, msg)
        }
        else main();
    });
}

const main = async () => {
    var msg = prompt("> ")
    if (msg === ":q") return;

    sendNotification(counter++, msg)
}

main();