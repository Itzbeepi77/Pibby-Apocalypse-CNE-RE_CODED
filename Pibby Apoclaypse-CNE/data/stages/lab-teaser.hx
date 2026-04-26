import flixel.effects.FlxFlicker;
//import flash.display.BlendMode;

var lamp_swing, lamp_swing2, lamp_swing3, redLights:FlxTween;
function postCreate(){
    light_shit.colorTransform.color = FlxColor.YELLOW;

    light_shit.blend = 12;

    light_shit.scale.y += 1;

    lamp_swing = loopAngle(dark, 1, -1, 2.5, 2.5);

    lamp_swing2 = loopAngle(light_shit, 1, -1, 2.5, 2.5);

    lamp_swing3 = loopAngle(bulb, 1, -1, 2.5, 2.5);

    camera.alpha = 0.001;
}

function onSongStart(){
    camera.alpha = 1;

    camera.flash(FlxColor.BLACK, 20);
}

function loopAngle(shit, val1, val2, time1, time2){
    FlxTween.tween(shit, {angle: val1}, time1, {
        ease: FlxEase.sineInOut,
        onComplete: 
        function (twn:FlxTween)
            {
                FlxTween.tween(shit, {angle: val2}, time2, {
                    ease: FlxEase.sineInOut,
                    onComplete: 
                    function (twn:FlxTween)
                        {
                            loopAngle(shit, val1, val2, time1, time2);
                        }
                });
            }
    });
}

var light_flick:Bool = false;
function stepHit(step){
    if (step == 688){
        camera.followLerp = 0.08;

        for (i in [dark, light_shit]){
            i.alpha = 1;
            FlxFlicker.flicker(i, 1.35, 0.06, true,  false, function(flick){
                bulb.alpha = 1;
                dark.alpha = 0.7;

                light_flick = true;

                bg.alpha = 1;

                for (darkBGs in [bg_dark, light]) darkBGs.visible = false;
            });
        }
    }
    if (step == 1473){
        light_flick = false;

        redLights = FlxTween.tween(red_light, {alpha: 1}, 5, {ease: FlxEase.sineInOut, type: 4});
    }
    if (step == 1739){
        light_flick = true;
        dark.alpha = 0.7;

        if (redLights != null) redLights.cancel();
        redLights = FlxTween.tween(red_light, {alpha: 0}, 5, {ease: FlxEase.sineInOut});
    }
}
function postUpdate(elapsed){
    if (light_flick){
        light_shit.alpha = FlxG.random.float(1,0.9);
    }
}