package story.entity.items;

import story.entity.Entity;
import story.entity.Describable;
import story.entity.items.Item;

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


}
