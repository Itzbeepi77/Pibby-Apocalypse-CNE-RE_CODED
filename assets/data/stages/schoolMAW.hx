import openfl.geom.ColorTransform;

// making them variables so its less confusing and stuff also stolen code :trolled:
var charColors = [0xff969494, 0xFFBFE5BA];
var houseColors = [0xFF8f8f8f, 0xFF9ADA91];
var rockColors = [0xFFbababa, 0xFFB8D4B5];
var coolThingColors = [0xFFc4c0c0, 0xFFC1CEAA];

public var lowMem = Options.lowMemoryMode;
var pixelated = new CustomShader("pixelated");

function create(){
    if (Options.gameplayShaders)pixelated.iTime = 7.5;

    gf.visible = false;

    bgV.alpha = 0.0001;
    house.alpha = 0.0001;
    platform.alpha = 0.0001;

    if (!lowMem){
        if (Options.gameplayShaders){
            topgoop.shader = pixelated;
            droplet.shader = pixelated;
            topgoop2.shader = pixelated;
            droplet2.shader = pixelated;
            sinkgoop.shader = pixelated;
        }

        rock.alpha = 0.0001;
        rock2.alpha = 0.0001;
        things.alpha = 0.0001;
    
        tweenLoopAngle(house, 4, -4, 6, 6);
        tweenLoopAngle(platform, -0.5, 0.5, 2.5, 2.5);
    
        tweenLoopAngle(rock, -2, 1.2, 2.5, 2.5);
        tweenLoopAngle(rock2, 360, 0, 30, 30);
        tweenLoopAngle(things, 2, -2, 5, 5);
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
function onEvent(e){
    if (e.event.name == "AppleFilter"){
        if (e.event.params[0] == true || e.event.params[0] == null){
            bg.alpha = 0.0001;
            if (!lowMem){
                penny.alpha = 0.0001;
                topgoop.alpha = 0.0001;
                droplet.alpha = 0.0001;
                topgoop2.alpha = 0.0001;
                droplet2.alpha = 0.0001;
                sinkgoop.alpha = 0.0001;
                wall.alpha = 0.0001;
                light.alpha = 0.0001;
                idkShit.alpha = 0.0001;
                idkShit2.alpha = 0.0001;
            }
        }
    }
}
function postUpdate(elapsed:Float){
    if (curStep >= 2144 && curStep < 2655){
        curCameraTarget = -1;
        camFollow.setPosition(750, 725);
    }
}
function stepHit(curStep){
    if (Options.gameplayShaders)pixelated.size = FlxG.random.float(5,2.5);
    if (curSong == 'my-amazing-world'){
    if (curStep == 512 || curStep == 1568){
        camHUD.flash();
    }
    if (curStep == 2144){
        camHUD.flash();
    }
    if (curStep == 1024 || curStep == 1824){
        bg.alpha = 1;
        if (!lowMem){
            penny.alpha = 1;
            sinkgoop.alpha = 1;
            topgoop.alpha = 1;
            droplet.alpha = 1;
            topgoop2.alpha = 1;
            droplet2.alpha = 1;
            wall.alpha = 1;
            light.alpha = 1;
            idkShit.alpha = 1;
            idkShit2.alpha = 1;
        }
    }
    if (curStep == 2080){
        boyfriend.visible = false;
    }
    if (curStep == 1024 || curStep == 2400){
        camGame.flash(FlxColor.BLACK, 2.5);
    }
    if (curStep == 1024){
        camera.zoom = 1.7;
        FlxTween.tween(camera, {zoom: 1.2}, 10);
    }
    if (curStep == 2400){
        camera.zoom = 1.7;
        FlxTween.tween(camera, {zoom: 1.2}, 5);
    }
    if (curStep == 2672){
        FlxTween.tween(camera, {zoom: 2}, 1);
    }
    if (curStep == 1568 || curStep == 1826){
        boyfriend.alpha = 0.5;
    }
    if (curStep == 1568 || curStep == 2688){
        gf.visible = true;
    }
    if (curStep == 2688){
        boyfriend.visible = true;
        boyfriend.alpha = 1;
        bgV.alpha = 1;
        house.alpha = 1;
        platform.alpha = 1;
        if (!lowMem){
            rock.alpha = 1;
            rock2.alpha = 1;
            things.alpha = 1;
        }
        
        ch1.alpha = 0.0001;
        ch2.alpha = 0.0001;
        ch3.alpha = 0.0001;

        boyfriend.color = charColors[0];
        dad.color = charColors[0];
        gf.color = charColors[0];
        
        house.color = houseColors[0];

        things.color = coolThingColors[0];
        platform.color = rockColors[0];
        rock.color = houseColors[0];
        rock2.color = houseColors[0];
    }
    if (curStep == 2144){
        bg.alpha = 0.0001;
        if (!lowMem){
            penny.alpha = 0.0001;
            sinkgoop.alpha = 0.0001;
            wall.alpha = 0.0001;
            light.alpha = 0.0001;
            idkShit.alpha = 0.0001;
            idkShit2.alpha = 0.0001;
            topgoop.alpha = 0.0001;
            droplet.alpha = 0.0001;
            topgoop2.alpha = 0.0001;
            droplet2.alpha = 0.0001;
        }

        ch1.alpha = 1;
    }
    if (curStep == 2176)
        {
            ch1.alpha = 0.0001;
            ch2.alpha = 1;
        }
    if (curStep == 2208)
        {
            ch2.alpha = 0.0001;
            ch3.alpha = 1;
        }
    if (curStep == 2272)
        {
            ch3.alpha = 0.0001;
            ch1.alpha = 1;
        }
    if (curStep == 2304)
        {
            ch1.alpha = 0.0001;
            ch2.alpha = 1;
        }
    if (curStep == 2336)
        {
            ch2.alpha = 0.0001;
            ch3.alpha = 1;
        }
    if (curStep == 2400)
        {
            ch3.alpha = 0.0001;
            ch1.alpha = 1;
        }
    if (curStep == 2432)
        {
            ch1.alpha = 0.0001;
            ch2.alpha = 1;
        }
    if (curStep == 2464)
        {
            ch2.alpha = 0.0001;
            ch3.alpha = 1;
        }
    if (curStep == 2528)
        {
            ch3.alpha = 0.0001;
            ch1.alpha = 1;
        }
    if (curStep == 2560)
        {
            ch1.alpha = 0.0001;
            ch2.alpha = 1;
        }
    if (curStep == 2592)
        {
            ch2.alpha = 0.0001;
            ch3.alpha = 1;
        }
    if (curStep == 2604)
        {
            ch3.alpha = 0.0001;
            ch1.alpha = 1;
        }
    if (curStep == 2624)
        {
            ch1.alpha = 0.0001;
            ch2.alpha = 1;
        }
    if (curStep == 2632)
        {
            ch2.alpha = 0.0001;
            ch3.alpha = 1;
        }
    if (curStep == 2640)
        {
            ch3.alpha = 0.0001;
            ch1.alpha = 1;
        }
    if (curStep == 2648)
        {
            ch1.alpha = 0.0001;
            ch2.alpha = 1;
        }
    if (curStep == 2656)
        {
            ch2.alpha = 0.0001;
            ch3.alpha = 1;
        }
    }
}