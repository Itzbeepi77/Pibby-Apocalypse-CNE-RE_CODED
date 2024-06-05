function onNoteHit(note:NoteHitEvent){
    var curNotes = note.noteType;

    switch(curNotes){
        case "Sword":
            boyfriend.playAnim("dodge", true);
            note.cancelAnim();
            camHUD.shake(0.008, 0.04);
            FlxG.sound.play(Paths.sound("slice"));
    }
}
function onPlayerMiss(note){
    var curNotes = note.noteType;

    switch(curNotes){
        case "Sword":
            boyfriend.playAnim("hurt", true);
            note.cancelAnim();
            note.healthGain -= 0.45;
    }
    deleteNote(note.note);
}
function onNoteCreation(e) {
    var curNotes = e.noteType;
    var note = e.note;

    switch (curNotes) {
        case "Sword":
            e.noteSprite = "notes/noteType/SwordNOTE";
            e.noteScale = 0.7;
			note.updateHitbox();
    }
}
function onPostNoteCreation(e){
    var curNotes = e.noteType;
    var note = e.note;

    switch (curNotes) {
        case "Sword":
            note.offset.x += 30;
            note.offset.y += 50;
    }
}