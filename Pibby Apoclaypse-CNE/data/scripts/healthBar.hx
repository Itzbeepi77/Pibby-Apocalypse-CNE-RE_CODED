public var fullPibbyHealthbar:Bool = false;
public var pibbyHealthbar:FlxSprite;

function postCreate() {
    var image = Options.gameplayShaders? "healthbarShader" : "healthbar";

    pibbyHealthbar = new FlxSprite();
    pibbyHealthbar.frames = Paths.getSparrowAtlas('healthbar/' + image);
    pibbyHealthbar.scale.set(1, 1);
    pibbyHealthbar.updateHitbox();
    for(i in 0...41){
        var indiceStart = i * 3;
        var animFrames = [indiceStart, indiceStart + 1, indiceStart + 2]; 
           pibbyHealthbar.animation.addByIndices(snap((i/40)*100, 2.5) + 'Percent', "healthbar", animFrames, "", 12, true);
    }
    pibbyHealthbar.animation.play("50Percent",true); // 50% damage, cus hp starts at half (1 / 2)
    pibbyHealthbar.x = 65;
    pibbyHealthbar.y = iconP1.y + 50;
    pibbyHealthbar.cameras = [camHUD];
    insert(members.indexOf(healthBar)+1, pibbyHealthbar);

    if (Options.gameplayShaders) {
        pibbyHealthbar.shader = gReplaceCol; //it makes the healthbar not disappeared...
    }

    healthBar.alpha = 0.001;
    healthBarBG.alpha = 0.001;

    hudTxt.x -= 300;
}

function update(elapsed){

    var healthPercent = health * 0.5; // i would do / 2 but iirc multiplication is more optimized than division in alot of cases
    var damagePercent = 1 - healthPercent;

    if(fullPibbyHealthbar)
        pibbyHealthbar.animation.play('100Percent'); // full bar
    else
        pibbyHealthbar.animation.play((snap(damagePercent*100, 2.5)) + "Percent"); // snaps to multiples of 2.5
}

function postUpdate(elapsed){
    iconP1.x = 520;
    iconP2.x = 50;
    
}

function shitStep(step:Int){

    if (FlxG.random.float(1,3) < 1.5){
        /*
        pibbyHealthbar.colorTransform.redOffset = FlxG.random.float(-255, 255);
        pibbyHealthbar.colorTransform.greenOffset = FlxG.random.float(-255, 255);
        pibbyHealthbar.colorTransform.blueOffset = FlxG.random.float(-255, 255);*/
        
        pibbyHealthbar.colorTransform.redMultiplier = FlxG.random.float(0, 1);
        pibbyHealthbar.colorTransform.greenMultiplier = FlxG.random.float(0, 1);
        pibbyHealthbar.colorTransform.blueMultiplier = FlxG.random.float(0, 1);
    } else if (FlxG.random.float(1,5) < 1.75){
        /*
        pibbyHealthbar.colorTransform.redOffset = FlxG.random.float(255, -255);
        pibbyHealthbar.colorTransform.greenOffset = FlxG.random.float(255, -255);
        pibbyHealthbar.colorTransform.blueOffset = FlxG.random.float(255, -255);*/
        
        pibbyHealthbar.colorTransform.redMultiplier = FlxG.random.float(1, 0);
        pibbyHealthbar.colorTransform.greenMultiplier = FlxG.random.float(1, 0);
        pibbyHealthbar.colorTransform.blueMultiplier = FlxG.random.float(1, 0);
    } else {
        pibbyHealthbar.colorTransform.redOffset = 0;
        pibbyHealthbar.colorTransform.greenOffset = 0;
        pibbyHealthbar.colorTransform.blueOffset = 0;
    }
}

function snap(f:Float, snap:Float){// ye yeh
    var m:Float = Math.fround(f/snap);
    return (m * snap);
}