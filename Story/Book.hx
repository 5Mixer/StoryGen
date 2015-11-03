package story;

import Sys;

class Book {

	var allCharacters:Array<story.entity.Person>;

	var optionsTaken:List<story.option.Option>; //A log of previosly taken options
	var options:Array<story.option.Option>;     //The options that are avaliable this turn

	public function new () {
		allCharacters = new Array<story.entity.Person>();
		options = new Array<story.option.Option>();
		optionsTaken = new List<story.option.Option>();
	}

	public function makeStory (){
		trace('\n --Story Creator Begun --\n\n');
		generateCharacters();

		turn();
	}

	public function generateCharacters (num:Int = 1) {
		for (i in 0...num){
			allCharacters.push(story.util.RandomPerson.get());
		}

		for (char in allCharacters){
			trace("{ Name: "+char.name+", Age: "+char.age+", Gender: "+char.gender+" }; \n");
		}
		trace('\n');
	}

	public function turn () {
		//Called repeatedly to generate new sentences. First method really called.
		//Gathers options to be acted on later.

		options = new Array<story.option.Option>(); //TODO: Optimize clearing of Array

		for (char in allCharacters){
			char.makeOptions (options); //Tell every character to give us some options for our next sentence/turn
			char.emotionManager.getStrongestEmotion();
		}

		//Reduce likelyhood of repeating setence types.
		for (option in options){
			//if (Type.getClass(option) == Type.getClass(optionsTaken.last())) option.score-=1;

			for (pastOption in optionsTaken){
				if (Type.getClass(option) == Type.getClass(pastOption) && option.focus == pastOption.focus) options.remove(option);//.score -= 3;
			}
		}

		//Decide on best option
		var optionsAvaliable = decideOption().length;
		var option = decideOption()[0];
		var nextBestOption = decideOption()[1];

		var output:String;

		if (optionsAvaliable > 1 && option.focus == nextBestOption.focus && option.focus != null){
			var conjunction = new story.option.Conjunction(option,nextBestOption,', ');
			output = conjunction.onTake();

			//A conjunction should add all sentences to the log, but ignore they were in a conjunction
			optionsTaken.add(option);
			optionsTaken.add(nextBestOption);
		}else{
			output = option.onTake();
			optionsTaken.add(option); //We 'add' it to the end of this 'list', don't push it. (Pushing sets it as first element)

		}
		output = capitilise(output);
		output += ". ";
		trace(output);


		Sys.sleep(0.5);
		turn(); //Repeat
	}

	public function decideOption () {

		if (options[0] == null) throw("----WARNING: No options! Oh no!----");

		//Sort all of our options by how good they are.
		options.sort(function(a:story.option.Option,b:story.option.Option) {
		    if (a.score == b.score)
		        return 0;
		    if (a.score > b.score)
		        return -1;
		    else
		        return 1;
		});

		return options;
	}

	public function capitilise (str){
		//TODO: Move to language package
		var firstChar:String = str.substr(0, 1);
		var restOfString:String = str.substr(1, str.length);

		return firstChar.toUpperCase()+restOfString.toLowerCase();
	}

	/*public function removeOption (option) {
		var i = options.length;
		while (i-- > 0)
		   if (options[i] == option)
		      options.splice(i, 1);
	}*/ //This is BROKEN. Currently there is no way of comparing options, even with ID's,as they regenerate every turn.
}
