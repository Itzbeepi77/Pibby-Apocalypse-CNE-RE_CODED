function stepHit(){
    switch(curStep){
        case 96: 
            FlxTween.tween(camGame, {zoom: 1.24}, 6.7, {ease: FlxEase.sineInOut, onComplete: _->
                FlxTween.tween(camHUD, {alpha: 0}, 1, {ease: FlxEase.sineInOut})
            });
    
        case 176 | 180 | 184: camGame.zoom += 0.05;
    
        case 192:
            camGame.flash(FlxColor.WHITE, 1);
            FlxTween.tween(camHUD, {alpha: 1}, 1, {ease: FlxEase.sineInOut});
            //iconP2.color = 0xFFFFFF;
    
        case 294 | 422 | 646 | 774 | 1110: 
            defaultCamZoom = 1;
            camGame.zoom = 1;
    
        case 298 | 426 | 650 | 778 | 1114: 
            defaultCamZoom = 1.1;
            camGame.zoom = 1.1;
    
        case 302 | 430 | 656 | 784 | 1118: 
            defaultCamZoom = 0.8;
    
        case 306 | 434: 
            defaultCamZoom = 1;
            camGame.zoom = 1.1;
    
        case 310 | 438: 
            defaultCamZoom = 1.1;
            camGame.zoom = 1.1;
    
        case 320 | 724: 
            defaultCamZoom = 0.85;
            camGame.flash(FlxColor.WHITE, 1);
    
        case 368 | 400: 
            defaultCamZoom += 0.15; 
    
        case 384 | 416:
            defaultCamZoom -= 0.15;
    
        case 448: 
            defaultCamZoom = 0.85;
            FlxTween.tween(camHUD, {alpha: 0}, 1, {ease: FlxEase.sineInOut});
    
        case 460:
            defaultCamZoom = 1.45;
    
        case 464: 
            defaultCamZoom = 0.9;
            timeTxt.font = Paths.font('fpsFont.ttf');
            FlxTween.tween(camHUD, {alpha: 1}, 1.5, {ease: FlxEase.sineInOut});
            camGame.flash(FlxColor.WHITE, 1);
            if (Options.gameplayShaders) cpuStrums.forEach(yeah -> yeah.shader = null);
            if (CNlogo != null) CNlogo.alpha = 0;
            disableCamMove = true;
            camGame.removeShader(aberration);
            camHUD.removeShader(aberration);
            camGame.removeShader(pibbyShader);
            camHUD.removeShader(pibbyShader);
            camGame.removeShader(bloom);
    
        case 592: 
            camGame.flash(FlxColor.WHITE, 1);
            timeTxt.font = Paths.font('finn.ttf');
            pibbyHealthbar.alpha = 1;
            if (Options.gameplayShaders) cpuStrums.forEach(yeah -> yeah.shader = glitches);
            if (CNlogo != null) CNlogo.alpha = 0.5;
            disableCamMove = false;
            camGame.addShader(aberration);
            camHUD.addShader(aberration);
            camGame.addShader(pibbyShader);
            camHUD.addShader(pibbyShader);
            camGame.addShader(bloom);
    
        case 720: 
            defaultCamZoom = 1.05;
    
        case 848:
            FlxTween.tween(camHUD, {alpha: 0}, 0.7, {ease: FlxEase.sineInOut});
    
        case 869: 
            camHUD.alpha = 1;
            camHUD.zoom += 1;
    
        case 880: 
            defaultCamZoom = 1.25;
            camGame.flash(FlxColor.WHITE, 1);
    
        case 982: 
            defaultCamZoom = 1.35;
    
        case 986: 
            defaultCamZoom = 1.45;
    
        case 990: 
            defaultCamZoom = 1.55;
    
        case 994: 
            defaultCamZoom = 1.25;
            
        case 998: 
            defaultCamZoom = 1.35;
    
        case 1008: 
            defaultCamZoom = 0.86;
            camGame.flash(FlxColor.WHITE, 1);
    
        case 1126: 
            defaultCamZoom = 1;
    
        case 1136: 
            FlxTween.tween(camGame, {zoom: 0.84}, 4, {ease: FlxEase.sineInOut, onComplete: woo -> defaultCamZoom = 0.84});
    
        case 1264: 
            camGame.fade(FlxColor.BLACK, 0.55);
            FlxTween.tween(camHUD, {alpha: 0.001}, 0.5, {ease: FlxEase.sineInOut});
    }
}
function onNoteHit(e){
    if (curStep > 0 && curStep < 192)
        e.enableCamZooming = false;
}
