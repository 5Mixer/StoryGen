package story.emotion;

import story.emotion.Emotion;

class EmotionManager {
    //This class represenents a being's emotions. It is meant to be used by characters or other living things.
    //There is no actual 'anger' class or anything, it is just a map of emotions here.

    public var emotions:Map<EmotionType,Emotion>;

    public function new (){
        emotions = new Map<EmotionType,Emotion>();

        //For every avaliable emotion in the enum, create a matching emotion object
        //Possible using a for loop, but manual arguments could be annoying.
        //For looping through enum see http://stackoverflow.com/questions/22516768/haxe-enum-iteration

        emotions.set(EmotionType.Happy, new Emotion('happy').randomizeStrength());
        emotions.set(EmotionType.Sad,   new Emotion('sad').randomizeStrength());
        emotions.set(EmotionType.Angry, new Emotion('angry').randomizeStrength());
        emotions.set(EmotionType.Scared, new Emotion('scared').randomizeStrength());

    }

    public function getStrongestEmotion () {

    }
}

enum EmotionType {
    Happy;
    Sad;
    Angry;
    Scared;
}
