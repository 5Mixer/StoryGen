package story.emotion;

import msignal.Signal;

class Emotion {
    //The exact word that could be used in the sentence "Person feels __" ie - sad
    //Really, this should only be used by the emotion manager, because this never stores an actual
    //feeling, like anger. It is just a generic emotion that is stored as "anger" in the emotion manager.
    //**NEVER** should this be used in something like an if statement! Only really in an output sentence.
    public var word:String;

     //How strongly this emotion is felt, on a scale of 1 to 10.
    public var strength(default,set):Int = 0;

    //A signal informing recievers when an emotion changes. Sends with it the new strength of the emotion.
    //NOTE! A strength of an emotion may change MANY TIMES
    public var onStrengthChange:Signal1<Int> = new Signal1<Int>();

    public function new (wordInSentence) {
        word = wordInSentence;
    }

    public function getStrengthWord () {
        if (strength > 7){
            return "extremly";
        }else if (strength > 4){
            return "fairly";
        }else {
            return "a little";
        }
    }

    public function randomizeStrength (){
        strength = Random.int(1,10);
        return this; //For chaining
    }

    function set_strength (newStrength){
        onStrengthChange.dispatch(newStrength);
        return strength = newStrength;
    }
}
