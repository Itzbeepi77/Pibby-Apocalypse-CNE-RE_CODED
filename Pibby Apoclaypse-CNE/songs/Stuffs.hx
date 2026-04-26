public var colouredBar = (dad != null && dad.xml != null && dad.xml.exists("color")) ? CoolUtil.getColorFromDynamic(dad.xml.get("color")) : 0xFFFFFFFF;
public var colouredBarG = (gf != null && gf.xml != null && gf.xml.exists("color")) ? CoolUtil.getColorFromDynamic(gf.xml.get("color")) : 0xFFFFFFFF;
public var colouredBarB = (boyfriend != null && boyfriend.xml != null && boyfriend.xml.exists("color")) ? CoolUtil.getColorFromDynamic(boyfriend.xml.get("color")) : 0xFFFFFFFF;
public var ratingScaleDiff:Float = 0.1;
public var creditsText:FlxTypedGroup;
public var shaderTextChoose = [
    "null" => null,
    "idkGlitch" => idkGlitch,
    "glitchMF" => glitchMF,
    "distorFNF" => distorFNF,
    "vcrIdk" => vcrIdk
];

public var charsColors = [
    "bf" => [0.425, 0.825, 1],
    "pibby" => [0.425, 0, 0.425],
    "darwin" => [1, 0.45, 0.15],
    "null" => [0.05, 0.05, 0.05]
];

static var CNlogo = new FunkinSprite();

static var bfIntro:Character;

static var pibbyIntro:Character;

static var countNum = new FlxSprite();

static var coloredTimeB = Options.colorHealthBar;// for timeBar color's when you checked the colorHealthBar options

// introSounds
introSounds = ['PA/3', 'PA/2', 'PA/1', 'PA/go'];

// for 3,2,1,GO images, I made it null since the thingy is animated
introSprites = [null, null, null, null];

// how long does the intro thingy ends
introLength = 0;

function postCreate() {
    GameOverSubstate.script = 'data/scripts/gameOverPibby';

    doIconBop = false;

    FlxG.mouse.visible = false;

    camera.zoom = defaultCamZoom;// to reset the camera zooming after you reset it (by not pressing F5 button)
    
    isGFPlay = curSong == "blessed-by-swords"? true:false;// reset the game over so bf still died and not the gf
    isJakePlay = false;

    allowGitaro = false;
    
	bfIntro = new Character(0, 0, "bfIntro", true);
	bfIntro.alpha = 0.001;
	if (StringTools.contains(boyfriend.curCharacter, "bf")) insert(members.indexOf(boyfriend)+1, bfIntro);
    
	pibbyIntro = new Character(0, 0, "pibbyIntro", false);
	pibbyIntro.alpha = 0.001;
    if (gf != null){
        if (StringTools.contains(gf.curCharacter, "pibby"))insert(members.indexOf(gf)+1, pibbyIntro);
    }

    for (introsChar in [pibbyIntro, bfIntro]){
        introsChar.danceOnBeat = false;
    }

    switch (curSong){// text fonts shits
        case 'forgotten-world', 'retcon', 'my-amazing-world', 'childs-play', 'my-finale', 'my-doll', 'childs-play-v2':
            timeTxt.font = Paths.font("Gumball.ttf");
            hudTxt.font = Paths.font("Gumball.ttf");
            fontShit = "Gumball";
            for (i in [creditTxt,creditTxt2]) i.font = timeTxt.font;
        case 'mindless', 'blessed-by-swords', 'brotherly-love', 'suffering-siblings', 'come-along-with-me', "no-hero-remix":
            timeTxt.font = Paths.font("Finn.ttf");
            hudTxt.font = Paths.font("Finn.ttf");
            fontShit = "Finn";
            for (i in [creditTxt,creditTxt2]) i.font = timeTxt.font;
        case "wretched_gems", 'what-am-i':
            timeTxt.font = Paths.font("Finn.ttf");
            hudTxt.font = Paths.font("Finn.ttf");
            fontShit = "Finn";
            for (i in [creditTxt,creditTxt2]) i.font = timeTxt.font;
    }

    if (curSong == "forgotten-world"){
        for (i in [missesTxt, accuracyTxt, scoreTxt, iconP1, iconP2, healthBar, healthBarBG, hudTxt]) {
            i.visible = false;
        }
    }

    // positioning the intro bf & intro pibby
    bfIntro.x = boyfriend.x-5;
    bfIntro.y = boyfriend.y+19;
    bfIntro.color = boyfriend.color;

    if (gf != null){
        pibbyIntro.x = gf.x;
        pibbyIntro.y = gf.y;
    }

    graphicCache.cache(Paths.image('Ilustracion_sin_titulo-9'));

    camHUD.alpha = 0.001;

    maxCamZoom = 99999;
}

function onSongStart(){

    if(gf != null) gfMissTime = gf.holdTime;
    bfMissTime = boyfriend.holdTime;

    switch(curSong){
        case "retcon":
            camera.flash(FlxColor.BLACK, 10);
            camera.zoom = 1.75;
            FlxTween.tween(camera, {zoom: 0.7}, 18, {
                ease: FlxEase.sineInOut,
                onComplete:
                new FlxTimer().start(18, function(tmr){
                    defaultCamZoom = 0.65;
                })
            });

        case "my-amazing-world":
            camera.zoom = 1.75;
            FlxTween.tween(camera, {zoom: 1.2}, 18, {
                ease: FlxEase.sineInOut,
            });
    }
}

