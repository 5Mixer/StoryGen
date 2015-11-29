package story.option;

import story.entity.Entity;
import story.emotion.EmotionManager;
import story.language.IndefiniteArticle;
import story.option.Option;
import Random;
import ComplexString;

using Output;

class ChangeLocation extends Option{
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

    }

    override public function onTake (){
        //Ran when this option is the chosen option
        super.onTake();

        adjective = Random.fromArray(location.adjectives);

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
