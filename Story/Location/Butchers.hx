package story.location;

import story.entity.Person;
import ComplexString;
import story.location.Location;

class Butchers extends Location{
	public function new () {
		super();
	}

	override public function generateCharacters (number=2){
		super.generateCharacters(number);

		//Create any other characters here (ie- shopkeepers).
		var butcher = new Person ();
		butcher.name = "the butcher";
		butcher.location = this;


		name = "butcher";
		adjectives = ["busy","small","pink","smelly"];


		onCharacterEnter.add(onCharacterEnterHandler);
		butcher.createOptions.add(butcherOptions);
	}

	function onCharacterEnterHandler (character:story.entity.Person,futureOptions:Array<story.option.Option>){
		if (character == story.Book.mainCharacter){
			var offerMeats = new story.option.TemporaryOption(2);
			offerMeats.score = 100;

			offerMeats.onTake = function (futureOptions){
				return new ComplexString()
							.addPlain("The butcher extends his fat hand, saying 'welcome to my store!'");
			}
			offerMeats.destroy = function () futureOptions.remove(offerMeats);
			futureOptions.push(offerMeats);
		}
	}

	function butcherOptions (optionsList:Array<story.option.Option>,futureOptions:Array<story.option.Option>){
		var o = new story.option.Option();
	}

}
