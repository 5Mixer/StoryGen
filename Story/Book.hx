package story;

import Sys;
import ComplexString;

class Book {

	var allCharacters:Array<story.entity.Person>;
	var allLocations:Array<story.location.Location>;

	var optionsTaken:List<story.option.Option>; //A log of previosly taken options
	var options:Array<story.option.Option>;     //The options that are avaliable this turn

	var mainCharacter:story.entity.Person;

	public function new () {
		allCharacters = new Array<story.entity.Person>();
		allLocations = new Array<story.location.Location>();
		options = new Array<story.option.Option>();
		optionsTaken = new List<story.option.Option>();
	}

	public function makeStory (){
		trace('\n --Story Creator Begun --\n\n');
		generateLocations();

		mainCharacter = story.util.RandomPerson.get();
		//Because it is in this location, it wil be automagically added to 'allCharacters'
		mainCharacter.location = allLocations[0];
		allLocations[0].characters.push(mainCharacter);

		//Add all locations characters to 'allLocations'
		for (place in allLocations)
			for (person in place.characters)
				allCharacters.push(person);


		//Give a reading of 'allCharacters'
		for (char in allCharacters){
			trace("{ Name: "+char.name+", Age: "+char.age+", Gender: "+char.gender+", Location: "+char.location.name+" }; \n");
		}

		turn();
	}

	public function generateLocations () {
		var genericRoom:story.location.Location = new story.location.Location();
		genericRoom.name = "room";
		genericRoom.adjectives = ["large","empty","white","plain"];
		genericRoom.generateCharacters(5);
		allLocations.push(genericRoom);

		var butcher:story.location.Location = new story.location.Location();
		butcher.name = "butcher";
		butcher.adjectives = ["busy","small","pink","smelly"];
		butcher.generateCharacters(5);
		allLocations.push(butcher);

		genericRoom.accessibleLocations.push(butcher);

		butcher.accessibleLocations.push(genericRoom);
	}



	public function turn () {
		//Called repeatedly to generate new sentences. First method really called.
		//Gathers options to be acted on later.

		options = new Array<story.option.Option>(); //TODO: Optimize clearing of Array

		/* UNCOMMENT IF NO MAIN CHARACTER
		for (char in allCharacters){
			char.makeOptions (options); //Tell every character to give us some options for our next sentence/turn
			char.emotionManager.getStrongestEmotion();

		}
		*/
		for (char in mainCharacter.location.characters){
			char.makeOptions(options);
		}

		//Reduce likelyhood ofuoi repeating setence types.

		var optionsLength = options.length;

		for (i in 0...optionsLength+1){
			//if (Type.getClass(option) == Type.getClass(optionsTaken.last())) option.score-=1;
			var option = options[optionsLength-i];

			for (pastOption in optionsTaken){

				if (Type.getClass(option) == Type.getClass(pastOption) && option.focus == pastOption.focus){

					//trace("\n\n\nAvaliable option of type " + Type.getClassName(Type.getClass(option)) + " and focus of "+option.focus.name);
					//trace("\nPast option of type " + Type.getClassName(Type.getClass(pastOption)) + " and focus of "+pastOption.focus.name);

					//options.splice(optionsLength-i, 1);
					options.splice(optionsLength-i, 1);
					//trace("Removed "+i+", new length is "+options.length+"\n");
					//i++;
					//break;
				}
			}

		}

		//Decide on best option
		var optionsAvaliable = decideOption().length;
		var option = decideOption()[0];
		var nextBestOption = decideOption()[1];

		var output:ComplexString = new ComplexString();

		if (optionsAvaliable > 1 && option.focus == nextBestOption.focus && option.focus != null){
			var conjunction = new story.option.Conjunction(option,nextBestOption,', ');
			output = conjunction.onTake();

			//A conjunction should add all sentences to the log, but ignore they were in a conjunction
			optionsTaken.add(option);
			optionsTaken.add(nextBestOption);
		}else {
			var string:ComplexString = option.onTake();
			output.addComplexString(string);
			optionsTaken.add(option); //We 'add' it to the end of this 'list', don't push it. (Pushing sets it as first element)

			//TODO: Clean below.
			if (Std.is(output.elements[0], NameElement)){
				var nameElement = cast(output.elements[0],NameElement);

				//If it is a name element we should not change the pronoun focus while capitilising.
				nameElement.setPlainText(capitilise(nameElement.getPlainTextWithoutChangingFocus())); //Capitilise first elementaa
			}else{
				output.elements[0].setPlainText(capitilise(output.elements[0].getPlainText())); //Capitilise first element

			}
		}

		var lastElement = output.elements[output.elements.length-1];
		var lastChar = lastElement.getPlainText().charAt(lastElement.getPlainText().length);
		if (lastChar != '!' && lastChar != '.')
			output.addPlain(". ");

		trace(output.getFancyText()+" ");

		Sys.sleep(0);
		turn(); //Repeat
	}

	public function capitilise (str){
		//TODO: Move to language package
		var firstChar:String = str.substr(0, 1);
		var restOfString:String = str.substr(1, str.length);

		return firstChar.toUpperCase()+restOfString.toLowerCase();
	}

	public function decideOption () {

		if (options[0] == null) {
			Sys.exit(0);
		}

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

	/*public function capitilise (str){
		//TODO: Move to language package
		var firstChar:String = str.substr(0, 1);

		var i = 0;
		while (i < str.length){
			firstChar = str.substr(i, 1);
			trace("I: "+i+"  firstChar: "+firstChar+"\n");
			if (["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"].indexOf(firstChar.toLowerCase()) > 0){
				break;
			}
			i++;
		}

		var restOfString:String = str.substr(i, str.length);
	}*/

	public function removeOption (option) {
		var i = options.length;
		while (i-- > 0)
		   if (Type.getClass(option) == Type.getClass(options[i]) && option.focus == options[i].focus)
		      options.splice(i, 1);
	} //This is BROKEN. Currently there is no way of comparing options, even with ID's,as they regenerate every turn.
}
