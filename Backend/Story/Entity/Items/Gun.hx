package story.entity.items;

import story.entity.Entity;
import story.entity.Person;
import story.entity.Describable;
import story.emotion.Emotion;
import story.emotion.EmotionManager;
import story.entity.items.Item;
import story.option.Option;
import ComplexString;

class Gun extends Item implements Entity implements Describable {

	public function new () {
		super();
		name = "pistol";
		adjectives = ["automatic","small","grey"];
		rarity = 9;

	}

	override public function makeOptions (parent:Entity,
										  optionsList:Array<story.option.Option>,
										  futureOptions:Array<story.option.Option>){

		if (Std.is(parent,Person)){
			//'Holder' of this item is a person, not a room or anything.
			var person = cast(parent,Person);
			if (person.emotionManager.emotions[EmotionType.Angry].strength > 8){
				//This dudes angry man
				var shootGunOption = new Option();
				shootGunOption.focus = person;
				shootGunOption.score = Random.int(1,40);//Math.round((person.emotionManager.emotions[EmotionType.Angry].strength/2) +2);

				var possesivePronoun = (person.gender == story.entity.Gender.Male)? "his" : "her";


				shootGunOption.onTake = function (futureOptions:Array<story.option.Option>):ComplexString {
					for (neighborPerson in person.location.characters){
						if (neighborPerson != person){
							//Loop through all in room except self
							neighborPerson.emotionManager.emotions[EmotionType.Scared].strength += 5;
							if (neighborPerson.emotionManager.emotions[EmotionType.Scared].strength > 10)
								neighborPerson.emotionManager.emotions[EmotionType.Scared].strength = 9;

							var evacuateRoom = new story.option.TemporaryOption(4);
							evacuateRoom.focus = neighborPerson;
							evacuateRoom.onTake = function (futureOptions:Array<story.option.Option>) {
								var leave = new story.option.ChangeLocation(neighborPerson,Random.fromArray(person.location.accessibleLocations));

								return new ComplexString().addComplexString(leave.onTake(futureOptions))
														  .addPlain(" because ")
													  	  .add(new NameElement(person))
													      .addPlain(" fired "+possesivePronoun+" gun");
							};
							evacuateRoom.destroy = function (){
								futureOptions.remove(evacuateRoom);
							}
							evacuateRoom.score = Random.int(1,40);//Math.round(neighborPerson.emotionManager.emotions[EmotionType.Scared].strength*(Random.float(0.3,1)));

							futureOptions.push(evacuateRoom);
						}
					}

					return new ComplexString().addPlain("*Gasp!* ")
											  .add(new NameElement(person))
											  .addPlain(" just fired ")
											  .addPlain(possesivePronoun+" gun");

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
