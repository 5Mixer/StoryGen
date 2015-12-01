package story.language;

class Capitilise {
	public static function capitilise (str){
		//TODO: Move to language package
		var firstChar:String = str.substr(0, 1);
		var restOfString:String = str.substr(1, str.length);
		return firstChar.toUpperCase()+restOfString.toLowerCase();
	}
}
