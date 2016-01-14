package story.option;

import ComplexString;

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
    override public function onTake(futureOptions:Array<story.option.Option>){
        super.onTake(futureOptions);
        var output:ComplexString = new ComplexString();
        output.addComplexString (ca.onTake(futureOptions));
		// 
		// //TODO: Clean below.
		// if (Std.is(output.elements[0], NameElement)){
		// 	var nameElement = cast(output.elements[0],NameElement);
		//
		// 	//If it is a name element we should not change the pronoun focus while capitilising.
		// 	nameElement.setPlainText(capitilise(nameElement.getPlainTextWithoutChangingFocus())); //Capitilise first elementaa
		// }else{
		// 	output.elements[0].setPlainText(capitilise(output.elements[0].getPlainText())); //Capitilise first element
		//
		// }

        output.addPlain (conjunction);



        output.addComplexString(cb.onTake(futureOptions));
        return output;

    }

    public function capitilise (str){
		//TODO: Move to language package
		var firstChar:String = str.substr(0, 1);
		var restOfString:String = str.substr(1, str.length);
		return firstChar.toUpperCase()+restOfString.toLowerCase();
	}

}
