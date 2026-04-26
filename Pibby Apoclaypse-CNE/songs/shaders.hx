// glitch shaders
public var distorFNF = new CustomShader("NewGlitch2");
public var distorFNF2 = new CustomShader("distortShader");
public var distorFNF3 = new CustomShader("distortShader");
public var distorDad = new CustomShader("distortShader");
public var glitchMF = new CustomShader("glitchShit");
public var idkGlitch = new CustomShader("fwGlitch");
public var pibbyShader = new CustomShader('glitchThingy');

public var vcrIdk = new CustomShader("MAWVHS");

public var vigShader = new CustomShader("coloredVignette");

public var aberation = new CustomShader('abberation');
public var gReplaceCol = new CustomShader("greenReplacement");
public var bright = new CustomShader('brightness-contrast');// brightness shader
public var bloom = new CustomShader('bloom');// bloom shader
public var pixah = new CustomShader('pixelated');

public var replacecColour:FlxColor = FlxColor.RED;

public var fuckYou:Float = 0;

public var pussy:Float = 0;

public var strumGlitch:Bool = true;

public var defaultOppX = [];
public var defaultPlayX = [];

var bfBarColor:String;
var gfBarColor:String;

static var doGlitch = FlxG.save.data.shaderShit;
static var doGlitchEffect = FlxG.save.data.glitchShit;

static var doGlitchIconEffect = FlxG.save.data.glitchIcon;
function postCreate(){
    //cpu.onNoteUpdate.add(updateNote);

    if(Options.gameplayShaders) {

        for (i in cpuStrums.members){
            switch(curSong){
                default:
                    i.shader = distorFNF;
                case "childs-play", "come-along-with-me", "childs-play-v2":
                    i.shader = null;
                    strumGlitch = false;// preventing the strum do the glitch effect
            }
        }

        camGame.addShader(aberation);
        camHUD.addShader(aberation);
        camGame.addShader(pibbyShader);
        camHUD.addShader(pibbyShader);
        camGame.addShader(bright);
        camGame.addShader(bloom);

        if(curSong == "come-along-with-me"){
            camCinema.addShader(aberation);
            camCinema.addShader(pibbyShader);
        }

        pibbyShader.iMouseX = 500;
        pibbyShader.NUM_SAMPLES = 3;

        bloom.size = StringTools.contains(curStage, "void")? 17.5 : -0.001;

        distorFNF.binaryIntensity = 0.0;

        glitchMF.enabled = false;
        
        bright.brightness = StringTools.contains(curStage, "void")? -0.05 : 0.0;
        bright.contrast = StringTools.contains(curStage, "void")? 1.1 : 0.8;

        aberation.aberration = 0.0;

        vigShader.color = [0.0, 0.0, 0.0];
        vigShader.amount = 0.0;
        vigShader.strength = 1.0;

        pixah.iTime = 7.5;

        //[0.425, 0.825, 1] for bf
        //[1, 0.45, 0.15] for darwin
        
        var nameBF:String = StringTools.contains(strumLines.members[1].characters[0].curCharacter, "bf")? "bf" : StringTools.contains(strumLines.members[1].characters[0].curCharacter, "darwin")? "darwin" : "null";
        bfBarColor = charsColors[nameBF];
        if (gf != null){
            var nameGF:String = StringTools.contains(strumLines.members[2].characters[0].curCharacter, "pibby")? "pibby" : StringTools.contains(strumLines.members[2].characters[0].curCharacter, "darwin")? "darwin" : "null";
            gfBarColor = charsColors[nameGF];
        }
        
        set_GreenShit(bfBarColor[0], bfBarColor[1], bfBarColor[2]);
    }
    
    // to get the number of each positions of the strums member
    for (i in cpuStrums.members) {defaultOppX.push(i.x);}
    for (i in playerStrums.members) {defaultPlayX.push(i.x);}
}

// fuck you this shit is not worked at all LOL
public function set_GreenShit(?r:Float = 0, ?g:Float = 1, ?b:Float = 0) {
	gReplaceCol.data.replacementColour.value = [r, g, b];
}

