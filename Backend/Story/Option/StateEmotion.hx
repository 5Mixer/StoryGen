package story.option;

import story.entity.Entity;
import story.emotion.EmotionManager;
import story.option.Option;

import ComplexString;

using Output;

class StateEmotion extends Option{

	//Structure
	//{name} is {strength}{emotion}
	//Eg- Josh is very happy

	var who:story.entity.Person;
	public function new (ofWho) {
		super();
		who=ofWho;
		focus=who;
	}

	override public function onTake (futureOptions){
		//Ran when this option is the chosen option
		super.onTake(futureOptions);


		//var reflectionEmotion = Random.enumConstructor(EmotionType);
		var reflectionEmotion = who.emotionManager.getStrongestEmotion();

		return(new ComplexString()
				.add(new NameElement(who))
				.addPlain(" is ")
				.addPlain(reflectionEmotion.getStrengthWord())
				.addPlain (" ")
				.addPlain(reflectionEmotion.word));
	}
}
