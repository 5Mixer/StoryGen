
websocket = new WebSocket('ws://localhost:5000');
websocket.onopen = onOpen;
websocket.onclose = onClose;
websocket.onmessage = onMessage;
websocket.onerror = onError;

function onOpen(evt)
{
	websocket.send('message');
}

function onClose(evt)
{
}

function onMessage(evt)
{
	if (evt.data == 'OK'){

	}
	console.log('Recieved: '+evt.data);

}

function onError(evt)
{

	websocket.close();
}