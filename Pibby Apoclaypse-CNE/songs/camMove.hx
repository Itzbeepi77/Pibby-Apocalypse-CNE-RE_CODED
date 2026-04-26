public var disableCamMove:Bool = false;
public var isVslice:Bool = false;

var angleCamVar:Float = 0;// value for the angle movement
var moveVal = 20;
var angleVal = moveVal/30;
var angleLerp:Float = 0;

function postCreate(){
    trace("angle cam Lerp : " + angleLerp);
}

function postUpdate(elapsed){
    // the movement will speeded up if you set the 'camera.followLerp' above 0.04
    for (i in [inst, vocals]){
        angleLerp = FlxMath.bound(FlxMath.bound(elapsed * 2.4 / 0.4, 0, 1) + camera.followLerp * i.pitch / 5, 0, 1);
    }

    if (curCameraTarget == null || curCameraTarget == -1 || disableCamMove || isVslice) return;
    else if (StringTools.contains(strumLines.members[curCameraTarget].characters[0].getAnimName().toLowerCase(), "left")){
        camFollow.x -= moveVal;
        angleCamVar = -angleVal;
    }
    else if (StringTools.contains(strumLines.members[curCameraTarget].characters[0].getAnimName().toLowerCase(), "down")){
        camFollow.y += moveVal;
    }
    else if (StringTools.contains(strumLines.members[curCameraTarget].characters[0].getAnimName().toLowerCase(), "up")){
        camFollow.y -= moveVal;
    }
    else if (StringTools.contains(strumLines.members[curCameraTarget].characters[0].getAnimName().toLowerCase(), "right")){
        camFollow.x += moveVal;
        angleCamVar = angleVal;
    }

    if (angleCamVar != 0) angleCamVar = (lerp(angleCamVar, 0, angleLerp));
    camera.angle = (lerp(camera.angle, 0 + angleCamVar, angleLerp));
}
function onEvent(e){
    if(e.event.name == "CamMove Toggle"){
        disableCamMove = e.event.params[0];
    }
}