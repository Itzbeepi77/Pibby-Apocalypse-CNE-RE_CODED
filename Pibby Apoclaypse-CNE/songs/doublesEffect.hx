public var doDoubles = FlxG.save.data.doubleShit;

var data:Map<Int, {lastNote:{time:Float, id:Int}}> = [];

function create(){
	for (sl in strumLines.members){
		data[strumLines.members.indexOf(sl)] = {
            lastNote: {
                time: -9999,
                id: -1
            }
        };
    }
}

function onDadHit(e){
    
    var glitching:Bool = false;

    // for double note glitch or shaking..
    // whatever
    var target = data[strumLines.members.indexOf(e.note.strumLine)];
    var doShits = (e.note.strumTime - target.lastNote.time) <= 2 && e.note.noteData != target.lastNote.id;
    target.lastNote.time = e.note.strumTime;
    target.lastNote.id = e.note.noteData;

    switch(dad.curCharacter) {
        case "dad", "gumball", "cumball", "finn-R", "jake", "finn-slash", "finn-sword", "finn-sword-shad", "finncawm", 
            "finncawm_reveal", "finncawm_start_new", "finnfalse", "badfinn", "finnanimstuff", "finn-hurt", "steven":
            if(doShits && doDoubles){
                if (e.note.isSustainNote) return;
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

                    if (dad.curCharacter != "finncawm_start_new"){
                        if (FlxG.random.float(0,1) < 0.5){
                            fuckYou = 0.1;
                            glitching = !glitching;
                            if (Options.gameplayShaders){
                    
                                fuckinIntens = FlxG.random.float(-1, -0.5);
                    
                                // will make all of dads character glitching if you want them to not popping up just do [visible = false;]
                                if (isJakePlay){ // to prevent error without add more shits
                                    if (strumLines.members[3] != null && strumLines.members[3].characters[0].shader == null)
                                        strumLines.members[3].characters[0].shader = distorDad;
                                } else {
                                        for (dads in strumLines.members[0].characters){
                                            if (dads.shader == null || dads.shader == distorFNF)dads.shader = distorDad;
                                        }
                                    }
    
                                if (isInvertOpponent) negativeShit = 1.0;
                                //distorDad.negativity = (note.note.sustainLength > 0 ? note.note.sustainLength/1000 : 0) + FlxG.random.float(0.0475, 0.085);
                            }
                        } else {
                            if (isJakePlay){
                                if (strumLines.members[3] != null && strumLines.members[3].characters[0].shader != null)
                                    strumLines.members[3].characters[0].shader = null;
                            } else {
                                for (dads in strumLines.members[0].characters){
                                    if (dads.shader != null || dads.shader == distorFNF)dads.shader = null;
                                }
                            }
                        }
                    }
                if (health > 0.75) {
                    health -= FlxG.random.float(0.075, 0.2);// glitch damage
                }
            }

        default: continue;
    }
}