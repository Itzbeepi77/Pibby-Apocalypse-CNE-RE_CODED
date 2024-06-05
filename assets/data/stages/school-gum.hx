import openfl.geom.ColorTransform;

var centerCams:Bool = false;
var pixelated = new CustomShader("pixelated");
public var lowMem = Options.lowMemoryMode;

function postCreate(){
    if(Options.gameplayShaders) {
        for (i in cpuStrums.members){
            i.shader = null;
        }
    }
}
function create(){
    
    if (Options.gameplayShaders)pixelated.iTime = 7.5;
    if (!lowMem){
        if (Options.gameplayShaders){
            topgoop.shader = pixelated;
            droplet.shader = pixelated;
            topgoop2.shader = pixelated;
            droplet2.shader = pixelated;
            sinkgoop.shader = pixelated;
        }
    }
}
function postUpdate(elapsed:Float) {
    if (centerCams){
        	camFollow.setPosition(750, 750);
	}
}
function onEvent(e){
    if (e.event.name == "AppleFilter-Alt" || e.event.name == "AppleFilter"){
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
        } else if (e.event.params[0] == false){
            bg.alpha = 1;
            
            if (!lowMem){
                penny.alpha = 1;
                topgoop.alpha = 1;
                droplet.alpha = 1;
                topgoop2.alpha = 1;
                droplet2.alpha = 1;
                sinkgoop.alpha = 1;
                wall.alpha = 1;
                light.alpha = 1;
                idkShit.alpha = 1;
                idkShit2.alpha = 1;
            }
        }
    }
}
function onSongStart(){
    camZooming = true;
    camera.flash(FlxColor.BLACK, 12);
}
function onCameraMove(e){
    switch(curCameraTarget){
        case 0:
            defaultCamZoom = 1.2;

        default:
            defaultCamZoom = 0.9;
    }
}
function stepHit(curStep){
    if (Options.gameplayShaders)pixelated.size = FlxG.random.float(5,2.5);
    if (curSong == 'childs-play'){
        if (curStep == 416){
            if (!lowMem){
                penny.alpha = 1;
                droplet.alpha = 1;
                droplet2.alpha = 1;
                sinkgoop.alpha = 1;
                topgoop.alpha = 1;
                topgoop2.alpha = 1;
            }
        }
        if (curStep == 256){
            if(Options.gameplayShaders) {
                for (i in cpuStrums.members){
                    if(i.shader == null)i.shader = glitches;
                }
            }
        }
        if (curStep == 64 || curStep == 352){
            FlxTween.tween(camera, {zoom: 1.3}, 9.5, {ease: FlxEase.sineInOut});
        }
        if (curStep == 1200){
            FlxTween.tween(camera, {zoom: 1.2}, 5.4, {ease: FlxEase.sineInOut});
        }
        if (curStep == 384 || curStep == 2240){
            camGame.alpha = 0.0001;
            camHUD.alpha = 0.001;
        }
        if (curStep == 416){
            camHUD.alpha = 1;
            camGame.alpha = 1;
        }
        if (curStep == 2192){
            FlxTween.tween(camera, {zoom: 1.5}, 10, {ease: FlxEase.sineInOut});
        }
    }
}