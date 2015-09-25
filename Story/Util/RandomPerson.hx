package story.util;
import Random;

class RandomPerson {
    public static function get (){
        var person = new story.entity.Person ();

        //Todo: Allow passing in of set properties.
        person.age = Random.int(10,50);
        person.gender = Random.enumConstructor(story.entity.Person.Gender);

        if (person.gender == story.entity.Person.Gender.Male){
            person.name = Random.fromArray(['Daniel','Josh','Matt','Doug','Perry','Gregory','Trent','Bob','Rick','Ted','Jason','Lewis']);
        }else{
            person.name = Random.fromArray(['Sam','Ruby','Madison','Emily','Natasha','Chloe','Emma','Olivia','Erin','Abby']);
        }


        return person;
    }
}
