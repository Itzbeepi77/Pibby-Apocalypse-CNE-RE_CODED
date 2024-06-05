function onCountdown(event) {// countdown thingy
    switch(curSong){
        case 'suffering-siblings', 'brotherly-love', 'blessed-by-swords', 'what-am-i':
            switch(event.swagCounter) {
                case 0:
                    camera.zoom += 0.06;
                    bfIntro.playAnim('3', true);
                    pibbyIntro.playAnim('3', true); 
                    boyfriend.alpha = 0.0001; 
                    bfIntro.alpha = 1; 
                    pibbyIntro.alpha = 1; 
                    gf.alpha = 0.0001;
                    countNum.animation.play('3', true);
                    countNum.alpha = 1;

                case 1: 
                    camera.zoom += 0.06; 
                    bfIntro.playAnim('2', true); 
                    pibbyIntro.playAnim('2', true);
                    countNum.animation.play('2', true);

                case 2:
                    camera.zoom += 0.06; 
                    bfIntro.playAnim('1', true); 
                    pibbyIntro.playAnim('1', true);
                    countNum.animation.play('1', true);

                case 3: 
                    FlxTween.tween(camera, {zoom: defaultCamZoom}, 0.1); // for zoom back to their default camZoom
                    bfIntro.playAnim('go'); 
                    pibbyIntro.playAnim('go'); 
                    camHUD.visible = true; 
                    camHUD.flash(FlxColor.WHITE, 0.25);
                    countNum.animation.play('Go', true);

                    case 4:
                        boyfriend.alpha = 1;
                        bfIntro.alpha = 0.001; 
                        gf.alpha = 1;
                        pibbyIntro.alpha = 0.001; 
                        countNum.alpha = 0.001;
            }
        
        case 'retcon', 'childs-play':
            switch(event.swagCounter) {
                case 0:
                        FlxTween.tween(camera, {zoom: defaultCamZoom +0.03}, 0.05);
                        //camera.zoom += 0.03;
                        bfIntro.playAnim('3', true);
                        boyfriend.alpha = 0.0001; 
                        bfIntro.alpha = 1; 
                        countNum.animation.play('3', true);
                        countNum.alpha = 1;
    
                case 1: 
                        FlxTween.tween(camera, {zoom: defaultCamZoom +0.06}, 0.05);
                        //camera.zoom += 0.03; 
                        bfIntro.playAnim('2', true); 
                        countNum.animation.play('2', true);
    
                case 2:
                        FlxTween.tween(camera, {zoom: defaultCamZoom +0.09}, 0.05);
                        //camera.zoom += 0.03; 
                        bfIntro.playAnim('1', true); 
                        countNum.animation.play('1', true);
    
                case 3: 
                        if (curSong != 'retcon') FlxTween.tween(camera, {zoom: defaultCamZoom}, 0.1);
                        if (curSong == 'retcon') FlxTween.tween(camera, {zoom: defaultCamZoom-0.03}, 0.1);
                        //camera.zoom -= 0.06; // for zoom back to their default camZoom
                        bfIntro.playAnim('go'); 
                        countNum.animation.play('Go', true);
                        //camHUD.visible = true; 
                        //camHUD.flash(FlxColor.WHITE, 0.25);

                case 4:
                    boyfriend.alpha = 1;
                    bfIntro.alpha = 0.001; 
                    countNum.alpha = 0.001;
            }

        default:
            switch(event.swagCounter) {
                case 0:
                        countNum.animation.play('3', true);
                        countNum.alpha = 1;
    
                case 1: 
                        countNum.animation.play('2', true);
    
                case 2:
                        countNum.animation.play('1', true);
    
                case 3: 
                        countNum.animation.play('Go', true);

                case 4:
                    countNum.alpha = 0.001;
            }
    }
}
function postCreate() {
    Conductor.changeBPM(90);

    switch(curSong){
        case 'suffering-siblings', 'brotherly-love', 'blessed-by-swords', 'what-am-i', 'retcon', 'childs-play':
            curCameraTarget = 1;
    }
}
function onSongStart(){
    trace("Countdown Shits");

    Conductor.changeBPM(Conductor.bpm);

    if (curSong != 'suffering-siblings')
        curCameraTarget = 0;
}