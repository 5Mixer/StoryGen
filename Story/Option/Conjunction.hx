package story.option;

class Conjunction extends story.option.Option{
    var ca:story.option.Option; //Clause (option) A&B
    var cb:story.option.Option;
    var conjunction:String;
    public function new (clauseA,clauseB,_conjunction=" and "){
        ca = clauseA;
        cb = clauseB;
        focus = null;
        conjunction = _conjunction;
        super();
    }
    override public function onTake(){
        super.onTake();
        var output:String;
        output = ca.onTake();
        output += (conjunction);
        output = capitilise(output);
        output += cb.onTake();
        return output;

    }

    public function capitilise (str){
		//TODO: Move to language package
		var firstChar:String = str.substr(0, 1);
		var restOfString:String = str.substr(1, str.length);

		return firstChar.toUpperCase()+restOfString.toLowerCase();
	}

}
