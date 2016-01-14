package story.entity;

interface Entity {
	public var name:String; //A simple name that can be used in a sentence.
	public var pronoun:String; //ie - "he", "she", "it".
	public var optionsUsedIn:Array<story.option.Option>;
}
