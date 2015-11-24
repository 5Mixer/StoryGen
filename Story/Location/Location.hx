package story.location;

import story.entity.items.Item;

class Location {
    public var name:String;
    public var adjectives:Array<String>;
    public var inside:Bool;
    public var items:Array<Item>;
    public var characters:Array<story.entity.Person> = new Array<story.entity.Person>();

    public function new () {};
}
