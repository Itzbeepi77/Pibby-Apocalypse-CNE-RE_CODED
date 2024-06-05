function onNoteHit(note:NoteHitEvent){
    var curNotes = note.noteType;

    switch(curNotes){
    case "Dodge Note":
        note.animSuffix = "dodge";
    }
}
function onNoteCreation(e) {
    var curNotes = e.noteType;
    var note = e.note;

    switch (curNotes) {
        case "Dodge Note":
            note.color = FlxColor.YELLOW;
    }
}