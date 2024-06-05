function create(){
    camera.alpha = 0.001;
}
function onSongStart(){
    camera.alpha = 1;
    camera.flash(FlxColor.BLACK, 20);
}
function stepHit(curStep){
    if (curStep == 2096){
        camera.fade(FlxColor.BLACK, 5);
        FlxTween.tween(camHUD, {alpha: 0.001}, 5, {ease:FlxEase.sineInOut});
    }
}