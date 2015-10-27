package ;

import Sys;

import neko.vm.Thread;

class Output{
	
	var server:Server;

	//This class managers all output.
	public function new () {
		
		//server = new Server(new sys.net.Host("localhost"),5000);
	};


	public function print (text:Dynamic,?info:Dynamic){

		if (info.customParams == null){

			Sys.print(text);
			//server.send(text);

		}else{

			if (info.customParams[0] == "Yell"){
				Sys.println(text.toUpperCase());
			}

		}
	}
}