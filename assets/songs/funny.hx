public var kys = FlxG.save.data.funnyGoofyAhhPibbyCorruptedAngleCameraMovingMFSTFUKYSIDCLikeRealyGoofyAhhShitMFTurnOnThisOptionToHaveASurprise;

var angleVar:Float = 1;
var angleShit:Float = 1;

function beatHit(curBeat){
    if(kys && camZooming) { //FOR THE FUNNY
        if (curBeat % 2 == 0) {
            angleShit = angleVar;
        }else {
            angleShit = -angleVar;
        }
        camHUD.angle = angleShit * 3;
        camGame.angle = angleShit * 3;
        FlxTween.tween(camHUD, {angle: angleShit}, Conductor.stepCrochet * 0.002, {
            ease: FlxEase.circOut,
        });
        FlxTween.tween(camGame, {angle: angleShit}, Conductor.stepCrochet * 0.002, {
            ease: FlxEase.circOut,
        });
        FlxTween.tween(camHUD, {x: -angleShit*8}, Conductor.crochet * 0.001, {
            ease: FlxEase.linear,
        });
        FlxTween.tween(camGame, {x: -angleShit*8}, Conductor.crochet * 0.001, {
            ease: FlxEase.linear,
        });
    }
}
function stepHit(curStep){
    if(kys && camZooming) { //FOR THE FUNNY
        if (curStep % 4 == 0) {
            FlxTween.tween(camHUD, {y: -12}, Conductor.stepCrochet * 0.002, {
                ease: FlxEase.circOut,
            });
            FlxTween.tween(camGame.scroll, {y: camGame.scroll.y + 12}, Conductor.stepCrochet * 0.002, {
                ease: FlxEase.sineIn,
            });
        }
        if (curStep % 4 == 2) {
            FlxTween.tween(camHUD, {y: 0}, Conductor.stepCrochet * 0.002, {
                ease: FlxEase.sineIn,
            });
            FlxTween.tween(camGame.scroll, {y: camGame.scroll.y - 12}, Conductor.stepCrochet * 0.002, {
                ease: FlxEase.sineIn,
            });
        }
    }
}