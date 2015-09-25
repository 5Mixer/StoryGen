package story.option;

import story.entity.Entity;
import story.emotion.EmotionManager;
import story.option.Option;
import Random;

class DescribeCharactersItem extends Option{
    //Structure
    //{name} has a/an {adjective}{item-name}
    //Eg- Josh is feeling very happy

    var owner:story.entity.Person;
    var item:story.entity.items.Item;
    public function new (person,_item) {
        super();
        owner=person;
        item=_item;
    }

    override public function onTake (){
        //Ran when this option is the chosen option
        super.onTake();

        var adjective = Random.fromArray(item.adjectives);
        //TODO: MOVE THIS TO A LANGUAGE CLASS. A/AN
        var firstLetter = adjective.charAt(0);
        var vowels = ['a','e','i','o','u'];
        var the:String;
        if ( vowels.indexOf(firstLetter) < 0) {
            //Consonant
            the = "a";
        }else{
            //vowels
            the = "an";
        }

        trace(story.language.Pronoun.tryPronounOf(owner)+" has "+ the +" "+adjective+" "+ item.name);
    }
}
