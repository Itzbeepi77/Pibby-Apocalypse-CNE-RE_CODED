function create(){
    camera.alpha = 0.001;
}
function onSongStart(){
    camera.alpha = 1;
    camCinema.flash(FlxColor.BLACK, 30);
}
function stepHit(curStep){
    if (curStep == 2096){
        camera.fade(FlxColor.BLACK, 5);
        FlxTween.tween(camHUD, {alpha: 0.001}, 5, {ease:FlxEase.sineInOut});
    }
}