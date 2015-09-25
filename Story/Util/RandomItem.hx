package story.util;

import story.entity.items.Gun;
import Random;

class RandomItem {
    public static function get (){
        var allItems = [Gun];

        var item = Type.createInstance(Random.fromArray(allItems),[]);
        return item;
    }
}
