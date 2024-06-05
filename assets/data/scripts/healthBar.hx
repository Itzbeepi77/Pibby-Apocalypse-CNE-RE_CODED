public var fullPibbyHealthbar:Bool = false;
public var pibbyHealthbar:FlxSprite;

function postCreate() {
    pibbyHealthbar = new FlxSprite();
    pibbyHealthbar.frames = Paths.getSparrowAtlas('healthbar/healthbar', null, true);
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

function snap(f:Float, snap:Float){// ye yeh
    var m:Float = Math.fround(f/snap);
    return (m * snap);
}