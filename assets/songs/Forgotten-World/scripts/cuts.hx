import funkin.game.cutscenes.Cutscene;
import funkin.game.cutscenes.ScriptedCutscene;
import funkin.game.cutscenes.VideoCutscene;
import hxvlc.flixel.FlxVideoSprite;
var video:FlxVideoSprite; // used for overlapping the whole camera

function postCreate(){
	video = new FlxVideoSprite(FlxAxes.X,FlxAxes.Y);
	video.bitmap.onEndReached.add(videokill);
    var path = Paths.file("videos/forgottenscene.mp4");
	video.load(Assets.getPath(path));
	video.cameras = [camHUD];
    video.y -= "15";
    video.x -= "1";
    
	insert(1, video);

    camera.alpha = 0.001;
}
function onSongStart() FlxTween.tween(camera, {alpha: 1}, 20, {ease: FlxEase.sineInOut});
function beatHit(curBeat){
    if (curBeat == 360){
        videokill();
        for (i in [timeBar,timeBarBG, timeTxt]){
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
    if (curStep == 1180){
        video.play();
        for (i in [timeBar,timeBarBG, timeTxt]){
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
	FlxTween.tween(video, {alpha:0.001}, 0.5, {ease: FlxEase.sineInOut,
        onComplete: function(twn:FlxTween){
            video.destroy();
            if (Options.gameplayShaders){
                for (i in playerStrums.members){
                    i.shader = glitches;
                }
            }
        }
    });
}