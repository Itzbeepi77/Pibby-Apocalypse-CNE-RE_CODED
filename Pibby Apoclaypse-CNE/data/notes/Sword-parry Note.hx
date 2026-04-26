function onPlayerHit(note:NoteHitEvent){
    var curNotes = note.noteType;

    switch(curNotes){
        case "Sword-parry Note":
            note.animSuffix = "dodge-sword";
    }
}
function onPlayerMiss(note:NoteHitEvent){
    var curNotes = note.noteType;

    switch(curNotes){
        case "Sword-parry Note":
            boyfriend.playAnim("oop", true);
            note.cancelAnim();
    }
}
function onNoteCreation(e) {
    var curNotes = e.noteType;
    var note = e.note;

    switch (curNotes) {
        case "Sword-parry Note":
            e.noteSprite = "notes/noteType/SwordNOTE";
            e.noteScale = 0.7;
			note.updateHitbox();
    }
}
function onPostNoteCreation(e){
    var curNotes = e.noteType;
    var note = e.note;

    switch (curNotes) {
        case "Sword-parry Note":
            note.offset.x += 30;
            note.offset.y += 50;
    }
}