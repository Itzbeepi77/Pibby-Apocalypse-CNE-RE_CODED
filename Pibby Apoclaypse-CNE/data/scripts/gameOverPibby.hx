var funnyGumballSound:String = FlxG.random.bool(25) ? "bfgumballdeath" : "new_gumball_death";// 25% change to get the old gumball death sound
var pibby_deathScreen = new FunkinSprite();
function create(e) {
    window.title = "Pibby: Apocalypse - Game Over";

    pibby_deathScreen = new FunkinSprite(10,0);
    pibby_deathScreen.frames = Paths.getSparrowAtlas('characters/PA/deathscreen');
    pibby_deathScreen.animation.addByPrefix('firstDeath', 'deathscreen first', 24, false);
    pibby_deathScreen.animation.addByPrefix('deathLoop', 'deathscreen deathloop', 24, true);
    pibby_deathScreen.animation.addByPrefix('deathConfirm', 'deathscreen confirm', 24, false);
    pibby_deathScreen.playAnim('firstDeath');
    pibby_deathScreen.addOffset('firstDeath', 1);
    pibby_deathScreen.addOffset('deathLoop', 1);
    pibby_deathScreen.addOffset('deathConfirm', 410, 188);
    pibby_deathScreen.antialiasing = true;
    pibby_deathScreen.alpha = 0.001;
    insert(2, pibby_deathScreen);

    switch (PlayState.SONG.meta.name) {
        case "Mindless" | "Come-Along-With-Me":
            e.character = "bffinndead";
            e.lossSFX = "bffinndeath";
            e.retrySFX = "gffinnrevive";
            FlxG.camera.zoom = 0.7;

        case "Blessed-By-Swords":
            if (isGFPlay) pibby_deathScreen.alpha = 1;
            e.character = isGFPlay? "pibby-dead":"bffinndead";
            e.lossSFX = isGFPlay? "glitchhit":"bffinndeath";
            if (!isGFPlay) e.retrySFX = "gffinnrevive";
            FlxG.camera.zoom = isGFPlay? 0.52:0.7;

        case "Suffering-Siblings":
            if (isGFPlay) pibby_deathScreen.alpha = 1;
            e.character = isGFPlay? "pibby-dead": isJakePlay? "bfjakedead":"bffinndead";
            e.lossSFX = isGFPlay? "glitchhit": isJakePlay? "bfjakedeath":"bffinndeath";
            if (!isGFPlay) retrySFX = "gffinnrevive";
            FlxG.camera.zoom = isGFPlay? 0.52:0.7;

        case "Brotherly-Love":
            e.character = "bfjakedead";
            e.lossSFX = "bfjakedeath";
            retrySFX = "gffinnrevive";
            FlxG.camera.zoom = 0.7;

        case "Childs-Play":
            e.character = "bfgumdead";
            e.lossSFX = funnyGumballSound;
            e.retrySFX = "gfgumballrevive";
            FlxG.camera.zoom = 0.7;

        case "My-Amazing-World" | "Retcon":// yippee
            e.character = isGFPlay? "darwin" : "bfgumdead";
            e.lossSFX = isGFPlay? "glitchHit" : funnyGumballSound;
            if (!isGFPlay) retrySFX = "gfgumballrevive";
            FlxG.camera.zoom = 0.7;

        case "Forgotten-World":
            e.lossSFX = "glitchhit";
            FlxG.camera.zoom = 0.7;
    }
}
function update(elapsed){
    if (controls.ACCEPT){
        pibby_deathScreen.playAnim('deathConfirm', true);
        new FlxTimer().start(.25, function(tmr){
                pibby_deathScreen.alpha = 0.001;
        });
    }
}
function beatHit(curBeat){
    if (FlxG.sound.music != null && FlxG.sound.music.playing)
        pibby_deathScreen.playAnim("deathLoop", true, "DANCE");
}