package story.language;

class IndefiniteArticle {
    //If you do not know what an indefinite article is, see
    //https://www.englishclub.com/pronunciation/a-an.htm

    public static function nextWordIs(nextWord:String){
        if (nextWord == null) throw 'Cannot create an indefinite article if next word is not defined';

        var firstLetter = nextWord.charAt(0);
        var vowels = ['a','e','i','o','u'];

        if ( vowels.indexOf(firstLetter) < 0) {
            //Consonant
            return "a";
        }else{
            //vowels
            return "an";
        }
    }
}
