disableSripts();

var forcePlay:Null<Bool> = false;
var char;
var anim;
var directs:Null<Int>;
var suffs:Null<String>;
var timer:Null<FlxTimer>;

function create(){
    timer = new FlxTimer().start(0.5, () -> {
        forcePlay = false;
    });
}

function onNoteHit(e){
    suffs = e.animSuffix;

    char = e.character;

    anim = char.singAnims;

    directs = e.direction;
    
    if (suffs != ""){
        e.preventAnim();

        forcePlay = true;
    }
}

function postUpdate(){
    if (forcePlay){
        forcePlay = false;
        char.playAnim(anim[directs] + suffs, true);
        char.playSingAnim(directs, suffs, "SING", true);
    }
}

/*function onInputUpdate(event) {
    var chars:Array<Character> = char != null ? char : [event.strumLine.characters[0]];

    if (forcePlay){
        for (index => value in event.pressed)
            if (value){
				for (i in chars){
                    i.playAnim(anim[index] + suffs, true);
                    i.playSingAnim(index, suffs, "SING", true);
                }
            }
    }
}*/