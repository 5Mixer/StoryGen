package story.util;

import story.entity.items.*;
import Random;

class RandomItem {
    public static function get (){
        var allItems:Array<Dynamic> = [Gun,Suitcase];

        var item = Type.createInstance(Random.fromArray(allItems),[]);
        return item;
    }
}
