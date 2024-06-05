// uhh yeah.. fuck it
import openfl.geom.ColorTransform;

var flickerTween:Array<FlxTween> = [];
var flickerTween2:Array<FlxTween> = [];
var centerCams:Bool = false;
public var lowMem = Options.lowMemoryMode;

function create(){
    if (!lowMem){
        flickerTween = FlxTween.tween(light, {alpha: 0}, 0.25, {ease: FlxEase.bounceInOut, type: 4});
        flickerTween.active = true;
    
        flickerTween2 = FlxTween.tween(light, {alpha: 0}, 0.25, {ease: FlxEase.bounceInOut, type: 4});
        flickerTween2.active = true;
        
        insert(members.indexOf(boyfriend), light);
        insert(members.indexOf(boyfriend), dark);
        insert(members.indexOf(boyfriend), bulb);
    }
    if (curSong == "blessed-by-swords"){
        strumLines.members[0].characters[1].alpha = 0.0001;
    }
}
function postCreate(){
    camera.followLerp = 0.07;
    
    Finntransform.cameras [camHUD];
    Finntransform.screenCenter();
    Finntransform.alpha = 0.0001;
    Finntransform.active = false;

    if (curSong == 'mindless'){
        bg.alpha = 0.0001;
        if (!lowMem){
            light.alpha = 0.0001;
            bulb.alpha = 0.0001;
            dark.alpha = 0.0001;
            flickerTween.active = false;
            flickerTween2.active = false;
        }
        dad.alpha = 0.001;
    }
}
function onEvent(e) {
    if (e.event.name == "AppleFilter-Alt" || e.event.name == "AppleFilter"){
        if (e.event.params[0] == true || e.event.params[0] == null){
            bg.alpha = 0.0001;
            
            if (!lowMem){
                light.alpha = 0.0001;
                bulb.alpha = 0.0001;
                dark.alpha = 0.0001;
                flickerTween.active = false;
                flickerTween2.active = false;
            }
        } else if (e.event.params[0] == false){
            bg.alpha = 1;
            
            if (!lowMem){
                light.alpha = 1;
                bulb.alpha = 1;
                dark.alpha = 1;
                flickerTween.active = true;
                flickerTween2.active = true;
            }
        }
    }
}
function update(elapsed) {
    if (!lowMem){
        light.angle = Math.sin((Conductor.songPosition / 1000) * (Conductor.bpm / 60) * 1.0) * 5;
        dark.angle = light.angle;
        bulb.angle = light.angle;
    }

	if (curSong == "suffering-siblings" && curStep == 2112){
        flickerTween.active = false;
        flickerTween2.active = false;
    }
	if (curSong == "suffering-siblings" && curStep == 2336){
        flickerTween.active = true;
        flickerTween2.active = true;
    }
}
function postUpdate(){
    if (centerCams){
        camFollow.x = 1700;
    }
}

function onCameraMove(e){
    switch(curCameraTarget){
        case 0:
            curSong = "brotherly-love"? defaultCamZoom = 1: defaultCamZoom = 0.9;
        case 3:
            defaultCamZoom = 0.9;

        case 1,2:
            defaultCamZoom = 1.1;
    }
}