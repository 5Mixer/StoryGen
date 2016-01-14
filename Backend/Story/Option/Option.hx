package story.option;

import msignal.Signal;
import ComplexString;

class Option {
    //Score is an integer between one and ten that decides how likely this option should be taken.
    public var score:Int;
    public var focus:story.entity.Entity;
    public var onTakeSignal:Signal0 = new Signal0();

    public function new () {}

    dynamic public function onTake (futureOptions:Array<story.option.Option>):ComplexString{
        //Ran when this option is the chosen option
        onTakeSignal.dispatch();
        return new ComplexString();
    }
}
