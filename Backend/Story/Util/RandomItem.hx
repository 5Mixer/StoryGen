package story.util;

import story.entity.items.*;
import Random;

class RandomItem {

    static var allItems:Array<Dynamic> = [Gun,Suitcase];

    public static function get (){

        var item = Type.createInstance(Random.fromArray(allItems),[]);
        return item;
    }
}
