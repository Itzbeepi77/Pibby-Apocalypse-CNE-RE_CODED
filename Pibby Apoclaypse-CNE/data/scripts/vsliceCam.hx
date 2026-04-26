import flixel.FlxObject;
import flixel.camera.FlxCameraFollowStyle;
import flixel.tweens.FlxEase;

public var cameraFollowPoint:FlxObject;
public var cameraNotePoint:FlxObject;
public var camFollowRate = 0.04; // used for classic easing

public var classicMode:Bool = true;
public var noteHitMove = true;
public var noteMoveAmt = 20;

public var startFromPlayer:Bool = false;

public var cameraFollowTween:FlxTween;
public var cameraZoomTween:FlxTween;

var cameraBopMultiplier = 1;


var noteOffsets = [0,0];
var isTweening = false;

var angleCamVar:Float = 0;// value for the angle movement
var angleVal = noteMoveAmt/30;
var angleLerp:Float = 0;

function create() {
    cameraFollowPoint = new FlxObject(0, 0);
    add(cameraFollowPoint);

    cameraNotePoint = new FlxObject(0, 0);
    add(cameraNotePoint);
}

function postCreate() {
    isVslice = true;

    if(!startFromPlayer){
        if (dad != null)
            cameraFollowPoint.setPosition(dad.getCameraPosition().x, dad.getCameraPosition().y);
    } else {
        if (boyfriend != null)
            cameraFollowPoint.setPosition(boyfriend.getCameraPosition().x, boyfriend.getCameraPosition().y);
    } 
    resetCamera();
}

function update(elapsed) {
    // the movement will speeded up if you set the 'camera.followLerp' above 0.04
    for (i in [inst, vocals]){
        angleLerp = FlxMath.bound(FlxMath.bound(elapsed * 2.4 / 0.4, 0, 1) + camera.followLerp * i.pitch / 5, 0, 1);
    }
    
    for (i in strumLines.members[curCameraTarget].characters){
        switch(i.getAnimName()){
            case "singLEFT" | "singLEFT-alt":
                noteOffsets = [-noteMoveAmt,0];
                angleCamVar = -angleVal;
            case "singDOWN" | "singDOWN-alt":
                noteOffsets = [0,noteMoveAmt];
            case "singUP" | "singUP-alt":
                noteOffsets = [0,-noteMoveAmt];
            case "singRIGHT" | "singRIGHT-alt":
                noteOffsets = [noteMoveAmt,0];
                angleCamVar = angleVal;
            case "idle":
                noteOffsets = [0,0];
        }
    }

	cameraNotePoint.x = FlxMath.lerp(cameraNotePoint.x, noteOffsets[0], camera.followLerp); 
	cameraNotePoint.y = FlxMath.lerp(cameraNotePoint.y, noteOffsets[1], camera.followLerp); 

    switch(classicMode){
        case true:
            if(noteHitMove){
                for (i in strumLines.members[curCameraTarget].characters){
                    switch(i.getAnimName()){
                        case "singLEFT" | "singLEFT-alt":
                            FlxG.camera.targetOffset.set(-noteMoveAmt, 0);
                            angleCamVar = -angleVal;
                        case "singDOWN" | "singDOWN-alt":
                            FlxG.camera.targetOffset.set(0, noteMoveAmt);
                        case "singUP" | "singUP-alt":
                            FlxG.camera.targetOffset.set(0, -noteMoveAmt);
                        case "singRIGHT" | "singRIGHT-alt":
                            FlxG.camera.targetOffset.set(noteMoveAmt, 0);
                            angleCamVar = angleVal;
                        case "idle":
                            FlxG.camera.targetOffset.set(0, 0);
                    }
                }
            }
        case false:
            //cam position handling
            switch(noteHitMove){
                case false:
                    FlxG.camera.scroll.x = cameraFollowPoint.x - (FlxG.camera.width * 0.5);
                    FlxG.camera.scroll.y = cameraFollowPoint.y - (FlxG.camera.height * 0.5);
                case true:
                    FlxG.camera.scroll.x = cameraFollowPoint.x + cameraNotePoint.x - (FlxG.camera.width * 0.5);
                    FlxG.camera.scroll.y = cameraFollowPoint.y + cameraNotePoint.y - (FlxG.camera.height * 0.5);
            }
    }

    if (angleCamVar != 0) angleCamVar = (lerp(angleCamVar, 0, angleLerp));
    camera.angle = (lerp(camera.angle, 0 + angleCamVar, angleLerp));
}

function postUpdate() {
    //this is mostly just straight out of vslice code lol
    cameraBopMultiplier = FlxMath.lerp(cameraBopMultiplier, 1, camGameZoomLerp); // Lerp bop multiplier back to 1.0x
    var zoomPlusBop = defaultCamZoom * cameraBopMultiplier; // Apply camera bop multiplier.
    camGame.zoom = zoomPlusBop; // Actually apply the zoom to the camera.
    //trace(cameraBopMultiplier+','+zoomPlusBop+','+FlxG.camera.zoom);
}

