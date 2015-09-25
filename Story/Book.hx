package story;

import Sys;

class Book {

	var allCharacters:Array<story.entity.Person>;

	var options:Array<story.option.Option>;

	public function new () {
		allCharacters = new Array<story.entity.Person>();
		options = new Array<story.option.Option>();
	}

	public function makeStory (){
		generateCharacters();

		turn();
	}

	public function generateCharacters (num:Int = 10) {
		for (i in 1...num){
			allCharacters.push(story.util.RandomPerson.get());
		}

		for (char in allCharacters){
			trace("{ Name: "+char.name+", Age: "+char.age+", Gender: "+char.gender+" }; ");
		}
	}

	public function turn () {
		//Called repeatedly to generate new sentences. First method really called.
		//Gathers options to be acted on later.

		options = new Array<story.option.Option>(); //TODO: Optimize clearing of Array

		for (char in allCharacters){
			char.makeOptions (options); //Tell every character to give us some options for our next sentence/turn
		}
		//Decide on best option
		var option = decideOption();
		option.onTake();
		Sys.sleep(1);
		turn();
	}

	public function decideOption () {
		//Sort all of our options by how good they are.
		options.sort(function(a:story.option.Option,b:story.option.Option) {
		    if (a.score == b.score)
		        return 0;
		    if (a.score > b.score)
		        return 1;
		    else
		        return -1;
		});
		if (options[0] == null) trace("----WARNING: No options! Oh no!----");
		return options[0];
	}
}