var lerpVal:Float;
function postUpdate(elapsed){
    var healthPercent = health * 0.5;
    var damagePercent = 1 - healthPercent;

    for (i in [inst, vocals]){
        lerpVal = FlxMath.bound((elapsed * 9 * i.pitch), 0, 1);
    }
    iconP1.scale.set(lerp(iconP1.scale.x, 1, lerpVal), lerp(iconP1.scale.y, 1, lerpVal));
    iconP2.scale.set(lerp(iconP2.scale.x, 1, lerpVal), lerp(iconP2.scale.y, 1, lerpVal));

    transitioningAnim();

    for (bfs in strumLines.members[1].characters){
        bfs.lastHit += elapsed;
        bfs.holdTime += 0.05 + elapsed;
        
        if(bfs.animation.curAnim.finished){
            bfs.dance();
            bfs.tryDance();
        }
    }

    if (gf != null){
        gf.lastHit += elapsed;
        gf.holdTime += 0.05 + elapsed;
        
        if(gf.animation.curAnim.finished){
            gf.dance();
            gf.tryDance();
        }
    }
}
function snap(f:Float, snap:Float){// ye yeh
    var m:Float = Math.fround(f/snap);
    return (m * snap);
}
function transitioningAnim(){
    for (i in [inst, vocals]){
        for (bfs in strumLines.members[1].characters){
            if(bfs.animation.curAnim != null && bfs.lastHit > Conductor.stepCrochet * (0.0011 / i.pitch) * bfs.holdTime) {
                if(bfs.animation.curAnim.finished){ // so that newbf will always finish his directional poses, because they return to idle and it looks cool :)
                    bfs.dance();
                    bfs.tryDance();
                    //bfs.danceOnBeat = true;
                }
            }
        }

        if (gf != null){
            if(gf.animation.curAnim != null && gf.lastHit > Conductor.stepCrochet * (0.0011 / i.pitch) * gf.holdTime) {
                if(gf.animation.curAnim.finished){
                    gf.dance();
                    gf.tryDance();
                    //gf.danceOnBeat = true;
                }
            }
        }
    }
}

function beatHit(){
    iconP1.scale.set(1.175, 1.175);
    iconP2.scale.set(1.175, 1.175);
}

function onPlayerHit(note:NoteHitEvent) {

    var curNotes = note.noteType;

    iconP1.scale.set(1.225, 1.225);

    if(curSong == "blessed-by-swords") iconP3.scale.set(1.225, 1.225);

    switch(curNotes){

        case "GF Sing":
            hudTxt.color = colouredBarG;
            isGFPlay = true;
            //boyfriend.dance();


            if (curSong == "retcon" || curSong == "my-amazing-world"){
				iconP1.setIcon(gf.icon!=null?gf.icon:gf.curCharacter);
				iconP3.setIcon(boyfriend.icon!=null?boyfriend.icon:boyfriend.curCharacter);
            }

        case null | "":
            isGFPlay = false;
            hudTxt.color = colouredBarB;

            if (curSong == "retcon" || curSong == "my-amazing-world"){
				iconP3.setIcon(gf.icon!=null?gf.icon:gf.curCharacter);
				iconP1.setIcon(boyfriend.icon!=null?boyfriend.icon:boyfriend.curCharacter);
            }
    }

}

var gfMissTime = 0;
var bfMissTime = 0;
function onPlayerMiss(e){
    var curNotes = e.noteType;

    if (gf != null) gfMissTime = gf.holdTime;
    bfMissTime = boyfriend.holdTime;

    switch(curNotes){
        case "GF Sing":
            e.characters = strumLines.members[2].characters;
            
            if (gf.holdTime != gfMissTime) gf.holdTime = gfMissTime/2;

            gf.dance();
            gf.tryDance();

        case null | "":
            boyfriend.dance();
            boyfriend.tryDance();
    }
            
    if (boyfriend.holdTime != bfMissTime) boyfriend.holdTime = bfMissTime/2;

}
function onGameOver(event) {trace("you're fucking dead");}

function onEvent(e){
    if (e.event.name == "Camera Flash"){
        e.cancel();

        var cam:FlxCamera = e.event.params[3] == "camHUD"? camCinema : camHUD;

        if (e.event.params[0])
            cam.fade(e.event.params[1], (Conductor.stepCrochet / 1000) * e.event.params[2], false, () -> {cam._fxFadeAlpha = 0;}, true);
        else
            cam.flash(e.event.params[1], (Conductor.stepCrochet / 1000) * e.event.params[2], null, true);
    }
}

public var textComposeName:String = "your mom";
public function composeNames(?song:String = "none"){
    switch(song){
        case "Childs-Play-v2", "come-along-with-me", "forgotten-world": textComposeName = "Awe";
        case "wretched_gems": textComposeName = "SPADES FT.STORMY & MYAKISH";
        case "retcon": textComposeName = "RAREBLIN FT.PattyDeCaffy";
        case "childs-play": textComposeName = "Yoosuf Meekail";
        case "my-amazing-world": textComposeName = "Corn";
        case "suffering-siblings": textComposeName = "Awe FT.saster & shxdow";
        case "mindless": textComposeName = "Sevc_Ext_277";
        case "no-hero": textComposeName = "Rundown";
        case "brotherly-love": textComposeName = "Kylevi";
        case "blessed-by-sword": textComposeName = "Lettush";
        default: textComposeName = "your mom";
    }
}
