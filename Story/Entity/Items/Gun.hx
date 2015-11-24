package story.entity.items;

import story.entity.Entity;
import story.entity.Person;
import story.entity.Describable;
import story.emotion.Emotion;
import story.emotion.EmotionManager;
import story.entity.items.Item;
import story.option.Option;

class Gun extends Item implements Entity implements Describable {

	public function new () {
		super();
		name = "pistol";
		adjectives = ["automatic","small","grey"];
		rarity = 9;

	}

	override public function makeOptions (parent:Entity,optionsList:Array<story.option.Option>){
		if (Std.is(parent,Person)){
			//'Holder' of this item is a person, not a room or anything.
			var person = cast(parent,Person);
			if (person.emotionManager.emotions[EmotionType.Angry].strength > 8){
				//This dudes angry man
				var shootGunOption = new Option();
				shootGunOption.focus = person;
				shootGunOption.score = Math.round((person.emotionManager.emotions[EmotionType.Angry].strength/2) +2);

				var possesivePronoun = (person.gender == story.entity.Gender.Male)? "his" : "her";

				shootGunOption.onTake = function ():String {
					for (neighborPerson in person.location.characters){
						if (neighborPerson != person){
							//Loop through all in room except self
							neighborPerson.emotionManager.emotions[EmotionType.Scared].strength += 5;
							if (neighborPerson.emotionManager.emotions[EmotionType.Scared].strength > 10)
								neighborPerson.emotionManager.emotions[EmotionType.Scared].strength = 9;
						}
					}
					return "*Gasp!* "+parent.name+" just fired "+possesivePronoun+" gun";
				}

				optionsList.push(shootGunOption);
			}

		}
	}

	override public function onUse (){
		super.onUse();
	}

	public static function suitableForPerson (person:story.entity.Person){
		return person.emotionManager.emotions[EmotionType.Angry].strength;
	}

}
