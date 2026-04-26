switch(curSong){
    case "mindless-v2", "childs-play-v2", "wretched_gems":
        importScript("data/scripts/vsliceCam");
}

function onCountdown(event) {// countdown thingy (vslice shit)
    switch(curSong){
        case 'childs-play-v2':
            switch(event.swagCounter) {
                case 0:
                    tweenCamZoom(camera.zoom+0.06,0,true);
                        bfIntro.playAnim('3', true);
                        boyfriend.alpha = 0.0001; 
                        bfIntro.alpha = 1; 
                        countNum.animation.play('3', true);
                        countNum.alpha = 1;
    
                case 1: 
                    tweenCamZoom(camera.zoom+0.06,0,true);
                        bfIntro.playAnim('2', true); 
                        countNum.animation.play('2', true);
    
                case 2:
                    tweenCamZoom(camera.zoom+0.06,0,true);
                        //camera.zoom += 0.03; 
                        bfIntro.playAnim('1', true); 
                        countNum.animation.play('1', true);
    
                case 3: 
                    tweenCamZoom(camera.zoom-0.18,0.1,false);
                        bfIntro.playAnim('go'); 
                        countNum.animation.play('Go', true);
                        //camHUD.visible = true; 
                        //camHUD.flash(FlxColor.WHITE, 0.25);

                case 4:
                    boyfriend.alpha = 1;
                    bfIntro.alpha = 0.001; 
                    countNum.alpha = 0.001;
            }
    }
}
function postCreate(){
    if(curSong == "childs-play-v2"){
        startFromPlayer = true;
        setCameraPos(boyfriend.getCameraPosition().x, boyfriend.getCameraPosition().y);
    }
}
function onSongStart(){
    if(curSong == "childs-play-v2") setCameraPos(dad.getCameraPosition().x, dad.getCameraPosition().y);
}