function onEvent(e){
    if (e.event.name == "AppleFilter"){
        if (Options.gameplayShaders) {
            if (e.event.params[0]){
                isInvertOpponent = false;
                bloom.size = 10.0;
                bright.contrast = 1.0;
                bright.brightness = 0.0;
            }
            else if (e.event.params[0] == false){
                isInvertOpponent = true;
                bloom.size = StringTools.contains(curStage, "void")? 17.5 : -0.001;
                bright.brightness = StringTools.contains(curSong, "forgotten-world")? -0.125 : StringTools.contains(curStage, "void")? 0.05 : 0.0;
                bright.contrast = StringTools.contains(curSong, "forgotten-world")? 0.7 : StringTools.contains(curStage, "void")? 1.1 : 0.8;
            }
        }
    }
    if (e.event.name == "Add Camera Zoom"){
		if(Options.gameplayShaders) aberation.aberration += 0.025;
    }
}

function onGameOver() {
    camGame.removeShader(aberation);
    camGame.removeShader(pibbyShader);
    camGame.removeShader(bloom);
    camGame.removeShader(bright);
}

var shitty:Float = 0;

public var fuckinIntens:Float = 0;
public var negativeShit:Float = 0;

var distortIntensity:Float;
function stepHit(curStep:Int){
    if (Options.gameplayShaders){
        distortIntensity = FlxG.random.float(4, 6);
        
        distorFNF.binaryIntensity = FlxG.random.float(distortIntensity, 10);

        distorFNF2.binaryIntensity = distortIntensity;

        distorFNF3.binaryIntensity = FlxG.random.float(distortIntensity, 10);
        
        shitty = (FlxG.random.float(4.0, 8.0) * FlxG.random.float(FlxG.random.float(0.356, 0.1987), FlxG.random.float(-0.175, -1.75))) * 5.7;
        
        pixah.size = FlxG.random.float(10,5);

    }
}

function beatHit(curBeat:Int) {
    if (Options.gameplayShaders)
        shitty = (FlxG.random.float(4.0, 8.0) * FlxG.random.float(FlxG.random.float(0.356, 0.1987), FlxG.random.float(-0.175, -1.75))) * 5.7;
}

// lmao it's glitching time >:)
static var glitch_time:Float = 0;
static var glitchTimeValue:Float = 0;

public var isInvertOpponent:Bool = true;
function update(elapsed) {
    if (Options.gameplayShaders){
		if (camZooming && Options.camZoomOnBeat) {
			var beat = Conductor.getBeats(camZoomingEvery, camZoomingInterval, camZoomingOffset);
			if (camZoomingLastBeat != beat) {
                aberation.aberration = 0.05 * camZoomingStrength;
			}
            aberation.aberration = FlxMath.lerp(aberation.aberration, 0, FlxMath.bound(elapsed * 6, 0, 1));
		}

        pibbyShader.glitchMultiply = glitch_time;
		glitch_time = lerp(glitch_time, 0, FlxMath.bound(elapsed * 7, 0, 1));
		//intens = lerp(intens, 0, FlxMath.bound(elapsed * 6, 0, 1));

        var distortIntensity2:Float = FlxG.random.float(4, 6);

        distorFNF3.binaryIntensity = distortIntensity - FlxG.random.float(distortIntensity2, 10) * elapsed / 5;

        glitchTimeValue += elapsed;
        pibbyShader.uTime = glitchTimeValue;

        glitchMF.iTime = glitchTimeValue;

        idkGlitch.iTime = glitchTimeValue;

        vcrIdk.iTime = glitchTimeValue;
        
        distorFNF2.negativity = shitty;

        distorDad.binaryIntensity = fuckinIntens;
        distorDad.negativity = negativeShit;
    
        // icon glitching (more icons are in [data/scripts/])
        if (doGlitchIconEffect){
            if (healthBar.percent < 20){
                iconP1.shader = distorFNF;
            } else {
                iconP1.shader = null;
            }
            if (healthBar.percent > 80){
                iconP2.shader = distorFNF;
            } else {
                iconP2.shader = null;
            }
        }
        if (fuckYou > 0) {
            fuckYou -= elapsed;
            if (negativeShit >= 0 && distorDad.binaryIntensity >= 0) {
                negativeShit -= elapsed;
                distorDad.binaryIntensity -= elapsed;
                if(negativeShit <= 0 && distorDad.binaryIntensity <= 0) {
                    negativeShit = 0;
                    distorDad.binaryIntensity = 0;
                }
            }
            if(fuckYou <= 0) {
                fuckYou = 0;
    
                negativeShit = 0;
                distorDad.binaryIntensity = 0;

                // all characters that are inside dad strum will glitched
                for (dads in strumLines.members[0].characters){
                    if (dads.shader == distorDad){
                        dads.shader = null;
                    }
                }

                // to prevent error without add more shits
                if (strumLines.members[3] != null && strumLines.members[3].characters[0].shader == distorDad)
                    strumLines.members[3].characters[0].shader = null;
            }
        }
        if (pussy > 0) {
            pussy -= elapsed;
            if(pussy <= 0) {
                pussy = 0;
                // strum glitch, haha funni
                if (strumGlitch){
                    for (i in cpuStrums.notes.members){
                        if (i.shader == distorFNF2 && (i.noteType == "" || i.noteType == null)) i.shader = null;
                    }
                }
            }
        }

        if (curSong == "come-along-with-me"){
            if (curStep == 384){
                if(Options.gameplayShaders) {
                    strumGlitch = true;
                }
            }
        }
        if (curSong == "childs-play"){
            if (curStep == 256){
                if(Options.gameplayShaders) {
                    strumGlitch = true;
                }
            }
        }
    }/*
    for (i in 0...4){
        if (cpu.members[i].animation.curAnim.name == "static" && cpu.members[i].shader == distorFNF2)
            cpu.members[i].shader = distorFNF;
    }*/
}

