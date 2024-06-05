import openfl.geom.ColorTransform;

// making them variables so its less confusing and stuff also stolen code :trolled:
var charColors = [0xff969494, 0xFFBFE5BA];
var houseColors = [0xFF8f8f8f, 0xFF9ADA91];
var rockColors = [0xFFbababa, 0xFFB8D4B5];
var coolThingColors = [0xFFc4c0c0, 0xFFC1CEAA];
var velocityShitHehe:Int = 1;
public var lowMem = Options.lowMemoryMode;

function postCreate()
    camera.followLerp = 0.08;
function create(){
    house.color = houseColors[0];

    if (!lowMem){
        tweenLoopAngle(house, 4, -4, 6, 6);
        tweenLoopAngle(platform, -0.5, 0.5, 2.5, 2.5);
        tweenLoopAngle(rock2, 360, 0, 30, 30);
        tweenLoopAngle(things, 2, -2, 5, 5);
    
        things.color = coolThingColors[0];
        platform.color = rockColors[0];
        rock.color = houseColors[0];
        rock2.color = houseColors[0];
        rock3.color = houseColors[0];
    
        {
            FlxTween.tween(rock3, {angle: 360}, 30, {
            ease: FlxEase.sineInOut
            });
        }
    
        stupidFix = FlxTween.tween(things, {y: things.y}, 1);
        houseShit = FlxTween.tween(house, {y: house.y-50}, 2.5, {ease: FlxEase.sineInOut, type: FlxTween.PINGPONG});
    }
}

function onEvent(e){
    if (e.event.name == "AppleFilter"){
        if (e.event.params[0] == true || e.event.params[0] == null){
            bg.alpha = 0.0001;
            glitch.alpha = 0.0001;
            house.alpha = 0.0001;
            platform.alpha = 0.0001;
    
            if (!lowMem){
                rock.alpha = 0.0001;
                rock2.alpha = 0.0001;
                rock3.alpha = 0.0001;
                things.alpha = 0.0001;
            }
    
            tweenLoopAngle(boyfriend, 0, 0, 0.00001, 0.00001);
            tweenLoopAngle(dad, 0, 0, 0.00001, 0.00001);
            tweenLoopAngle(gf, 0, 0, 0.00001, 0.00001);
        } else if (e.event.params[0] == false){
            bg.alpha = 1;
            glitch.alpha = 1;
            house.alpha = 1;
            platform.alpha = 1;
            
            if (!lowMem){
                rock.alpha = 1;
                rock2.alpha = 1;
                rock3.alpha = 1;
                things.alpha = 1;
            }
        }
    }
}
function tweenLoopAngle(varx, distance1, distance2, duration1, duration2) {
    FlxTween.tween(varx, {angle: distance1}, duration1 / velocityShitHehe, {
        ease: FlxEase.sineInOut,
        onComplete: 
        function (twn:FlxTween)
            {
                FlxTween.tween(varx, {angle: distance2}, duration2 / velocityShitHehe, {
                    ease: FlxEase.sineInOut,
                    onComplete: 
                    function (twn:FlxTween)
                        {
                            tweenLoopAngle(varx, distance1, distance2, duration1, duration2);
                        }
                });
            }
    });
}
function onSongStart(){
    tweenLoopAngle(rock, -2.1, 2.1, 2.5, 2.5);
    tweenLoopAngle(boyfriend, 2.1, -2.1, 2.5, 2.5);
    tweenLoopAngle(dad, 2.1, -2.1, 2.5, 2.5);
    tweenLoopAngle(gf, 2.1, -2.1, 2.5, 2.5);

    boyfriend.color = charColors[0];
    dad.color = charColors[0];
    gf.color = charColors[0];
    
    camHUD.angle = -20;
    camHUD.y -= 300;
    
}
function stepHit(curStep:Int){
    if (curSong == 'retcon'){
        if (curStep == 247){
            curCameraTarget = 0;
            dad.cameraOffset.y -= 100;
            FlxTween.tween(camHUD, {angle: 0, y: camHUD.y + 300, alpha: 1}, 2, {ease: FlxEase.expoOut});
        }
        if (curStep == 255){
            dad.cameraOffset.y += 100;
        }
        if (curStep == 1816){
            camHUD.alpha = 0.001;

            FlxTween.tween(camGame, {zoom: 1.3}, 0.001, {
                onStart: 
                function (twn:FlxTween)
                    {
                        defaultCamZoom = 1.3;
                    }
                });
        }
        if (curStep == 1824){
            camHUD.alpha = 1;
        }
        
        if (curStep == 768){
            velocityShitHehe = 1;
        }
        if (curStep == 512 || curStep == 1024){
            velocityShitHehe = 2;
        }
        if (curStep == 1280){
            houseShit = FlxTween.tween(house, {y: house.y-90}, 1.75, {ease: FlxEase.sineInOut, type: FlxTween.PINGPONG});
            velocityShitHehe = 5;
        }
        if (curStep == 1536 || curStep == 1792 || curStep == 1824){
            houseShit = FlxTween.tween(house, {y: house.y-120}, 1, {ease: FlxEase.sineInOut, type: FlxTween.PINGPONG});
            velocityShitHehe = 10;
        }
        if (curStep == 2064){
            camHUD.flash();
            camHUD.shake(FlxG.random.float(0.025,0.1), FlxG.random.float(0.075,0.125));
            glitch_time = 2;
            songLength = inst.length;
        }

        switch(curStep){
            case 512, 1024, 1536, 1824:
                glitch.alpha = 1;
                camera.flash();
                
                boyfriend.color = charColors[1];
                dad.color = charColors[1];
                gf.color = charColors[1];
                house.color = houseColors[1];
                platform.color = rockColors[1];

                rock.color = houseColors[1];
                rock2.color = houseColors[1];
                rock3.color = houseColors[1];
                things.color = coolThingColors[1];

            case 768, 1792:
                FlxTween.tween(glitch, {alpha: 0.0001}, 1, {
                    ease: FlxEase.quadInOut
                });

                FlxTween.color(boyfriend, 0.5, charColors[1], charColors[0], {ease: FlxEase.quadInOut } );
                FlxTween.color(dad, 0.5, charColors[1], charColors[0], {ease: FlxEase.quadInOut } );
                FlxTween.color(gf, 0.5, charColors[1], charColors[0], {ease: FlxEase.quadInOut } );
                FlxTween.color(house, 0.5, houseColors[1], houseColors[0], {ease: FlxEase.quadInOut } );

                if (!lowMem){
                FlxTween.color(platform, 0.5, rockColors[1], rockColors[0], {ease: FlxEase.quadInOut } );
                FlxTween.color(rock, 0.5, rockColors[1], rockColors[0], {ease: FlxEase.quadInOut } );
        
                FlxTween.color(rock2, 0.5, houseColors[1], houseColors[0], {ease: FlxEase.quadInOut } );
                FlxTween.color(rock3, 0.5, houseColors[1], houseColors[0], {ease: FlxEase.quadInOut } );
                FlxTween.color(things, 0.5, coolThingColors[1], coolThingColors[0], {ease: FlxEase.quadInOut } );
                }

            case 1280:
                glitch.alpha = 0.0001;
                camera.flash();

                boyfriend.color = charColors[0];
                dad.color = charColors[0];
                gf.color = charColors[0];
                
                house.color = houseColors[0];

                if (!lowMem){
                things.color = coolThingColors[0];
                platform.color = rockColors[0];
                rock.color = houseColors[0];
                rock2.color = houseColors[0];
                rock3.color = houseColors[0];
            }
        }
    }
}