import openfl.geom.ColorTransform;
import openfl.Lib;

// making them variables so its less confusing and stuff also stolen code :trolled:
var charColors = [0xff969494];
var houseColors = [0xFF8f8f8f];
var rockColors = [0xFFbababa];
var coolThingColors = [0xFFc4c0c0];

var timerShit = FlxG.random.float(4, 9);
var timerShit2 = FlxG.random.float(3, 7);
var timerShit3 = FlxG.random.float(3, 7);
var centerCams:Bool = false;
public var lowMem = Options.lowMemoryMode;
var pixelated = new CustomShader("pixelated");
var file = new CustomShader("fileShader");
var glitchScreen = new CustomShader("fwGlitch");

function postCreate(){
    camera.followLerp = 0.08;

    if (Options.gameplayShaders){
        bg.shader = glitches;
    }
}

function create(){

    house.color = houseColors[0];
    houseb.color = houseColors[0];

    if (!lowMem){
        things.color = coolThingColors[0];
        platform.color = rockColors[0];
        platform2.color = rockColors[0];
        rock.color = houseColors[0];
        rockb.color = houseColors[0];
        rock2.color = houseColors[0];
        rock3.color = houseColors[0];
        rock4b.color = houseColors[0];

        tweenLoopAngle(house, 4, -4, 6, 6);
        tweenLoopAngle(platform, -0.5, 0.5, 2.5, 2.5);
        tweenLoopAngle(rock, -2, 1.2, 2.5, 2.5);
        tweenLoopAngle(rock2, 360, 0, 30, 30);
        tweenLoopAngle(things, 2, -2, 5, 5);
    
        tweenLoopAngle(houseb, 16, -12, 6, 6);
        tweenLoopAngle(platform2, -0.5, 0.5, 2.5, 2.5);
        FlxTween.tween(rock3, {angle: 360}, 30, {
            ease: FlxEase.sineInOut
        });
        
        rock4bMove = FlxTween.tween(rock4b, {x: 2500}, timerShit2, {
            ease: FlxEase.sineInOut,
            onComplete: 
            function(e)
            {
                rock4b.x = -2600;
                makeShitInsane(rock4b, 2500, 3, 7);
            }
        });
        rock4bMove.active = false;
    
        stupidFix = FlxTween.tween(things, {y: things.y}, 1);
        houseShit = FlxTween.tween(house, {y: house.y-50}, 2.5, {ease: FlxEase.sineInOut, type: FlxTween.PINGPONG});
        houseShit = FlxTween.tween(houseb, {y: houseb.y-50}, 2.5, {ease: FlxEase.sineInOut, type: FlxTween.PINGPONG});
    }
    
    housebTween = FlxTween.tween(houseb, {x: 2000}, timerShit, {
        ease: FlxEase.sineInOut,
        onComplete: 
        function(e)
        {
            houseb.x = -2600;
            makeShitInsane(houseb, 2000, 4, 9);
        }
    });
    housebTween.active = false;

    vignette = new FlxSprite(0, 0).loadGraphic(Paths.image('vignette'));
    vignette.updateHitbox();
    vignette.cameras = [camHUD];
    vignette.alpha = 0.0001;
    add(vignette);

    if (Options.gameplayShaders){
        pixelated.iTime = 7.5;
        if (!lowMem){
            fuck.shader = pixelated;
            glitchShit.shader = pixelated;
            glitchFGshit.shader = pixelated;
            uhh3.shader = pixelated;
            uhh2.shader = pixelated;
        }
    }

}
function onEvent(e){
    if (e.event.name == "AppleFilter"){
        if (e.event.params[0] == true || e.event.params[0] == null){
            bg.alpha = 0.0001;
            house.alpha = 0.0001;
            platform.alpha = 0.0001;
    
            bgb.alpha = 0.0001;
            houseb.alpha = 0.0001;
            platform2.alpha = 0.0001;
            
            if (!lowMem){
                rock.alpha = 0.0001;
                rock2.alpha = 0.0001;
                rock3.alpha = 0.0001;
                things.alpha = 0.0001;
                fuck.alpha = 0.0001;
                glitchShit.alpha = 0.0001;
                glitchFGshit.alpha = 0.0001;
            }
        } else {

            boyfriend.color = charColors[0];
            dad.color = charColors[0];
        }
    }
}

