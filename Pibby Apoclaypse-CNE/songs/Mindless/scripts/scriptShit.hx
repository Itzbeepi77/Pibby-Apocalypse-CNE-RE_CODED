importScript("data/scripts/healthBar-Finn_Jake");

if (curStage != "lab") return;// fuck you >:(
var flickerTween:Array<FlxTween> = [];
var flickerTween2:Array<FlxTween> = [];

function create(){
    if (!lowMem){
        flickerTween = FlxTween.tween(stage.getSprite("light"), {alpha: 0}, 0.25, {ease: FlxEase.bounceInOut, type: 4});
        flickerTween.active = false;
    
        flickerTween2 = FlxTween.tween(stage.getSprite("light"), {alpha: 0}, 0.25, {ease: FlxEase.bounceInOut, type: 4});
        flickerTween2.active = false;
    }

}
function postCreate()for (shit in [iconP1,iconP2,camera])shit.alpha = 0.001;
function onSongStart(){
    camera.alpha = 1;
    camera.flash(FlxColor.BLACK, 1.25);
}
function stepHit(curStep){
    if (curStep == 256){
        FlxTween.tween(camera, {alpha:0.001}, 1.5, {startDelay: 0.75});
        FlxTween.tween(camera, {zoom: 2}, 1.5, {startDelay: 0.5});
    }
    if (curStep == 288){
        FlxTween.tween(camera, {alpha:1}, 1, {startDelay: 0.5});
        stage.getSprite("bg").alpha = 1;
        dad.alpha = 1;
        
        if (!lowMem){
            stage.getSprite("light").alpha = 1;
            stage.getSprite("bulb").alpha = 1;
            stage.getSprite("dark").alpha = 1;
        }

    }
    if (curStep == 1576){
        FlxTween.tween(stage.getSprite("bg"), {alpha: 0.001}, 0.3);
        
        if (!lowMem){
            for (shits in [stage.getSprite("light"),stage.getSprite("bulb"),stage.getSprite("dark")]){
                FlxTween.tween(shits, {alpha: 0.001}, 0.3);
            }
        }

        for (chars in [gf,dad,boyfriend]){
            FlxTween.tween(chars, {alpha: 0.001}, 0.3);
        }
        stage.getSprite("Finntransform").alpha = 1;
        stage.getSprite("Finntransform").active = true;
    }
    if (curStep == 1615){
        stage.getSprite("bg").alpha = 1;
        
        if (!lowMem){
            stage.getSprite("light").alpha = 1;
            stage.getSprite("bulb").alpha = 1;
            stage.getSprite("dark").alpha = 1;
        }

        gf.alpha = 1;
        dad.alpha = 1;
        boyfriend.alpha = 1;
        stage.getSprite("Finntransform").alpha = 0.0001;
        stage.getSprite("Finntransform").active = false;
    }
    if (curStep == 3712){
        camera.fade(FlxColor.BLACK, 1.5);
        camHUD.fade(FlxColor.BLACK, 1.5);
    }
    if (curStep == 288){
        if (!lowMem){
            flickerTween.active = true;
            flickerTween2.active = true;
        }

    }
    if (curStep == 1576){
        if (!lowMem){
            flickerTween.active = false;
            flickerTween2.active = false;
        }
    }
    if (curStep == 1613){
        if (!lowMem){
            flickerTween.active = true;
            flickerTween2.active = true;
        }
    }
    if (curStep == 340){
        for (shit in [iconP1,iconP2])FlxTween.tween(shit, {alpha: 1}, 0.5);
        FlxTween.tween(bar, {alpha: 1}, 0.5);
    }
}