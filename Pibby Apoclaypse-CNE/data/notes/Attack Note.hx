// note shit
var shits = ["LEFT","DOWN","UP","RIGHT"];

function onPlayerHit(note:NoteHitEvent){
    var curNotes = note.noteType;

    switch(curNotes){
        case "Attack Note":
            note.animSuffix = "shoot";
            if(dad.curCharacter == "finn-sword") dad.playAnim("sing"+shits[note.direction]+"-hurt");

            camHUD.zoom += FlxG.random.int(0.1, 0.05);
    }
}
function onDadHit(e){
	if (e.noteType == "Attack Note"){
		e.animSuffix = "-slash";
	}
}