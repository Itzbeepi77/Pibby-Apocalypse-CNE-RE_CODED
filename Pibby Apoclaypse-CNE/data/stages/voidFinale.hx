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
var balls:Bool = false;
public var lowMem = Options.lowMemoryMode;
var pixelated = new CustomShader("pixelated");
var file = new CustomShader("fileShader");
var glitchScreen = new CustomShader("fwGlitch");
var vignette:FunkinSprite;

var houseShit:FlxTween;
var carsShit,carsShit2:FlxTween;

function postCreate(){
    camera.followLerp = 0.08;

    pixelated.iTime = 7.5;
}

function create(){

    vignette = new FunkinSprite().loadGraphic(Paths.image('stages/voidFinale/Ilustracion_sin_titulo-9'));
    vignette.updateHitbox();
    vignette.cameras = [camHUD];
    vignette.alpha = 0.001;
    vignette.screenCenter();
    vignette.scale.set(1.4,1.4);
    add(vignette);

    if (Options.gameplayShaders){
        void.shader = distorFNF;

        for (glitchs in [glitch6,glitch_shit,glitchMF,glitchMF2,glitch5,vignette]){
            glitchs.shader = pixelated;
        }
    }
    
    silhouet.colorTransform.color = 0x000000000;

    house.color = houseColors[0];

    var carsFuck = [cHAR,cor1,cor2,car1];

    for (i in carsFuck){
       carsShit = FlxTween.tween(i, {y: i.y+(FlxG.random.int(-50, 50)), x: i.x+(FlxG.random.int(-50, 50))}, FlxG.random.int(2.5, 4), {
        ease: FlxEase.sineInOut, type: FlxTween.PINGPONG});
    }

    for (cars in [cHAR,cor1,cor2,car1]){
        cars.color = house.color;
    }

    tree.color = coolThingColors[0];

    //rooftop.color = charColors[0];

    tweenLoopAngle(house, 4, -4, 6, 6);

    tweenLoopAngle(cHAR, 8, -8, 6, 6);

    tweenLoopAngle(cor1, -7, 9, 6, 6);

    tweenLoopAngle(cor2, 7, -5, 6, 6);

    tweenLoopAngle(car1, -6, 9, 6, 6);

    houseShit = FlxTween.tween(house, {y: house.y-50}, 2.5, {ease: FlxEase.sineInOut, type: FlxTween.PINGPONG});

    rooftop.scale.x += 1;
    rooftop.scale.y += 0.25;
}

function onEvent(e){
    if (e.event.name == "AppleFilter"){
        if (e.event.params[0] == true || e.event.params[0] == null){
            if (!lowMem){
                glitch6.alpha = 0.001;
            }
            balls = false;
        } else {
            boyfriend.color = charColors[0];
            dad.color = charColors[0];

            balls = true;
        }
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
    var timerShit = FlxG.random.float(timerRandom1, timerRandom2);
    FlxTween.tween(object, {x: xThing}, timerShit, {
        ease: FlxEase.sineInOut,
        onComplete: 
        function(e)
        {
            object.x = -2600;
            makeShitInsane(object, xThing, timerRandom1, timerRandom2);
        }
    });
}

function stepHit(){
    if (Options.gameplayShaders){
        pixelated.size = FlxG.random.float(10,5);
    }
}

var time:Float = 0;
function postUpdate(elapsed){
    if (balls)
        dad.color = charColors[0];

    if (Options.gameplayShaders){
        time += elapsed;
    
        glitchScreen.iTime = time;
        file.iTime = time;
        
        if (curStep == 532){
            for (i in playerStrums.members){
                i.shader = distorFNF;
            }
        }

        if (curStep == 1937){
            void.shader = file;
            voidb.shader = file;

            bloom.size = 120.0;

        }
        if (curStep == 3249){
            for(cam in [camera,camHUD]){
                cam.addShader(glitchScreen);
            }

            vignette.alpha = 1;
        }
    }
    if (curStep == 1937){
        voidb.alpha = 1;
        balls = false;
        dad.setColorTransform();
    }
}