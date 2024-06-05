public var glitches = new CustomShader("NewGlitch2");
public var distorDad = new CustomShader("distortShader");
public var aberration = new CustomShader('chromaticAberration');
public var pibbyShader = new CustomShader('glitchThingy');
static var bloom = new CustomShader('bloom');// bloom shader

var defaultOppX = [];
var defaultPlayX = [];
var data:Map<Int, {lastNote:{time:Float, id:Int}}> = [];

static var doDoubles = FlxG.save.data.doubleShit;
static var doGlitch = FlxG.save.data.shaderShit;
static var doGlitchEffect = FlxG.save.data.glitchShit;

static var doGlitchIconEffect = FlxG.save.data.glitchIcon;

function postCreate(){
    if(Options.gameplayShaders) {

        for (i in cpuStrums.members){
            switch(curSong){
                default:
                    i.shader = glitches;
                case "childs-play", "come-along-with-me":
                    i.shader = null;
            }
        }

        setGeneralIntensity(0.001);

        camGame.addShader(aberration);
        camHUD.addShader(aberration);
        camGame.addShader(pibbyShader);
        camHUD.addShader(pibbyShader);
        camGame.addShader(bloom);

        if(curSong == "come-along-with-me"){
            camCinema.addShader(aberration);
            camCinema.addShader(pibbyShader);
        }

        pibbyShader.iMouseX = 500;
        pibbyShader.NUM_SAMPLES = 3;
        bloom.size = 0.0;
    }
    
    // to get the number of each positions of the strums member
    for (i in cpuStrums.members) {defaultOppX.push(i.x);}
    for (i in playerStrums.members) {defaultPlayX.push(i.x);}

	for (sl in strumLines.members){
		data[strumLines.members.indexOf(sl)] = {
            lastNote: {
                time: -9999,
                id: -1
            }
        };
    }
}

var intens:Float = 0;
function setGeneralIntensity(val:Float) {
	intens = val;
	aberration.redOff = [intens, 0];
	aberration.blueOff = [-intens, 0];
}

var canBump:Bool = camZooming;
function aberrationCoolThing() {
	canBump = !canBump;
	if(!canBump) {
		if(Options.gameplayShaders) setGeneralIntensity(0.001);  // Just to make sure if anything goes wrong
		maxCamZoom = 1.35;
	} else maxCamZoom = 0;
}

function onEvent(e){
    if (e.event.name == "AppleFilter"){
        if (e.event.params[0])
            if (Options.gameplayShaders) bloom.size = 9.0;
        else 
            if (Options.gameplayShaders) bloom.size = 0.0;
    }
}

function onGameOver() {
    camGame.removeShader(aberration);
    camGame.removeShader(pibbyShader);
    camGame.removeShader(bloom);
}

function stepHit(curStep:Int){
    if (Options.gameplayShaders){
        var distortIntensity:Float = FlxG.random.float(4, 6);
        glitches.binaryIntensity = distortIntensity;
    }
}

function beatHit(curBeat:Float) {
	if(camZooming && curBeat % camZoomingInterval == 0) {
		if(Options.gameplayShaders) setGeneralIntensity(0.01);
	}
}

// lmao it's glitching time >:)
static var glitch_time:Float = 0;
static var glitchTimeValue:Float = 0;
var distorShit:Float = 0;
function update(elapsed) {
    if (Options.gameplayShaders){
        if(camZooming && intens > (0.0005)) setGeneralIntensity(intens - (0.001));// chrom abb thingy

        pibbyShader.glitchMultiply = glitch_time;
		glitch_time = lerp(glitch_time, 0, FlxMath.bound(elapsed * 7, 0, 1));

        glitchTimeValue += elapsed;
        pibbyShader.uTime = glitchTimeValue;
    
        // icon glitching (more icons are in [data/scripts/])
        if (doGlitchIconEffect){
            if (healthBar.percent < 20){
                iconP1.shader = glitches;
            } else {
                iconP1.shader = null;
            }
            if (healthBar.percent > 80){
                iconP2.shader = glitches;
            } else {
                iconP2.shader = null;
            }
        }
    
        if (distorShit > 0) {// turn off the shader when it's not the type of note
            distorShit -= elapsed;
            if(distorShit <= 0) {
                distorShit = 0;
                
                // all characters that are inside dad strum will glitched
                for (dads in strumLines.members[0].characters){
                    if (dads.shader == distorDad || dads.shader == glitches)dads.shader = null;
                }
    
                // to prevent error without add more shits
                if (strumLines.members[3] != null && strumLines.members[3].characters[0].shader == distorDad)
                    strumLines.members[3].characters[0].shader = null;
            }
        }
    }
}

