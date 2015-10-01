package story.util;

class RandomWord {
    public static function colour (withPrefix = false) {
        var prefix = Random.fromArray(['','light','dark']);
        var colour = Random.fromArray(['red','blue','silver','gray','white','green',]);
        var final = "";
        if (withPrefix) final = prefix+" "+colour;
        if (!withPrefix) final = colour;
        return final;
    }

    public static function size (){
        return Random.fromArray(['tiny','small','large','big']);
    }
    public static function weight (){
        return Random.fromArray(['heavy','light']);
    }
}
