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

const connections = {};
const disconnections = {};
const messages = {}

const sendNotification = (call, callback) => {
  for (const id in connections) {
    const connection = connections[id];
    connection.call.write(call.request);
    messages[id][call.request.id] = call.request;
  }

  for (const id in disconnections) {
    disconnections[id].data = [...disconnections[id].data, call.request]
    console.log(`Stored [${call.request.content}] to: [${disconnections[id].name}]`);
  }

  callback(null, {});
};

const listenNotifications = (call) => {
  call.on("data", (request) => {
    const messageId = request.messageId;
    const userId = request.id

    // Client acknowledgement to recieve message
    if(messageId) {
      const

      console.log(`Sent [${call.request.content}] to: [${connection.name}]`);
      delete messages[userId][messageId];
    }

    if(disconnections[call.metadata.internalRepr.get("client-id")[0]]) {
      console.log(`[${request.name}] is reconnected`)
      delete disconnections[call.metadata.internalRepr.get("client-id")[0]];
    } else {
      console.log(`[${request.name}] is connected`)
    }

    for (const id in messages[userId]) {
      call.write(messages[userId][id])
    }

    connections[userId] = {
      name: request.name,
      call: call,
    }
  })

  call.on("end", () => {
    if (call.metadata.internalRepr.has("client-id")) {
      delete connections[call.metadata.internalRepr.get("client-id")[0]];
      disconnections[call.metadata.internalRepr.get("client-id")[0]] = true;
    }
    if (call.metadata.internalRepr.has("client-name")) {
      console.log(`[${call.metadata.internalRepr.get("client-name")[0]}] is disconnected`);
    }
  })
};

function getServer() {
  var server = new grpc.Server();
  server.addService(notification.NotificationService.service, {
    sendNotification: sendNotification,
    listenNotifications: listenNotifications
  });
  return server;
}

const port = "5001"

var routeServer = getServer();
routeServer.bindAsync(`0.0.0.0:${port}`, grpc.ServerCredentials.createInsecure(), () => {
  routeServer.start();
  console.log(`Server started on port : ${port}`)
})
