function onNoteHit(note:NoteHitEvent){
    var curNotes = note.noteType;

    switch(curNotes){
        case "Attack Note":
            note.animSuffix = "shoot";
    }
}