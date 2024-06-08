function postCreate(){
    iconP1.setIcon(gf.icon!=null?gf.icon:gf.curCharacter);
}

function onSongStart()
    FlxTween.tween(boyfriend, {alpha: 0.5}, 0.5);

function stepHit(curStep:Int){
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