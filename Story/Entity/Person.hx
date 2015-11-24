package story.entity;

import story.entity.items.Item;
import story.emotion.EmotionManager;
import story.entity.Entity;
import story.location.Location;
import Random;

typedef SuitabilityInformation = {
	public function suitableForPerson (person:story.entity.Person):Int;
}

class Person implements Entity{
	public var age:Int;
	public var name:String;
	public var inventory:Array<Item> = new Array<Item>();
	public var gender(default,set):Gender;
	public var pronoun:String;
	public var emotionManager:EmotionManager;
	public var optionsUsedIn:Array<story.option.Option>;
	public var location:Location;


	public function new (){
		emotionManager = new EmotionManager();

		optionsUsedIn = new Array<story.option.Option>();

		////TODO: MAKE THE ITEM GIVEN DIFFERENT PER PERSON.

		var weightsTotal = 0;
		var weightMap = new Map<Int,Class<Item>>();
		for (itemObject in story.entity.items.ItemRegistry.items){

			var suitabilityInfo:SuitabilityInformation = cast (itemObject);
			var suitability = suitabilityInfo.suitableForPerson(this);
			weightsTotal += suitability;
			weightMap.set(weightsTotal,itemObject);
		}
		var randomIndex = Random.int(0,weightsTotal);

		var item:Dynamic;
		for (index in weightMap.keys()){
			if (index < randomIndex){
				item = Type.createInstance(cast weightMap[index],[]);
			}
		}

		inventory.push(story.util.RandomItem.get()); //inventory.push(item); //
	}

	public function makeOptions (optionsList:Array<story.option.Option>){
		var o = new story.option.StateEmotion(this);
		o.score = emotionManager.getStrongestEmotion().strength - 3;
		optionsList.push(o);

		var item = Random.fromArray(inventory);
		var i = new story.option.DescribeCharactersItem(this,item);
		i.score = item.rarity;//Random.int(1,10);
		optionsList.push(i);

		for (item in inventory){
			item.makeOptions(this,optionsList);
		}
	}

	public function setName (newName){
		name = newName;
		return this;
	}
	function set_gender (newGender){
		if (newGender == Gender.Male) pronoun = "he";
		if (newGender == Gender.Female) pronoun = "she";
		return gender = newGender;
	}

}

enum Gender {
	Male;
	Female;
}
