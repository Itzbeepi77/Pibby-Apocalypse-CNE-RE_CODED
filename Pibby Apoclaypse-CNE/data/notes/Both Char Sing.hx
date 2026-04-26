var singDir = ["LEFT", "DOWN", "UP", "RIGHT"];
function onDadHit(note:NoteHitEvent) {
    var curNotes = note.noteType;

    switch(curNotes){
        case "Both Char Sing":
            strumLines.members[3].characters[0].playAnim("sing" + singDir[note.direction], true);
    }
}