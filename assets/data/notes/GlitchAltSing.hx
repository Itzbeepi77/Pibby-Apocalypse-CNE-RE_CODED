var singDir = ["LEFT", "DOWN", "UP", "RIGHT"];
function onPlayerMiss(note){
    var curNotes = note.noteType;

    switch(curNotes){
        case "GlitchAltSing":
            if (!PlayState.opponentMode){note.cancel();}
    }
    deleteNote(note.note);
}
function onNoteHit(note){
    /*strumLine.onHit.add(function(e:NoteHitEvent) {
        trace("hello");
    });*/

    var curNotes = note.noteType;

    switch(curNotes){
        case "GlitchAltSing":
            note.animSuffix = "-alt";
            trace("alt Glitch guh");
    }
}
function onNoteCreation(e) {
    var curNotes = e.noteType;
    var note = e.note;

    switch (curNotes) {
        case "GlitchAltSing":
            e.noteSprite = "notes/noteType/GlitchNOTE";
            e.noteScale = 0.7;
			note.updateHitbox();
            note.splash = "GlitchSplash"; // Set the splash
            if (PlayState.opponentMode){e.mustHit = true;}
            if (!PlayState.opponentMode) {e.mustHit = false;
			note.latePressWindow = 0.2;
            }
    }
}