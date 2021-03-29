import ballerina/log;
import ballerinax/mongodb;

configurable string host = ?;
configurable int port = ?;
configurable string username = ?;
configurable string password = ?;
configurable string database = ?;
configurable string collection = ?;

public function main() {
    
    mongodb:ClientConfig mongoConfig = {
        host: host,
        port: port,
        username: username,
        password: password,
        options: {sslEnabled: false, serverSelectionTimeout: 5000}
    };

    mongodb:Client mongoClient = checkpanic new (mongoConfig);

    log:print("------------------ List Indicies -------------------");
    map<json>[] indicies = checkpanic mongoClient->listIndices(database, collection);
    foreach var index in indicies {
        log:print(index.toString());
    }
    
    mongoClient->close();
}
