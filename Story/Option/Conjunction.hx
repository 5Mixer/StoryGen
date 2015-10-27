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
        output += cb.onTake();
        return output;

    }

}
