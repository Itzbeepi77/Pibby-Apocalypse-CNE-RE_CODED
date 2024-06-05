var fSword = null;
var fSlash = null;
var fHurt = null;
var bSword = null;
var pAngy = null;
function create(){
	remove(strumLines.members[3].characters[0]);

	insert(members.indexOf(dad), strumLines.members[3].characters[0]);

	fSword = strumLines.members[0].characters[2];
	fSlash = strumLines.members[0].characters[1];
	fHurt = strumLines.members[0].characters[3];
	bSword = strumLines.members[1].characters[1];
	pAngy = strumLines.members[2].characters[1];
	
	bSword.y -= 100;

	for (shits in [bSword, pAngy]) shits.alpha = 0.000000001;
	for (mfs in [fSword, fSlash, fHurt]){
		mfs.alpha = 0.0001;
		mfs.visible = false;
	}
}
function stepHit(curStep){
	switch (curStep){
		case 2112, 2176, 2180, 2184, 2190, 2196, 2199, 2203, 2206, 2272:
			fSlash.alpha = 0.0001;
			fSlash.visible = false;
			fHurt.visible = true;
			fHurt.alpha = 1;

		case 2136, 2178, 2181, 2186, 2194, 2198, 2202, 2208:
			fSlash.alpha = 1;
			fSlash.visible = true;
			fHurt.visible = false;
			fHurt.alpha = 0.0001;
	}

	if (curStep == 2080){
        stage.getSprite("bg").alpha = 0.001;
        
        if (!lowMem){
            stage.getSprite("light").visible = false;
            stage.getSprite("bulb").visible = false;
            stage.getSprite("dark").visible = false;
        }
		gf.alpha = 0.001;
		strumLines.members[3].characters[0].alpha = 0.001;
	}
	if (curStep == 2374){
		gf.alpha = 0.000000001;
		pAngy.alpha = 1;
	}
	if (curStep == 2080){
		curCameraTarget = -1;
		camFollow.x = 1700;
		defaultCamZoom = 0.7;
	}
	if (curStep == 2071){
		dad.alpha = 0.000000001;
		fSlash.visible = true;
		fSlash.alpha = 1;

		boyfriend.alpha = 0.000000001;
		bSword.alpha = 1;
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

		fSword.alpha = 1;
		fSword.visible = true;
		fHurt.visible = false;
		fHurt.alpha = 0.0001;

		boyfriend.alpha = 1;
		bSword.alpha = 0.000000001;
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
		fSword.alpha = 0.0001;
		fSword.visible = false;
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

var anims = ["LEFT", "DOWN", "UP", "RIGHT"];
function onPlayerHit(e){
	if (e.noteType == "Attack Note"){
		fHurt.playAnim("sing" + anims[e.direction], true);
	}
}