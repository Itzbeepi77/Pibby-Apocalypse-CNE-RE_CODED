importScript("data/scripts/iconP3");

var dadTween:FlxTween;
var gfTween:FlxTween;
var bfTween:FlxTween;
var velocityBruh:Int = 1;

var originY = [];
function postCreate(){
    for (chars in [dad, gf, boyfriend]) originY.push(chars.y);
}

function create(){
    bfTween = floating(boyfriend, -22.5, 22.5, 2.5, 2.5);
    gfTween = floating(gf, -22.5, 22.5, 2.5, 2.5);
    dadTween = floating(dad, 16, -16, 2.5, 2.5);
}

function floating(obj, val1, val2, time1, time2){
    FlxTween.tween(obj, {y: obj.y + val1}, time1/velocityBruh, {
        ease: FlxEase.sineInOut,
        onComplete: function(twn){
            FlxTween.tween(obj, {y: obj.y + val2}, time2/velocityBruh, {
                ease: FlxEase.sineInOut,
                onComplete: function(twn){
                    floating(obj, val1, val2, time1, time2);     
                }
            });
        }
    });
}

function onEvent(e){
    if (e.event.name == "AppleFilter"){
        if (e.event.params[0] == true){
            for (charsTween in [bfTween, dadTween, gfTween])
                charsTween.active = false;

            for (chars in [boyfriend, gf, dad]){
                FlxTween.cancelTweensOf(chars);

                chars.y = originY[chars];

                dad.y += 50;
            }
        }
    }
}

function stepHit(step){
    if (step == 768){
        velocityBruh = 1;
    }
    if (step == 512 || step == 1024){
        velocityBruh = 2;
    }
    if (step == 1280){
        velocityBruh = 5;
    }
    if (step == 1536 || step == 1792 || step == 1824){
        velocityBruh = 10;
    }
}