/*function updateNote(e){
    var curNotes = e.note.noteType;

    if (e.note.strumLines == cpu){
        e.__reposNote = false;
        e.strum.updateNotePosition(e.note);
        e.note.x = e.note.x + FlxG.random.int(-420, 420);
        FlxTween.tween(e.note, {x: i.x}, 0.2);
    }
}*/

// this is interesting..
// also inakuro if you want to use it just becareful


public var isJakePlay:Bool = false;
function onDadHit(note){

    var curNotes = note.noteType;
    
    var glitching:Bool = false;

    if(!isJakePlay) iconP2.scale.set(1.225, 1.225);
    
    if (curNotes == "Second Char Sing" || curNotes == "Second Char Glitch"){// second opponen char singing
        isJakePlay = true;
        note.characters = strumLines.members[3].characters;
    }

    if(isJakePlay) iconP4.scale.set(1.225, 1.225);

    if (curNotes == "Glitch Note" || curNotes == "Both Char Glitch"){// make the opponent glitching
        fuckYou = 0.09;
        glitching = !glitching;
        if (Options.gameplayShaders){

            fuckinIntens = FlxG.random.float(-1, -0.5);

            // will make all of dads character glitching if you want them to not popping up just do [visible = false;]
            for (dads in strumLines.members[0].characters){
                if (dads.shader == null || dads.shader == distorFNF)dads.shader = distorDad;
            }
            if (isInvertOpponent) negativeShit = 1.0;
            //distorDad.negativity = (note.note.sustainLength > 0 ? note.note.sustainLength/1000 : 0) + FlxG.random.float(0.0475, 0.085);
        }
        if (health > 0.75) {
            health -= FlxG.random.float(0.075, 0.2);// glitch damage
        }
        for (i in 0...cpuStrums.length) {
            cpuStrums.members[i].x = defaultOppX[i] + FlxG.random.int(-8, 8);
            cpuStrums.members[i].y = 50 + FlxG.random.int(-8, 8);
        }

        if (FlxG.random.float(0, 1) >= 0.5) {
            glitch_time += FlxG.random.float(FlxG.random.float(0.2, 0.7), FlxG.random.float(0.4, 1.4));
        }

        if (FlxG.random.float(0, 1) < 0.5) {
            camGame.shake(FlxG.random.float(0.015, 0.02), FlxG.random.float(0.0075, 0.125));
        } else {
            camHUD.shake(FlxG.random.float(0.015, 0.02), FlxG.random.float(0.0075, 0.125));
        }
    }

    if (curNotes == "Second Char Glitch"){// make the second opponent glitching
        fuckYou = 0.09;
        glitching = !glitching;
        if (Options.gameplayShaders){
            if (!note.note.isSustainNote){
                fuckinIntens = FlxG.random.float(-1, -0.5);
    
                // this is mainly for SS
                if (strumLines.members[3].characters[0].shader == null)strumLines.members[3].characters[0].shader = distorDad;
                if (isInvertOpponent) negativeShit = 1.0;
                //distorDad.negativity = (note.note.sustainLength > 0 ? note.note.sustainLength/1000 : 0) + FlxG.random.float(0.0475, 0.085);
            }
        }
        if (health > 0.75) {
            health -= FlxG.random.float(0.075, 0.2);// glitch damage
        }
        for (i in 0...cpuStrums.length) {
            cpuStrums.members[i].x = defaultOppX[i] + FlxG.random.int(-8, 8);
            cpuStrums.members[i].y = 50 + FlxG.random.int(-8, 8);
        }
        
        if (FlxG.random.float(0, 1) >= 0.5) {
            glitch_time += FlxG.random.float(FlxG.random.float(0.2, 0.7), FlxG.random.float(0.4, 1.4));
        }

        if (FlxG.random.float(0, 1) < 0.5) {
            camGame.shake(FlxG.random.float(0.015, 0.02), FlxG.random.float(0.0075, 0.125));
        } else {
            camHUD.shake(FlxG.random.float(0.015, 0.02), FlxG.random.float(0.0075, 0.125));
        }
    }

    // all characters that are inside dad strum will glitched
    if (!glitching && Options.gameplayShaders){
        if (curSong == "come-along-with-me" && (curStep > 384 && curStep < 608)){
            for (dads in strumLines.members[0].characters){
                if (dads.shader == distorDad || dads.shader == null)dads.shader = distorFNF;
            }
            strumGlitch = true;
        } else if(curSong == "childs-play-v2" && (curStep > 1056 && curStep < 1344)){
            for (dads in strumLines.members[0].characters){
                if (dads.shader == distorDad || dads.shader == null)dads.shader = distorFNF;
            }
            strumGlitch = true;
        }
    }

    // glitch effect
    if (!note.note.isSustainNote && note.note.strumLine != strumLines.members[2]) {
        if (FlxG.random.int(0, 1) > 0.5) {
            glitch_time = FlxG.random.float(FlxG.random.float(0.4, 1), FlxG.random.float(0.35, 0.0));
        }
    }

    shitty += (note.note.sustainLength > 0 ? note.note.sustainLength/1000+30 : 0.75);
}

