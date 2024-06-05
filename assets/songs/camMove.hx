public var disableCamMove:Bool = false;

var angleCamVar:Float = 0;
function postUpdate(elapsed){
    // the movement will speeded up if you set the 'camera.followLerp' above 0.04
    var angleLerp:Float = FlxMath.bound(FlxMath.bound(elapsed * 2.4 / 0.4, 0, 1) + camera.followLerp * 1 / 5, 0, 1);

    if (curCameraTarget == null || curCameraTarget == -1 || disableCamMove) return;
        switch (strumLines.members[curCameraTarget].characters[0].getAnimName()) {
            case "singLEFT", "singLEFT-alt": 
                camFollow.x -= 20;
                angleCamVar = -20/30;
            case "singDOWN", "singDOWN-alt": 
                camFollow.y += 20;
            case "singUP", "singUP-alt": 
                camFollow.y -= 20;
            case "singRIGHT", "singRIGHT-alt": 
                camFollow.x += 20;
                angleCamVar = 20/30;
    }
    if (angleCamVar != 0) angleCamVar = (lerp(angleCamVar, 0, angleLerp));
    camera.angle = (lerp(camera.angle, 0 + angleCamVar, angleLerp));
}