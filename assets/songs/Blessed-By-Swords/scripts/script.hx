function postCreate(){
    iconP1.setIcon(gf.icon!=null?gf.icon:gf.curCharacter);
    
    strumLines.members[0].characters[1].visible = false;
}

function onSongStart()
    FlxTween.tween(boyfriend, {alpha: 0.5}, 0.5);

function stepHit(curStep:Int){
    if (curStep == 831 || curStep == 909 || curStep == 942 || curStep == 991 || curStep == 1079 || curStep == 1087){
        strumLines.members[0].characters[1].alpha = 1;
        strumLines.members[0].characters[1].visible = true;
        strumLines.members[0].characters[0].alpha = 0.0001;
    }

    if (curStep == 836 || curStep == 912 || curStep == 945 || curStep == 995 || curStep == 1081 || curStep == 1091){
        strumLines.members[0].characters[0].alpha = 1;
        strumLines.members[0].characters[1].visible = false;
        strumLines.members[0].characters[1].alpha = 0.0001;
    }

    if (curStep == 1347 || curStep == 1352 || curStep == 1356 || curStep == 1363 || curStep == 1379 || curStep == 1395){
        strumLines.members[0].characters[1].alpha = 1;
        strumLines.members[0].characters[1].visible = true;
        strumLines.members[0].characters[0].alpha = 0.0001;
    }

    if (curStep == 1349 || curStep == 1353 || curStep == 1357 || curStep == 1365 || curStep == 1391 || curStep == 1397){
        strumLines.members[0].characters[0].alpha = 1;
        strumLines.members[0].characters[1].visible = false;
        strumLines.members[0].characters[1].alpha = 0.0001;
    }
    
    if (curStep == 496){
        camGame.alpha = 0.001;
        camHUD.alpha = 0.001;
    }
    if (curStep == 524){
        camHUD.flash();
        camGame.alpha = 1;
        camHUD.alpha = 1;
    }
}