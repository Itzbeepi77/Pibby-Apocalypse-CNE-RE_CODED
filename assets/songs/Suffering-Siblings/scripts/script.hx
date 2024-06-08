var pAngy = null;
function create(){
	remove(strumLines.members[3].characters[0]);

	insert(members.indexOf(dad), strumLines.members[3].characters[0]);

	pAngy = strumLines.members[2].characters[1];

	pAngy.alpha = 0.000000001;
}
function stepHit(curStep){
	if (curStep == 2080){
        stage.getSprite("bg").alpha = 0.001;
        
        if (!lowMem){
            stage.getSprite("light").visible = false;
            stage.getSprite("bulb").visible = false;
            stage.getSprite("dark").visible = false;
        }
		gf.alpha = 0.001;
		strumLines.members[3].characters[0].alpha = 0.001;
		
		boyfriend.alpha = 1;
	}
	if (curStep == 2374){
		gf.alpha = 0.000000001;
		pAngy.alpha = 1;
	}
	if (curStep == 2048){
		curCameraTarget = -1;
		camFollow.x = 1700;
		camFollow.y -= 100;
	}
	if (curStep == 2336){
        stage.getSprite("bg").alpha = 1;
        
        if (!lowMem){
            stage.getSprite("light").visible = true;
            stage.getSprite("bulb").visible = true;
            stage.getSprite("dark").visible = true;
        }
		gf.alpha = 1;
		strumLines.members[3].characters[0].alpha = 1;
	}
	if (curStep == 128){
		camHUD.alpha = 1;
	}
	if (curStep == 1696){
		dad.alpha = 0.5;
		boyfriend.alpha = 0.5;
	}
	if (curStep == 1832){
		dad.alpha = 1;
	}
	if (curStep == 3360){
		dad.alpha = 0.000000001;
		strumLines.members[3].characters[0].visible = false;

		camera.alpha = 0.001;
	}
	if (curStep == 3392){
		camera.alpha = 1;
	}
	if (curStep == 0){
		defaultCamZoom = 0.7;
	}
}

function onSongStart(){
	curCameraTarget = -1;
	camFollow.x = 1700;
	camFollow.y -= 200;
	defaultCamZoom = 0.7;

	camera.zoom = 0.7;

	camera.flash(FlxColor.BLACK, 10);
}

// note shit
var shits = ["LEFT","DOWN","UP","RIGHT"];
function onPlayerHit(e){
	if (e.noteType == "Attack Note"){
		dad.playAnim("sing"+shits[e.direction]+"-hurt", true);
	}
}