//
public var replaceColour:FlxColor = FlxColor.RED;

public var bfColorName:String;
public var gfColorName:String;

var nameBF:String;
var nameGF:String;

public var colorBarsBF:Array = [];
public var colorBarsGF:Array = [];

public var colorsBF:Array<Dynamic> = [];
public var colorsGF:Array<Dynamic> = [];

public var bfBarColor:FlxColor;
public var gfBarColor:FlxColor;

public var selColorChars:Int = 0;

/*public var charsColors = [
    "bf" => [0.425, 0.825, 1],
    "pibby" => [0, 1, 0],
    "darwin" => [1, 0.45, 0.15],
    "null" => [0.05, 0.05, 0.05]
];*/

function create(){
    colorBarsBF = Json.parse(Assets.getText(Paths.json('healthColors/haelthsClroso')));
    colorBarsGF = Json.parse(Assets.getText(Paths.json('healthColors/haelthsClroso')));

    colorsBF = colorBarsBF.healthbar_colors;
    colorsGF = colorBarsGF.healthbar_colors;

    bfBarColor = CoolUtil.getColorFromDynamic(colorsBF[selColorChars][0], colorsBF[selColorChars][1], colorsBF[selColorChars][2]);
    if (gf != null){
        gfBarColor = CoolUtil.getColorFromDynamic(colorsGF[selColorChars][0], colorsGF[selColorChars][1], colorsGF[selColorChars][2]);
    }

    replaceColour = bfBarColor;

    if (Options.gameplayShaders){

        //[0.425, 0.825, 1] for bf
        //[1, 0.45, 0.15] for darwin
        
        set_GreenShit(replaceColour);
    }

}
// fuck you this shit is not worked at all LOL
public function set_GreenShit(color:FlxColor) {
	gReplaceCol.data.replacementColour.value = [color.redFloat, color.greenFloat, color.blueFloat];
    return replaceColour = color;
}
function onPlayerHit(note){
    var curNotes = note.noteType;

    switch(curNotes){

        case "GF Sing":
    
            if (curSong == "retcon" || curSong == "my-amazing-world"){
                if (Options.gameplayShaders){
                    
                    selColorChars = 1;
    
                    replaceColour = gfBarColor;
                    
                    set_GreenShit(replaceColour);
                }
            }
    
        case null | "":
            if (curSong == "retcon" || curSong == "my-amazing-world"){
                if (Options.gameplayShaders){

                    selColorChars = 0;
    
                    replaceColour = bfBarColor;
                    
                    set_GreenShit(replaceColour);
                }
            }
    }
}