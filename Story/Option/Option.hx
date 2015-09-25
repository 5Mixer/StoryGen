package story.option;

import msignal.Signal;

class Option {
    //Score is an integer between one and ten that decides how likely this option should be taken.
    public var score:Int;

    public var onTakeSignal:Signal0 = new Signal0();

    public function new () {}

    public function onTake (){
        //Ran when this option is the chosen option
        onTakeSignal.dispatch();
    }
}