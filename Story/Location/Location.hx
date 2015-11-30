package story.location;

import story.entity.items.Item;
import msignal.Signal;

class Location {
    public var name:String;
    public var adjectives:Array<String>;
    public var inside:Bool;
    public var items:Array<Item>;
    public var characters:Array<story.entity.Person> = new Array<story.entity.Person>();
	public var accessibleLocations:Array<Location> = new Array<Location>();

	//CHANGE THIS TO USE AN EVENT MANAGER!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	public var onCharacterEnter = new Signal2<story.entity.Person,Array<story.option.Option>>();

    public function new () {};


	public function generateCharacters (num:Int = 6) {


		for (i in 0...num){
			var p = story.util.RandomPerson.get();
			characters.push(p);
			p.location = this;

		}
		trace('\n');
	}
}