function onPlayerHit(note:NoteHitEvent){
    var curNotes = note.noteType;
    
    var glitching:Bool = false;

    switch(curNotes){
        case "Attack Note":
            fuckYou = 0.09;
            glitching = !glitching;
            if (Options.gameplayShaders){
                camGame.shake(FlxG.random.float(0.015, 0.005), FlxG.random.float(0.075, 0.125));
                camHUD.shake(FlxG.random.float(0.015, 0.005), FlxG.random.float(0.075, 0.125));
    
                fuckinIntens = FlxG.random.float(-1, -0.5);
    
                // will make all of dads character glitching if you want them to not popping up just do [visible = false;]
                for (dads in strumLines.members[0].characters){
                    if (dads.shader == null || dads.shader == distorFNF)dads.shader = distorDad;
                }
                if (isInvertOpponent) negativeShit = 1.0;
                //distorDad.negativity = (note.note.sustainLength > 0 ? note.note.sustainLength/1000 : 0) + FlxG.random.float(0.0475, 0.085);
            }
            if (health > 0.75) {
                health -= FlxG.random.float(0.075, 0.2);// glitch damage
            }
            for (i in 0...cpuStrums.length) {
                cpuStrums.members[i].x = defaultOppX[i] + FlxG.random.int(-8, 8);
                cpuStrums.members[i].y = 50 + FlxG.random.int(-8, 8);
            }

        case "GF Sing":

            if (curSong == "retcon" || curSong == "my-amazing-world"){
                if (Options.gameplayShaders){
                    set_GreenShit(gfBarColor[0], gfBarColor[1], gfBarColor[2]);
                }
            }

        case null | "":
            if (curSong == "retcon" || curSong == "my-amazing-world"){
                if (Options.gameplayShaders){
                    set_GreenShit(bfBarColor[0], bfBarColor[1], bfBarColor[2]);
                }
            }
              
        }
}
function onPostNoteCreation(e){// to make it more sense because.. it's glitch note types..?
    
    e.note.forceIsOnScreen = true;
    
    if (Options.gameplayShaders){
        if (e.noteType == "Glitch Note" || e.noteType == "Second Char Glitch" || e.noteType == "Both Char Glitch") e.note.shader = distorFNF2;
    }
}