package states;

import luxe.Color;
import luxe.Vector;
import luxe.Input;
import luxe.Text;
import luxe.States;

import mint.Control;
import mint.types.Types;
import mint.render.luxe.LuxeMintRender;
import mint.render.luxe.Convert;
import mint.render.luxe.Label;


//import story.Book;
//import story.Book;

import mint.layout.margins.Margins;

class LiveStory extends State {

    var scroll: mint.Scroll;
    var scroll2: mint.Scroll;

    override function onenter<T>(_:T) {

        Main.disp.text = 'Test: Depth';

        var outputPanel = new mint.Panel({
            parent: Main.canvas, name:'Output Panel',
            x:130, y:30, w:Luxe.screen.w-260, h: Luxe.screen.h-40,
            options: { color:new Color().rgb(0x222222) }
        });

		var outputText = new mint.Label({
			parent: outputPanel,
			name: "Output text",
			align: left,
			x:10, y:10,
			w:-20, h:-20,
			align_vertical: top,
			text: "Output generating..."
		});
        

    } //onenter

    override function onleave<T>(_:T) {

    } //onleave


} //Depth
