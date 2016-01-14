package story;

import ComplexString;

import msignal.Signal;

class Book {

	var allCharacters:Array<story.entity.Person>;
	var allLocations:Array<story.location.Location>;

	var optionsTaken:List<story.option.Option>; //A log of previosly taken options
	var options:Array<story.option.Option>;     //The options that are avaliable this turn

	var outputText = "";

	//A list of options that will be added every turn. Will not be removed at end of turn,
	//either stay put or remove themselves.
	var futureOptions:Array<story.option.Option>;

	var street:story.location.Location;

	public static var mainCharacter:story.entity.Person;

	var chapter:Int = 0;

	public static var onAnyOptionFinish = new Signal1<story.option.Option>();

	public function new () {
		allCharacters = new Array<story.entity.Person>();
		allLocations = new Array<story.location.Location>();
		options = new Array<story.option.Option>();
		futureOptions = new Array<story.option.Option>();
		optionsTaken = new List<story.option.Option>();
	}

	public function makeStory (){
		generateLocations();

		mainCharacter = story.util.RandomPerson.get();
		mainCharacter.name = "The Main Character";
		//Because it is in this location, it wil be automagically added to 'allCharacters'
		mainCharacter.location = allLocations[0];
		allLocations[0].characters.push(mainCharacter);

		//Add all locations characters to 'allLocations'
		for (place in allLocations)
			for (person in place.characters)
				allCharacters.push(person);

		outputText = "";
		turn();
		return outputText;
	}

	public function generateLocations () {
		street = new story.location.Location();
		street.name = "Main Street";
		street.adjectives = ["very long","narrow","quiet","old","cracked"];

		street.generateCharacters(1);
		street.onCharacterEnter.add(function (event){
			//if (chapter > 149) Sys.exit(0);
			if (event.who == mainCharacter){
				if (Random.int(1,100) > 85){
					optionsTaken = new List<story.option.Option>();
					//trace("\n\n<h2>Chapter "+(++chapter)+"</h2>\n");
				}
			}
		});
		street.inside = false;
		allLocations.push(street);


		var genericRoom:story.location.Location = new story.location.Location();
		genericRoom.name = "room";
		genericRoom.adjectives = ["large","empty","white","plain"];
		genericRoom.generateCharacters(2);
		allLocations.push(genericRoom);

		var butcher = new story.location.Butchers();
		butcher.generateCharacters(2);
		allLocations.push(butcher);

		genericRoom.accessibleLocations.push(street);

		butcher.accessibleLocations.push(street);

		street.accessibleLocations.push(genericRoom);
		street.accessibleLocations.push(butcher);
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

		for (option in futureOptions){
			options.push(option);
		}

		for (char in mainCharacter.location.characters){
			char.makeOptions(options,futureOptions);
		}

		//Reduce likelyhood ofuoi repeating setence types.

		var optionsLength = options.length;

		for (i in 0...optionsLength+1){
			//if (Type.getClass(option) == Type.getClass(optionsTaken.last())) option.score-=1;
			var option = options[optionsLength-i];

			for (pastOption in optionsTaken){

				if (Type.getClass(option) == Type.getClass(pastOption) && option.focus == pastOption.focus){

					if (Type.getClass(option) == story.option.ChangeLocation || Type.getClass(option) == story.option.DescribeRoom){
						continue;
					}
					options.splice(optionsLength-i, 1);

				}
			}

		}

		//Check that we have atleast one option
		if (decideOption() == null) {
			trace("\nNo more options left.");
			return;
		}
		//Decide on best option
		var optionsAvaliable = decideOption().length;
		var option = decideOption()[0];
		var nextBestOption = decideOption()[1];

		var output:ComplexString = new ComplexString();

		if (optionsAvaliable > 1 && option.focus == nextBestOption.focus && option.focus != null){
			var conjunction = new story.option.Conjunction(option,nextBestOption,', ');
			output = conjunction.onTake(futureOptions);


			onAnyOptionFinish.dispatch(conjunction);

			//A conjunction should add all sentences to the log, but ignore they were in a conjunction
			optionsTaken.add(option);
			optionsTaken.add(nextBestOption);
		}else {
			var string:ComplexString = option.onTake(futureOptions);
			output.addComplexString(string);

			onAnyOptionFinish.dispatch(option);

			optionsTaken.add(option); //We 'add' it to the end of this 'list', don't push it. (Pushing sets it as first element)

			//TODO: Clean below.
			// if (Std.is(output.elements[0], NameElement)){
			// 	var nameElement = cast(output.elements[0],NameElement);
			//
			// 	//If it is a name element we should not change the pronoun focus while capitilising.
			// 	nameElement.setPlainText(capitilise(nameElement.getPlainTextWithoutChangingFocus())); //Capitilise first elementaa
			// }else{
			// 	output.elements[0].setPlainText(capitilise(output.elements[0].getPlainText())); //Capitilise first element
			//
			// }
		}
		output.elements[0].capital = true;

		var lastElement = output.elements[output.elements.length-1];
		var lastChar = lastElement.getPlainText().charAt(lastElement.getPlainText().length);
		if (lastChar != '!' && lastChar != '.')
			output.addPlain(". ");

		outputText += output.getFancyText(); //Output contains ASCII crAP.



		turn(); //Repeat

	}

	public function capitilise (str){
		//TODO: Move to language package
		var firstChar:String = str.substr(0, 1);
		var restOfString:String = str.substr(1, str.length);

		return firstChar.toUpperCase()+restOfString.toLowerCase();
	}

	public function onNoMoreOptions (options:Array<story.option.Option>) {
		/*if (mainCharacter.location != street){
			//options.push(new story.option.ChangeLocation(mainCharacter,street));

			optionsTaken = new List<story.option.Option>();
		}else{

			if (Random.bool()){

			}


			optionsTaken = new List<story.option.Option>();
		}
		optionsTaken = new List<story.option.Option>();
		//turn();*/
		//options.push(new story.option.ChangeLocation(mainCharacter,Random.fromArray(mainCharacter.location.accessibleLocations)));

	}

	public function decideOption () {

		if (options[0] == null) {
			//onNoMoreOptions(options);
			return null;
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


	public function removeOption (option) {
		var i = options.length;
		while (i-- > 0)
		   if (Type.getClass(option) == Type.getClass(options[i]) && option.focus == options[i].focus)
		      options.splice(i, 1);
	} //This is BROKEN. Currently there is no way of comparing options, even with ID's,as they regenerate every turn.
}
