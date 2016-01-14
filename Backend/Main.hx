package ;

import Output;
import story.Book;

class Main{
	static function main () {
		var output = new Output();
		haxe.Log.trace = output.print;

		var book = new Book ();
		var outputText = book.makeStory();
		trace(outputText);

	}
}
