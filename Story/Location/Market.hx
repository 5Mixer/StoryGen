package story.location;

class Market extends Location {

	//public var tradableItems:Array<story.item.Item> = new Array<story.item.Item>();
	public function new (){
		super();
	}

	override public function generateCharacters (number=1){
		super.generateCharacters(number);

		//Create any other characters here (ie- shopkeepers).
	}
}