// this is interesting..
// also inakuro if you want to use it just becarefull
function onDadHit(note:NoteHitnote){

    var curNotes = note.noteType;
    
    var glitching:Bool = false;
    isJakePlay = false;

    // for double note glitch or shaking..
    // whatever
    var target = data[strumLines.members.indexOf(note.note.strumLine)];
    var doShits = (note.note.strumTime - target.lastNote.time) <= 2 && note.note.noteData != target.lastNote.id;
    target.lastNote.time = note.note.strumTime;
    target.lastNote.id = note.note.noteData;
    
    if (curNotes == "Second Char Sing" || curNotes == "Second Char Glitch"){// second opponen char singing
        isJakePlay = true;
        note.characters = strumLines.members[3].characters;
    }

    switch(dad.curCharacter) {
        case "dad", "gumball", "cumball", "finn-R", "jake", "finn-slash", "finn-sword", "finn-sword-shad", "finncawm", 
            "finncawm_reveal", "finncawm_start_new", "finnfalse", "badfinn", "finnanimstuff", "finn-hurt", "steven":
            if(doShits && doDoubles){
                if (note.note.isSustainNote) return;
                    if (FlxG.random.float(0, 1) < 0.5) {
                        camGame.shake(FlxG.random.float(0.015, 0.02), FlxG.random.float(0.075, 0.125));
                    } else {
                        camHUD.shake(FlxG.random.float(0.015, 0.02), FlxG.random.float(0.075, 0.125));
                        for (i in 0...cpuStrums.length) {
                            cpuStrums.members[i].x = defaultOppX[i] + FlxG.random.int(-8, 8);
                            cpuStrums.members[i].y = 50 + FlxG.random.int(-8, 8);
                        }
                        if (boyfriend.curCharacter == "darwin-fw"){
                            for (i in 0...playerStrums.length) {
                                playerStrums.members[i].x = defaultPlayX[i] + FlxG.random.int(-8, 8);
                                playerStrums.members[i].y = 50 + FlxG.random.int(-8, 8);
                            }
                        }
                    }
                if (health > 0.75) {
                    health -= FlxG.random.float(0.075, 0.2);// glitch damage
                }
            }
    }

    if (curNotes == "Glitch Note" || curNotes == "Both Char Glitch"){// make the opponent glitching
        distorShit = 0.1;
        glitching = !glitching;
        if (Options.gameplayShaders && doGlitchEffect){
            if (!note.note.isSustainNote){
            distorDad.binaryIntensity = FlxG.random.float(-1, -0.5);

            // will make all of dads character glitching if you want them to not popping up just do [visible = false;]
            for (dads in strumLines.members[0].characters){
                if (dads.shader == null || dads.shader == glitches)dads.shader = distorDad;
            }
                distorDad.negativity = (note.note.sustainLength > 0 ? note.note.sustainLength/1000 : 0) + FlxG.random.float(1.0, 2.0);
            }
        }
        if (health > 0.75) {
            health -= FlxG.random.float(0.075, 0.2);// glitch damage
        }
        for (i in 0...cpuStrums.length) {
            cpuStrums.members[i].x = defaultOppX[i] + FlxG.random.int(-8, 8);
            cpuStrums.members[i].y = 50 + FlxG.random.int(-8, 8);
        }
    }

    if (curNotes == "Second Char Glitch"){// make the second opponent glitching
        distorShit = 0.1;
        glitching = !glitching;
        if (Options.gameplayShaders && doGlitchEffect){
            if (!note.note.isSustainNote){
            distorDad.binaryIntensity = FlxG.random.float(-1, -0.5);

            // this is mainly for SS
            if (strumLines.members[3].characters[0].shader == null)strumLines.members[3].characters[0].shader = distorDad;
                distorDad.negativity = (note.note.sustainLength > 0 ? note.note.sustainLength/1000 : 0) + FlxG.random.float(1.0, 2.0);
            }
        }
        if (health > 0.75) {
            health -= FlxG.random.float(0.075, 0.2);// glitch damage
        }
        for (i in 0...cpuStrums.length) {
            cpuStrums.members[i].x = defaultOppX[i] + FlxG.random.int(-8, 8);
            cpuStrums.members[i].y = 50 + FlxG.random.int(-8, 8);
        }
    }

    if (!glitching && Options.gameplayShaders && doGlitchEffect){
        distorDad.binaryIntensity = 0;
        distorDad.negativity = 0;
        
            // all characters that are inside dad strum will glitched
            if (curSong == "come-along-with-me" && curStep > 384 && curStep < 608){
                for (dads in strumLines.members[0].characters){
                    if (dads.shader == distorDad || dads.shader == null)dads.shader = glitches;
                }
                for (i in cpuStrums.members){
                    i.shader = glitches;
                }
            } else {
                for (dads in strumLines.members[0].characters){
                    if (dads.shader == distorDad || dads.shader == glitches)dads.shader = null;
                }
            } 

            // to prevent error without add more shits
            if (strumLines.members[3] != null && strumLines.members[3].characters[0].shader == distorDad)
                strumLines.members[3].characters[0].shader = null;
    }
    if (!note.note.isSustainNote && note.note.strumLine != strumLines.members[2] && doGlitch) {
        if (FlxG.random.int(0, 1) == 0) {
            glitch_time = FlxG.random.float(0.2, 0.7);
        }
    }
}
function onNoteCreation(e)// to make it more sense because.. it's glitch note types..?
    if (Options.gameplayShaders){
        if (e.noteType == "Glitch Note" || e.noteType == "Second Char Glitch" || e.noteType == "Both Char Glitch") e.note.shader = glitches;
    }