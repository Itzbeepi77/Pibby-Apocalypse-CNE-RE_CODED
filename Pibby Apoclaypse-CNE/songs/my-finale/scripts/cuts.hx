import funkin.game.cutscenes.Cutscene;
import funkin.game.cutscenes.ScriptedCutscene;
import funkin.game.cutscenes.VideoCutscene;
import hxvlc.flixel.FlxVideoSprite;
var video = null; // used for overlapping the whole camera

function postCreate(){
	video = new FlxVideoSprite(FlxAxes.X,FlxAxes.Y);
	video.bitmap.onEndReached.add(videokill);
    var path = Paths.file("videos/FinaleScene_Alt.mp4");
	video.load(Assets.getPath(path));
	video.cameras = [camHUD];
    video.y -= "15";
    video.x -= "1";
    
	insert(1, video);
}
function beatHit(curBeat){
    if (curBeat == 480){
        //videokill();
        for (i in [timeBar,timeBarBG, timeTxt, iconP1, iconP2, pibbyHealthbar, hudTxt, diffTxt]){
            i.alpha = 1;
        }
        for (i in playerStrums.members){
            i.alpha = 1;
        }
        for (i in cpuStrums.members){
            i.alpha = 1;
        }
    }
}
function stepHit(curStep){
    if (Options.gameplayShaders){
        if (curStep == 532){
            for (i in playerStrums.members){
                i.shader = distorFNF;
            }
        }
        if (curStep == 533 || curStep == 3224){
            if (boyfriend.shader == null) boyfriend.shader = distorFNF;
        }
        if (curStep == 536 || curStep == 3233){
            if (boyfriend.shader == distorFNF) boyfriend.shader = null;
        }
    }

    if (curStep == 3249){
        fullPibbyHealthbar = true;
    }
    if (curStep > 3249){
        health = 0.02;
    }
    
    if (curStep == 1297){
        //video.play();
        for (i in [timeBar,timeBarBG, timeTxt, iconP1, iconP2, pibbyHealthbar, hudTxt]){
            i.alpha = 0.001;
        }
        for (i in playerStrums.members){
            i.alpha = 0.001;
        }
        for (i in cpuStrums.members){
            i.alpha = 0.001;
        }
    }
}
function videokill(){
	FlxTween.tween(video, {alpha:0.001}, 0.001, {ease: FlxEase.sineInOut, startDelay: 1.3,
        onComplete: function(twn:FlxTween){
            video.destroy();
        }
    });
}