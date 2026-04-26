var anglePart = false;

var angleVar:Float = 1;
var angleShit:Float = 1;

function beatHit(curBeat) {
    switch(curBeat){
        case 64, 160, 384, 576, 720:
            camZoomingInterval = 1;
            camZoomingStrength = 1.5;
            camGame.flash();
            anglePart = true;
        
        case 120, 216, 448, 697, 832:
            camZoomingInterval = 4;
            camZoomingStrength = 1;
            anglePart = false;
            camHUD.angle = 0;
            camera.angle = 0;
    }
    if (curBeat == 832){
        camHUD.fade(FlxColor.BLACK, 2.5);
    }

    if (!kys && anglePart) {
        if (curBeat % 2 == 0) {
            angleShit = angleVar;
        } else {
            angleShit = -angleVar;
        }
        camHUD.angle = angleShit * 1.5;
        camera.angle = angleShit * 1.5;
        FlxTween.tween(camHUD, {angle: angleShit}, Conductor.stepCrochet * 0.002, {ease: FlxEase.circOut});
        FlxTween.tween(camera, {angle: angleShit}, Conductor.stepCrochet * 0.002, {ease: FlxEase.circOut});
        FlxTween.tween(camHUD, {x: -angleShit*2}, Conductor.crochet * 0.001, {ease: FlxEase.linear});
        FlxTween.tween(camera, {x: -angleShit*2}, Conductor.crochet * 0.001, {ease: FlxEase.linear});
    }

}