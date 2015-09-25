package ;

import Sys;

class Output {
	//This class managers all output.
	public function new () {};

	public function print (text:Dynamic,?info:Dynamic){
		
		if (info.customParams == null){

			Sys.println(text);

		}else{

			if (info.customParams[0] == "Yell"){
				Sys.println(text.toUpperCase());
			}

		}
	}
}