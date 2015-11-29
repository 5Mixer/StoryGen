package story.option;

import story.Book;

//Instances of this class should be stored in variables like
//futureOptions, as they should last longer than one 'page turn'

class TemporaryOption extends Option {
	var remainingPageFlips:Int; //Not really a page flip, but whenever an option is taken.

	public function new (totalSentances) {
		super();
		remainingPageFlips = totalSentances;

		Book.onAnyOptionFinish.add(onAnyOptionFinish);
	}

	public function onTurn (){
		destroy(); // Don't allow for a temporary option to repeat.
	}

	public function onAnyOptionFinish (option){
		remainingPageFlips--;
		if (remainingPageFlips == 0){
			 destroy();
		 }
	}

	dynamic public function destroy (){
		throw (" --- THIS DESTROY FUNCTION SHOULD HAVE BEEN OVERRIDDEN, TO REMOVE IT FROM LISTS --- ");
	}
}
