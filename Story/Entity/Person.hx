package story.entity;

import story.entity.items.Item;
import story.emotion.EmotionManager;
import story.entity.Entity;

class Person implements Entity{
	public var age:Int;
	public var name:String;
	public var inventory:Array<Item> = new Array<Item>();
	public var gender(default,set):Gender;
	public var pronoun:String;
	public var emotionManager:EmotionManager;

	public function new (){
		emotionManager = new EmotionManager();

		inventory.push(story.util.RandomItem.get());
	}

	public function makeOptions (optionsList:Array<story.option.Option>){
		var o =new story.option.StateEmotion(this);
		o.score = Random.int(1,10);
		optionsList.push(o);

		var i = new story.option.DescribeCharactersItem(this,Random.fromArray(inventory));
		i.score = Random.int(1,10);
		optionsList.push(i);
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
