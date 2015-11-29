package ;

interface ComplexStringElement {
	public function getPlainText ():String;
	public function setPlainText (text:String):Void;
	public function getFancyText ():String;
}

class NameElement implements ComplexStringElement {
	var entity:story.entity.Entity;

	public function new (_entity) {
		entity = _entity;
	}
	public function setPlainText (text:String) {
		entity.name = text;
	}
	public function getPlainText () {
		return story.language.Pronoun.tryPronounOf(entity);
	}

	/* This long named function gets what would be returned from getPlainText, except without
	changing pronoun focus Should not be used for the actual output, ust for processing (eg - Capitilisation) */
	public function getPlainTextWithoutChangingFocus (){
		return story.language.Pronoun.tryPronounOf(entity,false);
	}
	public function getFancyText () {
		return Output.name(getPlainText());
	}
}
class LocationElement implements ComplexStringElement {
	var location:story.location.Location;

	public function new (_location) {
		location = _location;
	}
	public function setPlainText (text:String) {
		location.name = text;
	}
	public function getPlainText () {
		return location.name;
	}
	public function getFancyText () {
		return Output.location(getPlainText());
	}
}
class PlainTextElement implements ComplexStringElement {
	var text:String;
	public function new (_text:String) {
		text = _text;
	}
	public function setPlainText (_text:String) {
		text = _text;
	}
	public function getPlainText () {
		return text;
	}
	public function getFancyText () {
		return text;
	}
}

@:tink class ComplexString {
	@:forward(push, pop, iterator, length) public var elements:Array<ComplexStringElement> = new Array<ComplexStringElement>();
	public function new () {

	}

	public function getPlainText () {
		var text:String = "";

		for (element in elements){
			text += element.getPlainText();
		}

		return text;
	}
	public function getFancyText () {
		var text:String = "";

		for (element in elements){
			text += element.getFancyText();
		}

		return text;
	}
	public function addPlain (text:String){
		elements.push(new PlainTextElement(text));
		return this;
	}
	public function add(element:ComplexStringElement){
		elements.push(element);
		return this;
	}
	/* Push a sentence to the end of this sentence. */
	public function addComplexString (complexString:ComplexString) {
		for (element in complexString){
			elements.push(element);
		}
		return this;
	}
}
