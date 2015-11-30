package story.location;

import story.entity.items.Item;

class Street extends Location {
    public var name:String = "Main Street";
    public var adjectives:Array<String> = ["very long","narrow","quiet","old","cracked"];
    public var inside:Bool = false;
    public var items:Array<Item>;
    public var characters:Array<story.entity.Person> = new Array<story.entity.Person>();
	public var accessibleLocations:Array<Location> = new Array<Location>();

    public function new () {};

}
