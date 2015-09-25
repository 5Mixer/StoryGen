package story.option;

import story.entity.Entity;
import story.emotion.EmotionManager;
import story.option.Option;

class StateEmotion extends Option{

    //Structure
    //{name} is feeling {strength}{emotion}
    //Eg- Josh is feeling very happy

    var who:story.entity.Person;
    public function new (ofWho) {
        super();
        who=ofWho;
    }

    override public function onTake (){
        //Ran when this option is the chosen option
        super.onTake();

        var reflectionEmotion = Random.enumConstructor(EmotionType);
        trace(story.language.Pronoun.tryPronounOf(who)+" is feeling "+
			who.emotionManager.emotions.get(reflectionEmotion).getStrengthWord() +" "+
			who.emotionManager.emotions.get(reflectionEmotion).word);
    }
}
