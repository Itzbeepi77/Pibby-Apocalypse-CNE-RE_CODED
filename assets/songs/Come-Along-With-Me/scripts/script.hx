importScript("data/scripts/healthBar-Finn_Jake");

function postCreate(){
    for (shit in [iconP1,iconP2])shit.alpha = 0.001;

    camera.alpha = 0.001;
    camHUD.alpha = 0.001;
    
}

var dadCamZoom:Int = 0.8;
function onCameraMove(e){
    switch(curCameraTarget){
        case 0:
            defaultCamZoom = dadCamZoom;

        case 1:
            defaultCamZoom = 1.1;
    }
}
function onSongStart(){
    camera.alpha = 1;
    camera.flash(FlxColor.BLACK, 10);
    for (i in playerStrums.members){
        i.alpha = 0.001;
    }
}
function postUpdate(elapsed){
    if (curStep == 640){
        for (shit in [iconP1,iconP2])FlxTween.tween(shit, {alpha: 1}, 0.5);
        FlxTween.tween(bar, {alpha: 1}, 0.5);
    }
}
function stepHit(curStep:Int){
    if (curStep == 128){
        camHUD.alpha = 1;
    }
    if (curStep == 186){
        for (i in playerStrums.members){
            FlxTween.tween(i, {alpha: 1}, 0.5);
        }
    }
    if (curStep == 1032){
        camHUD.alpha = 0.001;
    }
    if (curStep == 1040){
        camHUD.alpha = 1;
    }
    if (curStep == 2432){
        camHUD.visible = false;
        boyfriend.visible = false;
        dad.visible = false;
    }
    if (curStep == 1787){
        dad.cameras = [camCinema];
        boyfriend.cameras= [camCinema];
        dad.scrollFactor.set();
        boyfriend.scrollFactor.set();
        boyfriend.angle = 180;
        boyfriend.x = 770;
        boyfriend.y = -1000;
        dad.x = 100;
        dad.y = 700;
    }
    if (curStep == 1792){
        boyfriend.color = 0xFFFFFFFFF;
        camHUD.alpha = 1;
        for (shit in [iconP1,iconP2,hudTxt,bar,timeBar,timeBarBG])shit.alpha = 0.001;
        FlxTween.tween(timeTxt, {y: timeTxt.y-75}, 2.5, {ease: FlxEase.expoOut});
        FlxTween.tween(dad, {y: 100}, 5, {ease: FlxEase.expoOut});
        FlxTween.tween(boyfriend, {y: -500}, 5, {ease: FlxEase.expoOut});
    }
    if (curStep == 2176){
        FlxTween.tween(camHUD, {alpha: 0.001}, 5, {ease: FlxEase.expoOut});
    }

    if (curStep == 378) {
        dadCamZoom = 1;
        FlxTween.tween(camHUD, {alpha: 0.001}, 0.75, {ease: FlxEase.expoOut});
    }
    if (curStep == 384) {
        dadCamZoom = 0.8;
        FlxTween.tween(camHUD, {alpha: 1}, 2.5, {ease: FlxEase.expoOut});
    }
    if (curStep == 640) {
        dadCamZoom = 0.75;
    }
    if (curStep == 720) {
        dadCamZoom = 0.9;
    }
    if (curStep == 736) {
        dadCamZoom = 0.8;
    }
    if (curStep == 896) {
        dadCamZoom = 0.7;
    }
    if (curStep == 1024) {
        dadCamZoom = 1;
    }
    if (curStep == 1040) {
        dadCamZoom = 0.7;
    }
    if (curStep == 1520) {
        FlxTween.tween(camera, {alpha: 0.001}, 1.75, {ease: FlxEase.expoOut});
        FlxTween.tween(camera, {zoom: 1.2}, 1, {ease: FlxEase.expoOut});
    }
    if (curStep == 1536) {
        dadCamZoom = 0.75;
        FlxTween.tween(camera, {alpha: 1}, 15, {ease: FlxEase.expoOut});
    }
    if (curStep == 1648){
        dadCamZoom = 0.7;
    }
    if (curStep == 1536){
        dadCamZoom = 0.8;
    }
    if (curStep == 1664){
        dadCamZoom = 0.7;
    }
}