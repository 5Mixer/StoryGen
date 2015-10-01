package story.option;

import story.entity.Entity;
import story.emotion.EmotionManager;
import story.option.Option;

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

	override public function onTake (){
		//Ran when this option is the chosen option
		super.onTake();


		//var reflectionEmotion = Random.enumConstructor(EmotionType);
		var reflectionEmotion = who.emotionManager.getStrongestEmotion();

		return(story.language.Pronoun.tryPronounOf(who)+" is "+
			reflectionEmotion.getStrengthWord() +" "+
			reflectionEmotion.word);
	}
}