function beatHit() {
    if (Options.camZoomOnBeat && camZooming && curBeat % camZoomingInterval == 0)
		{
			cameraBopMultiplier += 0.015 * camZoomingStrength;
		}
}
function onEvent(event) {
    if (event.event.name == "Camera Movement") {
		var char = strumLines.members[event.event.params[0]].characters[0];
        var cameraPos =  char.getCameraPosition();
        var targetX = cameraPos.x;
        var targetY = cameraPos.y;
        resetCamera(false, true, true);
        setCameraPos(targetX, targetY);
        trace('\nFOCUSED CHAR:'+char.curCharacter+'\nx:'+targetX+'\ny:'+targetY);
    }
    if (event.event.name == "VSlice Camera Movement") {
		var char = strumLines.members[event.event.params[0]].characters[0];
        curCameraTarget = event.event.params[0];
        var cameraPos =  char.getCameraPosition();

        var targetX = event.event.params[2];
        var targetY = event.event.params[3];
        var tweens = [
            'Linear (Ignores Direction)' => 'linear',
            'Sine' => 'sine',
            'Quad' => 'quad',
            'Cube' => 'cube',
            'Quart' => 'quart',
            'Quint' => 'quint',
            'Expo' => 'expo',
            'Smooth Step' => 'smoothStep',
            'Elastic' => 'elastic',
            'In' => 'In',
            'Out' => 'Out',
            'In/Out' => 'InOut',
            'Instant (Ignores Duration and Direction)' => 'INSTANT',
            'Classic (Ignores Duration and Direction)' => 'CLASSIC'
        ];
        var ease = tweens.get(event.event.params[5]);
        var ease2 = tweens.get(event.event.params[6]);
        var duration = event.event.params[4];
        var posInstead = event.event.params[1];

        var durSeconds = (Conductor.stepCrochet / 1000) * duration;

        trace('\nFOCUSED CHAR:'+char.curCharacter+'\nposInstead:'+posInstead+'\nx:'+targetX+'\ny:'+targetY+'\nduration:'+duration+'\neaseStyle:'+ease+'\neaseDirection:'+ease2);
        
        switch (posInstead){
            case true:
                //idk
            case false:
                targetX += cameraPos.x;
                targetY += cameraPos.y;
        }
        switch(ease){
            case 'INSTANT':
                resetCamera(false, true, false);
                //cameraFollowPoint.setPosition(targetX, targetY);
                setCameraPos(targetX, targetY);
            case 'CLASSIC':
                resetCamera(false, true, true);
                setCameraPos(targetX, targetY);
            case 'linear':
                tweenCameraPos(targetX, targetY, durSeconds, FlxEase.linear);
            default:
                var easeFunction:Null<Float->Float> = Reflect.field(FlxEase, ease+ease2);
                if (easeFunction == null)
                {
                  trace('Invalid ease function: $ease');
                  return;
                }

                tweenCameraPos(targetX, targetY, durSeconds, easeFunction);

        }
    }
    if (event.event.name == "VSlice Camera Zoom"){
        var zoom = event.event.params[0];
        var direct = event.event.params[1];
        var duration = event.event.params[2];
        var tweens = [
            'Linear (Ignores Direction)' => 'linear',
            'Instant (Ignores Direction)' => 'INSTANT',
            'Sine' => 'sine',
            'Quad' => 'quad',
            'Cube' => 'cube',
            'Quart' => 'quart',
            'Quint' => 'quint',
            'Expo' => 'expo',
            'Smooth Step' => 'smoothStep',
            'Elastic' => 'elastic',
            'In' => 'In',
            'Out' => 'Out',
            'In/Out' => 'InOut'
        ];
        var ease1 = tweens.get(event.event.params[3]);
        var ease2 = tweens.get(event.event.params[4]);

        var durSeconds = (Conductor.stepCrochet / 1000) * duration;

        camZooming = true;
        switch (ease1)
        {
          case 'INSTANT':
            tweenCamZoom(zoom, 0, direct);
          case 'linear':
            tweenCamZoom(zoom, durSeconds, direct, FlxEase.linear);
          default:
            var easeFunction:Null<Float->Float> = Reflect.field(FlxEase, ease1+ease2);
            if (easeFunction == null)
            {
              trace('Invalid ease function: $ease');
              return;
            }
    
            tweenCamZoom(zoom, durSeconds, direct, easeFunction);
        }
    }
    if (event.event.name == "CamMove Toggle"){
        noteHitMove = event.event.params[0];
    }
}

public function setCameraPos(?targetX:Float, ?targetY:Float) {
    cameraFollowPoint.setPosition(targetX, targetY);
}

public function tweenCameraPos(?targetX:Float, ?targetY:Float, ?duration:Float, ?ease:Null<Float->Float>) {
    cancelCamFollowTween();
    resetCamera(false, true, false);

    if(duration == 0){
        resetCamera(false, true, false);
        setCameraPos(targetX, targetY);
    }else{
        cameraFollowTween = FlxTween.tween(cameraFollowPoint, {x: targetX, y: targetY}, duration, {
            ease: ease,
            onComplete: function(_) {
              //resetCamera(false, false);
            }
        });
    }
}

public function tweenCamZoom(?zoom:Float, ?duration:Float, ?direct:Bool, ?ease:Null<Float->Float>):Void
    {
        cancelCamZoomTween();

        var targetZoom = zoom * (direct ? 1 : defaultCamZoom);
      
        if (duration == 0)
        {
            defaultCamZoom = targetZoom;
        }
        else
        {
            cameraZoomTween = FlxTween.tween(this, {defaultCamZoom: targetZoom}, duration, {
                ease: ease
            });
        }
    }

public function resetCamera(?resetZoom:Bool = true, ?cancelTweens:Bool = true, ?classic = false) {
    if (cancelTweens){
        cancelCamFollowTween();
    }
    if (classic){
        classicMode = true;
        FlxG.camera.follow(cameraFollowPoint, null, camera.followLerp);
    }else{
        FlxG.camera.target = null;
        classicMode = false;
    }
}

public function cancelCamFollowTween() {
    if (cameraFollowTween != null){
        cameraFollowTween.cancel();
    }
}

public function cancelCamZoomTween() {
    if (cameraZoomTween != null){
        cameraZoomTween.cancel();
    }
}