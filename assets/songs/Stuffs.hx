public var colouredBar = (dad != null && dad.xml != null && dad.xml.exists("color")) ? CoolUtil.getColorFromDynamic(dad.xml.get("color")) : 0xFFFFFFFF;
public var colouredBarG = (gf != null && gf.xml != null && gf.xml.exists("color")) ? CoolUtil.getColorFromDynamic(gf.xml.get("color")) : 0xFFFFFFFF;
public var colouredBarB = (boyfriend != null && boyfriend.xml != null && boyfriend.xml.exists("color")) ? CoolUtil.getColorFromDynamic(boyfriend.xml.get("color")) : 0xFFFFFFFF;
static var CNlogo = new FunkinSprite();

static var bfIntro:Character;

static var pibbyIntro:Character;

static var countNum = new FlxSprite();

static var coloredTimeB = Options.colorHealthBar;// for timeBar color's when you checked the colorHealthBar options

// introSounds
introSounds = ['PA/1', 'PA/2', 'PA/3', 'PA/go'];

// for 3,2,1,GO images, I made it null since the thingy is animated
introSprites = [null, null, null, null];

// how long does the intro thingy ends
introLength = 7.5;

function postCreate() {
    //GameOverSubstate.script = 'data/scripts/gameOverPibby';

    FlxG.mouse.visible = false;

    camera.zoom = defaultCamZoom;// to reset the camera zooming after you reset it (by not pressing F5 button)
    
    isGFPlay = curSong == "blessed-by-swords"? true:false;// reset the game over so bf still died and not the gf
    isJakePlay = false;
    
	bfIntro = new Character(0, 0, "bfIntro", true);
	bfIntro.alpha = 0.001;
	insert(members.indexOf(boyfriend)+1, bfIntro);
    
	pibbyIntro = new Character(0, 0, "pibbyIntro", false);
	pibbyIntro.alpha = 0.001;
    if (gf != null){
        insert(members.indexOf(gf)+1, pibbyIntro);
    }

    switch (curSong){// text fonts shits
        case 'forgotten-world', 'retcon', 'my-amazing-world', 'childs-play', 'my-finale', 'my-doll':
            timeTxt.font = Paths.font("Gumball.ttf");
            hudTxt.font = Paths.font("Gumball.ttf");
            fontShit = "Gumball";
        case 'mindless', 'blessed-by-swords', 'brotherly-love', 'suffering-siblings', 'come-along-with-me', "no-hero-remix":
            timeTxt.font = Paths.font("Finn.ttf");
            hudTxt.font = Paths.font("Finn.ttf");
            fontShit = "Finn";
        case "wretched_gems", 'what-am-i':
            timeTxt.font = Paths.font("Finn.ttf");
            hudTxt.font = Paths.font("Finn.ttf");
    }

    if (curSong == "forgotten-world"){
        for (i in [missesTxt, accuracyTxt, scoreTxt, iconP1, iconP2, healthBar, healthBarBG, hudTxt]) {
            i.visible = false;
        }
    }

    // positioning the intro bf & intro pibby
    bfIntro.x = boyfriend.x-5;
    bfIntro.y = boyfriend.y+20;

    if (gf != null){
        pibbyIntro.x = gf.x;
        pibbyIntro.y = gf.y;
    }
}

function update(elapsed){
    if (boyfriend.animation.curAnim != null && boyfriend.holdTime > Conductor.stepCrochet * (0.0011/1) * boyfriend.lastHit && boyfriend.animSuffix == "" && boyfriend.animSuffix != "-miss"){
        if (boyfriend.animation.curAnim.finished) boyfriend.dance();
    }
}

function onSongStart(){
    switch(curSong){
        case "retcon":
            camera.flash(FlxColor.BLACK, 10);
            boyfriend.alpha = 1;
            camera.zoom = 1.75;
            camHUD.alpha = 0.001;
            FlxTween.tween(camera, {zoom: 0.7}, 18, {
                ease: FlxEase.sineInOut,
                onComplete:
                new FlxTimer().start(18, function(tmr){
                defaultCamZoom = 0.7;})
            });
    }
}

function onPlayerHit(note:NoteHitEvent) {

    var curNotes = note.noteType;

    switch(curNotes){

        case "GF Sing":
            hudTxt.color = colouredBarG;
            isGFPlay = true;

        case null | "":
            isGFPlay = false;
            hudTxt.color = colouredBarB;
    }

}
function onPlayerMiss(e){
    var curNotes = e.noteType;

    switch(curNotes){
        case "GF Sing":
            e.characters = strumLines.members[2].characters;
    }
}
function onGameOver(event) {trace("you're fucking dead");}
