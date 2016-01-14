package story.entity.items;

import story.entity.Entity;
import story.entity.Describable;
import story.entity.items.Item;
import story.emotion.EmotionManager;

class Suitcase extends Item implements Entity implements Describable {

    public function new () {
        super();
        name = "suitcase";
    	adjectives = [story.util.RandomWord.colour(),story.util.RandomWord.weight(),story.util.RandomWord.size()];
        rarity = 6;
    }

	override public function onUse (){
        super.onUse();
    }

    public static function suitableForPerson (person:story.entity.Person){
		return person.emotionManager.emotions[EmotionType.Happy].strength;
	}

}
