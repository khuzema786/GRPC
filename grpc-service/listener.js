var PROTO_PATH = __dirname + '/notification.proto';

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
let client = new notification.NotificationService('0.tcp.in.ngrok.io:18160',
    grpc.credentials.createInsecure());

const main = async () => {
    const { createHmac } = await import('node:crypto');

    var metadata = new grpc.Metadata();
    metadata.add('client-id', createHmac('sha256', "secret")
        .update(process.argv[2])
        .digest('hex'));
    metadata.add('client-name', process.argv[2]);

    if (!client) {
        client = new notification.NotificationService('0.tcp.in.ngrok.io:18160', grpc.ChannelCredentials.createInsecure());
    }

    var call = client.listenNotifications(metadata)

    call.write({
        id: createHmac('sha256', "secret")
            .update(process.argv[2])
            .digest('hex'),
        name: process.argv[2]
    });

    call.on("data", function (response) {
        console.log(`[Message] : ${response.id} :\n${response.content} on ${response.timestamp}`);
        call.write({
            id: createHmac('sha256', "secret")
                .update(process.argv[2])
                .digest('hex'),
            name: process.argv[2],
            messageId: response.id
        });
    })

    call.on('error', function (e) {
        console.log(`[Error] : ${e}`);
        client = null;
        main();
    });
}

main()