package ;

import neko.net.WebSocketServerLoop;
//import sys.net.Host;

class ConnectionData extends WebSocketServerLoop.ClientData {
    public function new (socket) {
        super(socket);
        socket.setBlocking(false);

    }
}
/*
class Server
{
    var connections:Array<ConnectionData> = new Array<ConnectionData>();

    public function new(host:sys.net.Host,port:Int)
    {
        var serverLoop = new WebSocketServerLoop<ConnectionData>(function(socket) return new ConnectionData(socket));

        serverLoop.processIncomingMessage = function(data:ConnectionData, message:String)
        {
            trace("Recieved: "+message);
            connections.push(data);
            //use may use data.ws to send answer/close connection
        };

        serverLoop.run(host,port);

    }

    public function send (msg:String){

        for (conn in connections){
            conn.ws.send(msg);
        }
    }
}*/
