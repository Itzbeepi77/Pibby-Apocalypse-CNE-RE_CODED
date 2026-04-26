static var isPlayer:Bool = true;

static var iconP3:HealthIcon;

function postCreate(){    
    iconP3 = new HealthIcon(gf != null && gf.icon!=null?gf.icon:gf.curCharacter, isPlayer);
    iconP3.cameras = [camHUD];
	insert(members.indexOf(iconP1)+1, iconP3);

    if (curSong == "retcon" || curSong == "my-amazing-world"){
        iconP3.setPosition(iconP1.x-20, iconP1.y+20);

        iconP3.scale.set(0.8, 0.8);
    } else {
        iconP3.setPosition(iconP1.x+350, iconP1.y);
    }

    if (curSong == "my-amazing-world") iconP3.alpha = 0.001;
}

function postUpdate(elapsed){
    if (curSong == "retcon" || curSong == "my-amazing-world"){
        for (i in [inst, vocals]){
            lerpVal = FlxMath.bound((elapsed * 9 * i.pitch), 0, 1);
        }
        iconP3.scale.set(lerp(iconP3.scale.x, 0.8, lerpVal), lerp(iconP3.scale.y, 0.8, lerpVal));
    }
}

function beatHit(curBeat){
    if (curSong == "retcon" || curSong == "my-amazing-world")
        iconP3.scale.set(1, 1);
}

function update(elapsed){
    iconP3.health = isPlayer? iconP1.health : iconP2.health;

    if (isPlayer){
        if (healthBar.percent < 20){
            if (Options.gameplayShaders && doGlitchIconEffect) iconP3.shader = distorFNF;
        } else {
            iconP3.shader = null;
        }
    } else {
        if (healthBar.percent > 80){
            if (Options.gameplayShaders && doGlitchIconEffect) iconP3.shader = distorFNF;
        } else {
            iconP3.shader = null;
        }
    }
}