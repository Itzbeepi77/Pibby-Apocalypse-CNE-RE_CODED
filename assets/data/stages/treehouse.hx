function create(){

    camOverlay.screenCenter();
    camOverlay.cameras = [camHUD];

    vignette = new FlxSprite(0, 0).loadGraphic(Paths.image('vignette'));
    vignette.updateHitbox();
    vignette.cameras = [camHUD];
    vignette.alpha = 0.0001;
    add(vignette);

    boyfriend.color = 0x9B9B90F0;// coloring it :D

}
function postUpdate(){
    if (curStep == 896 || curStep == 1664){
        for (guh in [dad,boyfriend]){
            guh.scale.set(0.7,0.7);
        }
    }
}
function stepHit(curStep:Int){
        if (curSong == "come-along-with-me"){
            if (curStep == 1536) {
                //camHUD.flash();
                boyfriend.alpha = 0.0001;
                bgHeaven.alpha = 1;
                uhhIdfk.alpha = 1;
                things.alpha = 1;
                bg.alpha = 0.0001;
                treehouse.alpha = 0.0001;
                //thunder.alpha = 0.0001;
                //rain.alpha = 0.001;
    
            }
            if (curStep == 1648)
            {
                camHUD.flash();
                bgHeaven.alpha = 0.0001;
                uhhIdfk.alpha = 0.0001;
                things.alpha = 0.0001;
                bgGlitch.alpha = 1;
                lightG.alpha = 1;
                hill.alpha = 1;
                particles.alpha = 1;
                dangling.alpha = 1;
                corruption.alpha = 1;
            }
    
            if (curStep == 640)
            {
                vignette.alpha = 1;
    
                for (obj in [bgGlitch,lightG,hill,particles,dangling,corruption]){
                    FlxTween.tween(obj, {alpha: 1}, 1, {ease: FlxEase.quadInOut});
                }

                boyfriend.alpha = 0.0001;
            }
            if (curStep == 896) {
    
                camHUD.flash();
                bgGlitch.alpha = 0.0001;
                lightG.alpha = 0.0001;
                hill.alpha = 0.0001;
                particles.alpha = 0.0001;
                dangling.alpha = 0.0001;
                corruption.alpha = 0.0001;
                bg.alpha = 1;
                treehouse.alpha = 1;
                //thunder.alpha = 1;
                //rain.alpha = 1;

                boyfriend.alpha = 1;
    
                vignette.alpha = 1;
            }
            if (curStep == 1664) {
    
                camHUD.flash();
                bgGlitch.alpha = 0.0001;
                lightG.alpha = 0.0001;
                hill.alpha = 0.0001;
                particles.alpha = 0.0001;
                dangling.alpha = 0.0001;
                corruption.alpha = 0.0001;
    
                bg.alpha = 1;
                treehouse.alpha = 1;
                //thunder.alpha = 1;
                //rain.alpha = 1;
                
                boyfriend.alpha = 1;
            }
            if (curStep == 608){
                for (obj in [bgHeaven,uhhIdfk,things]){
                    FlxTween.tween(obj, {alpha: 0.0001}, 1, {ease: FlxEase.quadInOut});
                }
            }
            if (curStep == 848){
                FlxTween.tween(camera, {alpha: 0.0001}, 3, {ease: FlxEase.quadInOut});
            }
            if (curStep == 896){
                camera.alpha = 1;
            }
            if (curStep == 1754){
                for (obj in [bg,treehouse]){
                    FlxTween.tween(obj, {alpha: 0.0001}, 1, {ease: FlxEase.quadInOut, startDelay: 0.7});
                }
                FlxTween.tween(camera, {alpha: 0.0001}, 1, {ease: FlxEase.quadInOut, startDelay: 1});
                FlxTween.tween(camHUD, {alpha: 0.0001}, 1, {ease: FlxEase.quadInOut, startDelay: 1});
            }
    }
}
