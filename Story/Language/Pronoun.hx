package story.language;

class Pronoun {
    //A very simple class that can be used to use pronouns in place of names.
    //Simply means that rather than repeating a name, the name becomes the pronoun focus
    //And then the name is simple returned from here as he or she.
    public static var focusEntity:story.entity.Entity;

    public static function focusOn (entity){
        //Focus on an entity manually. Doesn't return anything.
        //Main usage is if a complex sentence has two main entities.
        //IE - Josh saw Luwis. He said hi. You want the focus to be Josh.
        focusEntity = entity;
    }
    public static function tryPronounOf (entity) {
        //This slightly confusing function focuses on an entity and refers a name.
        //If it is already the focus, it returns the entity as a pronoun ('he')
        //If it is not the focus, it sets it as the focus but returns the name, not the pronoun.

        if (focusEntity == entity){
            return entity.pronoun;
        }else{
            focusEntity = entity;
            return entity.name;
        }
    }
}
