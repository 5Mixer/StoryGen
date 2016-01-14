package story.option;

import story.entity.Entity;
import story.emotion.EmotionManager;
import story.language.IndefiniteArticle;
import story.option.Option;
import Random;
import ComplexString;

using Output;

class DescribeRoom extends Option{
    //Structure
    //In the {adjective} {location-name} is {name-list}
    //Eg - In the butcher there is Josh, Liam and Kath.
    //Eg- Josh walked quickly to the nearby pet store
    //Eg- Liam jogged smoothly to the old gym.

    var location:story.location.Location;

    public function new (_location) {
        super();
        location=_location;


    }

    override public function onTake (futureOptions:Array<story.option.Option>){
        //Ran when this option is the chosen option
        super.onTake(futureOptions);

        var adjective = Random.fromArray(location.adjectives);


		var characters = location.characters;

		//As this is only called when the main character walks into a room, we don't include him.
		characters.remove(story.Book.mainCharacter);

		var nameList = new ComplexString();

		var i = 0;
		for (person in characters){
			i++;

			if (i == 1){
				nameList.add(new NameElement(person));
				continue;
			}

			if (i != characters.length){
				nameList.addPlain(", ")
						.add(new NameElement(person));

			}else{
				//If this is the last character in the list.
				nameList.addPlain(" and ")
						.add(new NameElement(person));
			}
		}




        return( new ComplexString()
				.addPlain("in the ")
				.addPlain(adjective)
				.addPlain(" ")
				.add(new LocationElement(location))
				.addPlain(" is ")
				.addComplexString(nameList)
			  );
    }
}
