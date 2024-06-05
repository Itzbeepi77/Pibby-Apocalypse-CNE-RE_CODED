static var iconP4:HealthIcon;

static var is2Player:Bool = false;

static var dad2 = null;// to get the character variable

function postCreate(){
    dad2 = strumLines.members[3].characters[0];

    iconP4 = new HealthIcon(dad2 != null && dad2.icon!=null?dad2.icon:dad2.curCharacter, is2Player);
    iconP4.cameras = [camHUD];
	insert(members.indexOf(iconP2)+1, iconP4);

    if (curSong == "suffering-siblings"){
        iconP4.setPosition(iconP2.x-350, iconP1.y);
    } else {
        iconP4.setPosition(iconP2.x+20, iconP1.y+20);

        iconP4.scale.set(0.7, 0.7);
    }
}

function update(elapsed:Float){
    iconP4.health = is2Player? iconP1.health : iconP2.health;
    
    if (is2Player){
        if (healthBar.percent < 20){
            if (Options.gameplayShaders && doGlitchIconEffect) iconP4.shader = glitches;
        } else {
            iconP4.shader = null;
        }
    } else {
        if (healthBar.percent > 80){
            if (Options.gameplayShaders && doGlitchIconEffect) iconP4.shader = glitches;
        } else {
            iconP4.shader = null;
        }
    }
}