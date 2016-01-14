package story.option;

import story.entity.Entity;
import story.emotion.EmotionManager;
import story.language.IndefiniteArticle;
import story.option.Option;
import Random;
import ComplexString;
import story.Book;

using Output;

@:tink class ChangeLocation extends Option{
    //Structure
    //{name} {verb} {adverb} to the {adjective} {location-name}
    //Eg- Josh walked quickly to the nearby pet store
    //Eg- Liam jogged smoothly to the old gym.

    var person:story.entity.Person;
    var location:story.location.Location;

	var verb = "walked";
	var adverb = "quickly";
	var adjective = "small";

    public function new (_person,_location) {
        super();
        person=_person;
        location=_location;
        focus=person; //TODO: Allow for both the item and the place to be the focus.

		verb = Random.fromArray(["walked","strolled","jogged","paced"]);
		adverb = Random.fromArray(["quickly","slowly"]);

    }

	//Needs future options so that we can add the option to describe the room.
    override public function onTake (futureOptions:Array<story.option.Option>){
        //Ran when this option is the chosen option
        super.onTake(futureOptions);

        adjective = Random.fromArray(location.adjectives);

		var oldLocation = person.location;

		person.location.characters.remove (person);
		person.location=location;
 		location.characters.push(person);

		var event:story.location.Location.EventEnterLocation = {
			oldLocation : oldLocation,
			newLocation : person.location,
			who : person,
			futureOptions : futureOptions
		};
		//MAKE THIS USE AN EVENT MANAGER, THIS IS TIGHTLY COUPLED!!!!!!!!!!!!!!!!!!!!!!!!
		location.onCharacterEnter.dispatch(event);

		//If there is someone in the room other than yourself, and you are the main character, describe the room.
		if (location.characters.length > 1 && person == Book.mainCharacter){
			var describeRoom = new TemporaryOption(2);
			describeRoom.score = 30;//Random.int(9,10);
			describeRoom.onTake = function (futureOptions){
				return new story.option.DescribeRoom(location).onTake(futureOptions);
			}

			describeRoom.destroy = function () futureOptions.remove(describeRoom);

			futureOptions.push(describeRoom);
		}

        return( new ComplexString()
				.add(new NameElement(person))
				.addPlain(" ")
				.addPlain(verb)
				.addPlain(" ")
				.addPlain(adverb)
				.addPlain(" to the ")
                .addPlain(adjective)
				.addPlain(" ")
				.addPlain(location.name)
			  );
    }
}
