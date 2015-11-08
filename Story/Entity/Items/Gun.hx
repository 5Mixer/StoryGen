package story.entity.items;

import story.entity.Entity;
import story.entity.Describable;
import story.entity.items.Item;
import story.emotion.EmotionManager;

class Gun extends Item implements Entity implements Describable {

	public function new () {
		super();
		name = "pistol";
		adjectives = ["automatic","small","grey"];
		rarity = 9;

	}

	override public function onUse (){
		super.onUse();
	}

	public static function suitableForPerson (person:story.entity.Person){
		return person.emotionManager.emotions[EmotionType.Angry].strength;
	}

}
