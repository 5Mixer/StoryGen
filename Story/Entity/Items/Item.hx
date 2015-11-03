package story.entity.items;

import story.entity.Entity;
import story.entity.Describable;
import msignal.Signal;

class Item implements Entity implements Describable {
	public var name:String;
	public var pronoun:String = 'it'; //The gun was made of metal and 'it' was heavy
	public var hasBeenDescribed:Bool = false;
	public var adjectives:Array<String>;
	public var onUseSignal:Signal0 = new Signal0();
	public var rarity:Int = 2; //On a scale of one to ten, how rare is this item?
	public var optionsUsedIn:Array<story.option.Option>;

	public function new () {
		optionsUsedIn = new Array<story.option.Option>();
	}

	public function onUse (){
		onUseSignal.dispatch();
	}

	//Able to decide, off specific person attributes, how much a character should have this item.
	//This returning 10 means it is perfectly suitable, and 1 means it is extremly unsuitable.
	//It will not always pick the item that returns the highest number though, this just weights an average.
	public static function suitableForPerson (person:story.entity.Person){
		return 5;
	}

}
