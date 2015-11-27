package story.option;

import story.entity.Entity;
import story.emotion.EmotionManager;
import story.language.IndefiniteArticle;
import story.option.Option;
import Random;

using Output;

class DescribeCharactersItem extends Option{
    //Structure
    //{name} has a/an {adjective},{adjective} {item-name}
    //Eg- Josh is feeling very happy

    var owner:story.entity.Person;
    var item:story.entity.items.Item;
    public function new (person,_item) {
        super();
        owner=person;
        item=_item;
        focus=person; //TODO: Allow for both the item and the owner to be the focus.

        if (Std.is(item,story.entity.Describable) == false){
            throw 'A non describable entity was asked to be descibed. Crash!';
        }
    }

    override public function onTake (){
        //Ran when this option is the chosen option
        super.onTake();

        var adjectivesToUse:Array<String> = new Array<String>();

        for (adjectiveIndex in 0...Random.int(1,item.adjectives.length-1)){
            adjectivesToUse.push(item.adjectives[adjectiveIndex]);
        }

        //Construct every adjective after the first one, if there is more thna one adjective to use.
        //eg. Josh has an orange ----', shiny, light' suitcase.
        //so that was ', shiny, light'

        var adjectivesAfterFirst:String="";
        for (adjectiveIndex in 1...adjectivesToUse.length){ //Start at one to miss the first adjective
            adjectivesAfterFirst += ", "+adjectivesToUse[adjectiveIndex];
        }

        return( story.language.Pronoun.tryPronounOf(owner).name()+" has "+
                IndefiniteArticle.nextWordIs(adjectivesToUse[0]) +" "
                +adjectivesToUse[0]+adjectivesAfterFirst+" "+ item.name);
    }
}
