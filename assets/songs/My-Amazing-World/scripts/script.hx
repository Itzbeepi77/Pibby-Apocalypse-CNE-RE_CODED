import openfl.Lib;
import openfl.geom.Rectangle;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;

var dadCamZoom:Int = 1.2;
var bfCamZoom:Int = 0.9;
var oldMonitor = new CustomShader("monitor");
var vhs = new CustomShader("MAWVHS");
var channelTxt:FlxText;


function create(){
    camera.alpha = 0.001;
    camHUD.alpha = 0.001;

    oldMonitor.zoom = 100;

    channelTxt = new FlxText(-400, 90, FlxG.width, "", 20);
    channelTxt.setFormat(Paths.font('fpsFont.ttf'), 56, FlxColor.LIME, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    channelTxt.scrollFactor.set();
    channelTxt.borderSize = 1.25;
    channelTxt.cameras = [camHUD2];
    add(channelTxt);
}
function onSongStart() {
    camera.alpha = 1;
    camHUD.alpha = 1;
    camHUD.flash(FlxColor.BLACK, 10);
}
function changeChannel(number:Int){
    switch (number)
        {
            case 0:
                channelTxt.text = "AV";
            case 1:
                channelTxt.text = "CH 06";
            case 2:
                channelTxt.text = "CH 02";
            case 3:
                channelTxt.text = "CH 03";
        }
}

var tvTime:Float = 0;
function update(elapsed){
    if (Options.gameplayShaders){
        tvTime += elapsed;
        vhs.iTime = tvTime;
    }
}

function onCameraMove(e){
    switch(curCameraTarget){
        case 0:
            defaultCamZoom = dadCamZoom;

        case 1,2:
            defaultCamZoom = bfCamZoom;
    }
}
function stepHit(curStep){
    switch(curStep){
        case 2144, 2272, 2400, 2528, 2604, 2640:
            changeChannel(1);
        case 2176, 2304, 2432, 2560, 2624, 2648:
            changeChannel(2);
        case 2208, 2336, 2464, 2592, 2632, 2656:
            changeChannel(3);
        case 2688:
            changeChannel(0);
    }
    if (curStep == 242 || curStep == 492){
        bfCamZoom = 1;
    }
    if (curStep == 246 || curStep == 498){
        bfCamZoom = 1.1;
    }
    if (curStep == 256 || curStep == 502){
        bfCamZoom = 0.9;
    }
    if (curStep == 1280){
        dadCamZoom = 1.5;
    }
    if (curStep == 1296){
        dadCamZoom = 1.2;
    }
    if (curStep == 1416){
        bfCamZoom = 1;
    }
    if (curStep == 1424){
        bfCamZoom = 0.9;
        FlxTween.tween(camera, {zoom: 1.7}, 10, {ease: FlxEase.sineInOut});
    }
    if (curStep == 1552){
        camGame.alpha = 0.0001;
    }
    if (curStep == 1568){
        camGame.alpha = 1;
        iconP1.setIcon(gf.icon!=null?gf.icon:gf.curCharacter);
    }
    if (curStep == 2144){
        if (Options.gameplayShaders){
            camHUD.addShader(oldMonitor);

            camHUD2.addShader(oldMonitor);
            camHUD2.addShader(aberration);
            camHUD2.addShader(pibbyShader);

            camCinema.addShader(oldMonitor);

            camera.addShader(oldMonitor);
            camera.addShader(vhs);
        }
        dad.x = 0 +300;
        dad.y = 0 +310;
        gf.x -= 250;
        bfCamZoom = 0.8;
        dadCamZoom = 0.8;
        defaultCamZoom = 0.8;
    }
    if (curStep == 2688){
        if (Options.gameplayShaders){
            camHUD.removeShader(oldMonitor);

            camHUD2.removeShader(oldMonitor);
            camHUD2.removeShader(aberration);
            camHUD2.removeShader(pibbyShader);

            camCinema.removeShader(oldMonitor);

            camera.removeShader(oldMonitor);
            camera.removeShader(vhs);

            oldMonitor.zoom = 1;
            vhs.iTime = 0;
        }
        boyfriend.x -= 100;
        dadCamZoom = 0.7;
        bfCamZoom = 0.7;
        defaultCamZoom = 0.7;
        dad.y = 0 +360;
    }
    if (curStep == 2176 || curStep == 2304 || curStep == 2432 || curStep == 2560 || curStep == 2624 || curStep == 2648){
        FlxTween.tween(camGame, {zoom: 1.2}, 0.001, {
            onStart: 
            function (twn:FlxTween)
                {
                    defaultCamZoom = 1.2;
                }
            });
    }

    if (curStep == 2208 || curStep == 2272 || curStep == 2336 || curStep == 2464 || curStep == 2528 ||
        curStep == 2592 || curStep == 2604 || curStep == 2632 || curStep == 2640 || curStep == 2640 || curStep == 2656){
        FlxTween.tween(camGame, {zoom: 0.8}, 0.001, {
            onStart: 
            function (twn:FlxTween)
                {
                    defaultCamZoom = 0.8;
                }
            });
        }
}