var time:Float = 0;
function postUpdate(elapsed) {
    if (Conductor.songPosition > 0 && curStep < 257 || curStep >= 1180 && curStep < 1442){
        	camFollow.setPosition(600, 550);
	}
    
    if (Options.gameplayShaders){
        time += elapsed;
    
        glitchScreen.iTime = time;
        file.iTime = time;
    }
}

function tweenLoopAngle(varx, distance1, distance2, duration1, duration2) {
    FlxTween.tween(varx, {angle: distance1}, duration1, {
        ease: FlxEase.sineInOut,
        onComplete: 
        function (twn:FlxTween)
            {
                FlxTween.tween(varx, {angle: distance2}, duration2, {
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
function makeShitInsane(object, xThing, timerRandom1, timerRandom2)
{
    FlxTween.tween(object, {x: xThing}, timerShit, {
        ease: FlxEase.sineInOut,
        onComplete: 
        function(e)
        {
            timerShit = FlxG.random.float(timerRandom1, timerRandom2);
            object.x = -2600;
            makeShitInsane(object, xThing, timerRandom1, timerRandom2);
        }
    });
}
function stepHit(){
    if (Options.gameplayShaders){
        pixelated.size = FlxG.random.float(5,2.5);
    }
    if (curSong == 'forgotten-world'){
        switch(curStep){

            case 1180:
                camHUD.flash();

            case 514:
                bg.alpha = 1;
                house.alpha = 1;
                platform.alpha = 1;
                if (!lowMem){
                    rock.alpha = 1;
                    things.alpha = 1;
                    rock2.alpha = 1;
                    rock3.alpha = 1;
                    fuck.alpha = 1;
                    glitchShit.alpha = 1;
                    glitchFGshit.alpha = 1;
                }
                boyfriend.color = charColors[0];
                dad.color = charColors[0];

            case 1442:
                camHUD.flash();
                housebTween.active = true;
                if (!lowMem){
                rock4bMove.active = true;
                }
                vignette.alpha = 1;
                defaultCamZoom = 0.7;
        
                bg.alpha = 0.0001;
                house.alpha = 0.0001;
                platform.alpha = 0.0001;

                bgb.alpha = 1;
                platform2.alpha = 1;
                houseb.alpha = 1;
        
                if (!lowMem){
                    rock.alpha = 0.0001;
                    rock2.alpha = 0.0001;
                    rock3.alpha = 0.0001;
                    tweenLoopAngle(things, 2, -2, 3, 3);
                    for (q in [rock4b,rockb,uhh3,uhh2,fuck,glitchShit,glitchFGshit]){
                        q.alpha = 1;
                    }
                }
                boyfriend.color = charColors[0];
                dad.color = charColors[0];
                if (Options.gameplayShaders && bgb.shader == null) bgb.shader = file;

            case 2389:
                for (i in [timeBar,timeBarBG, timeTxt]){
                    i.alpha = 0.001;
                }
                for (i in playerStrums.members){
                    i.alpha = 0.001;
                }
                camera.alpha = 0.001;
                camHUD.alpha = 0.001;
                if (Options.gameplayShaders && bgb.shader != null) bgb.shader = null;

            case 2608:
                FlxTween.tween(camHUD, {alpha: 1}, 0.5, {ease: FlxEase.sineInOut});

            case 2715:
                camCinema.flash();
                camHUD.alpha = 0.001;
        }
        if (curStep == 513)
        {
            tweenLoopAngle(boyfriend, 2.1, -2.1, 2.5, 2.5);
            tweenLoopAngle(dad, 2.1, -2.1, 2.5, 2.5);
            tweenLoopAngle(rock, -0.8, 0.8, 2.5, 2.5);
        }
        if (curStep == 514 || curStep == 1442){
            camHUD.flash();
        }
        if (curStep == 1992){
            camera.addShader(glitchScreen);
            camHUD.addShader(glitchScreen);
        }
        if (curStep == 803 || curStep == 868){
            FlxTween.tween(camGame, {zoom: 1}, 0.075, {
                ease: FlxEase.quadInOut,
                onComplete: 
                function (twn:FlxTween)
                    {
                        defaultCamZoom = 1;
                    }
                });
            }
        if (curStep == 805 || curStep == 870){
            FlxTween.tween(camGame, {zoom: .7}, 0.075, {
                ease: FlxEase.quadInOut,
                onComplete: 
                function (twn:FlxTween)
                    {
                        defaultCamZoom = .7;
                    }
                });
            }
    }
}