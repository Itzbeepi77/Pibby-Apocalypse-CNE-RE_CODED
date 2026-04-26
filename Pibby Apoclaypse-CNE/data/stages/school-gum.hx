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

    if (curSong == "childs-play"){
        c_penny.x = 700;
        c_penny.y = 200;
        c_penny.scale.set(1.3, 1.3);
        for (chars in [penny,tobias,toast,joe,allan,carrie,sarah,masami,hotDogGuy]){
            chars.visible = false;
        }
    }

    for (i in [carrie,carrieCorrupt])
        FlxTween.tween(i, {y: i.y+50}, 4, {ease: FlxEase.sineInOut, type: FlxTween.PINGPONG});

    idkShit2.scale.set(1.3, 0.9);
    idkShit.scale.set(1.5, 1.3);
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
                c_penny.alpha = 0.0001;
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
                c_penny.alpha = 1;
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
    if (curSong == "childs-play-v2") return;
    switch(curCameraTarget){
        case 0:
            defaultCamZoom = 1.2;

        default:
            defaultCamZoom = 0.9;
    }
}
function stepHit(curStep){
    pixelated.size = FlxG.random.float(10,5);

    if (curSong == 'childs-play'){
        if (curStep == 416){
            if (!lowMem){
                c_penny.alpha = 1;
                droplet.alpha = 1;
                droplet2.alpha = 1;
                sinkgoop.alpha = 1;
                topgoop.alpha = 1;
                topgoop2.alpha = 1;
            }
        }
        if (curStep == 256){
            if(Options.gameplayShaders) {
                strumGlitch = true;
                for (i in cpuStrums.members){
                    if (i.shader == null){
                        i.shader = distorFNF;
                    }
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
    } else if (curSong == "childs-play-v2"){
        if(curStep == 390){
            if(Options.gameplayShaders) FlxTween.tween(bright, {contrast: 0.9}, 2.5, {ease: FlxEase.sineInOut});
        }
        if (curStep == 928){
            for (cams in [camera, camHUD]){
                FlxTween.tween(cams, {alpha: 0.001}, 1.75);
            }
        }
        if (curStep == 1056){
            for (cams in [camera, camHUD]){
                cams.alpha = 1;
            }
            if(Options.gameplayShaders) {
                dad.shader = distorFNF;
                for (chars in [penny,tobias,toast,joe,allan,carrie,sarah,masami,hotDogGuy]){
                    chars.shader = distorFNF;
                }
                strumGlitch = true;
                FlxTween.tween(bright, {brightness: -0.2}, 2.5, {ease: FlxEase.sineInOut});
            }
        }
        if (curStep == 1327 || curStep == 2114){
            for (cams in [camera, camHUD]){
                FlxTween.tween(cams, {alpha: 0.001}, .5);
            }
        }
        if (curStep == 1344){
            camera.followLerp = 0.08;
            for (cams in [camera, camHUD]){
                cams.alpha = 1;
            }
            for (chars in [c_penny,deadPotato,deadTobias,toastDead,deadJoe,sarahDead,allanDead,carrieCorrupt,c_masami,c_HotDog]){
                chars.alpha = 1;
            }
            if (!FlxG.save.data.goreShit){
                deadTobias.colorTransform.color = 0x000000000;
            }
            if(Options.gameplayShaders){
                sarahDead.shader = distorFNF;
                deadTobias.shader = distorFNF;
                FlxTween.tween(bright, {brightness: 0.0}, 2.5, {ease: FlxEase.sineInOut});
            }

            droplet.alpha = 1;
            droplet2.alpha = 1;
            sinkgoop.alpha = 1;
            topgoop.alpha = 1;
            topgoop2.alpha = 1;

            for (chars in [penny,tobias,toast,joe,allan,carrie,sarah,masami,hotDogGuy]){
                chars.alpha = 0.001;
            }
        }
        if (curStep == 2129){
            camera.followLerp = 0.04;
            for (cams in [camera, camHUD]){
                cams.alpha = 1;
            }
            for (chars in [sarahDead,c_HotDog]){
                chars.alpha = 0.001;
            }
        }
        if (curStep == 2265){
            for (cams in [camera, camHUD]){
                cams.fade(FlxColor.BLACK, 2.5);
            }
        }
    }
}