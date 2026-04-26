function onDadHit(note:NoteHitEvent) {
    switch(dad.curCharacter) {// not all chars is doing healthdrain in og
        case "dad", "gumball", "finn-R", "jake", "finn-slash", "finn-sword", "finn-sword-shad", "finncawm", "finncawm_reveal", "finncawm_start_new", "finnanimstuff", "finn-hurt", "steven":
            if (FlxG.save.data.healthShit) {
                if (health > 0.1) {
                    note.healthGain = (curSong != "mindless"? 0.02 : 0.04);
                }
            }
    }
}