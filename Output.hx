package ;

import Sys;

import neko.vm.Thread;

using StringTools;

class Output{

	var server:Server;

	private static var ansiColors:Map<String,String> = new Map();
	private static var textCodes:Map<String,String> = new Map();

	public static function name (name) return ansiColors['name']+name+ansiColors['default'];

	//This class managers all output.
	public function new () {

		//server = new Server(new sys.net.Host("localhost"),5000);

		ansiColors['black'] = '\033[0;30m';
		ansiColors['red'] = '\033[31m';
		ansiColors['green'] = '\033[32m';
		ansiColors['yellow'] = '\033[33m';
		ansiColors['blue'] = '\033[1;34m';
		ansiColors['magenta'] = '\033[1;35m';
		ansiColors['cyan'] = '\033[0;36m';
		ansiColors['grey'] = '\033[0;37m';
		ansiColors['white'] = '\033[1;37m';
		ansiColors['default'] = '\033[1;39m';

		// reuse it for quick lookups of colors to log levels
		ansiColors['debug'] = ansiColors['cyan'];
		ansiColors['info'] = ansiColors['white'];
		ansiColors['error'] = ansiColors['magenta'];
		ansiColors['assert'] = ansiColors['red'];
		ansiColors['default'] = ansiColors['default'];
		ansiColors['name'] = ansiColors['white'];

		//y textCodes['%n'] = ansiColors['name'];
	}

	public static function getPlainText (text:String){

		text = text.replace("%n%","");
		text = text.replace("%%","");
	}

	public function print (text:String,?info:Dynamic){
		var output = text;

		//output.split("%n%").join(ansiColors['name']);
		text = text.replace("%n%",ansiColors['name']);
		text = text.replace("%%",ansiColors['default']);


		if (info.customParams == null){

			Sys.print(text);
			//server.send(text);

		}else{

			if (info.customParams[0] == "Yell"){
				Sys.println(output.toUpperCase());
			}

		}
	}

	public function processString (text:String) {

	}
}
