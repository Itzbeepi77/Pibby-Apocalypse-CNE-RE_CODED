function onPlayerHit(note:NoteHitEvent){
    var curNotes = note.noteType;

    switch(curNotes){
        case "Attack Note":
            note.animSuffix = "shoot";
    }
}
function onDadHit(e){
	if (e.noteType == "Attack Note"){
		e.animSuffix = "-slash";
	}
}