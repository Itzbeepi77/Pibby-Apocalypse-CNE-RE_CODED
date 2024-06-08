static var bar:FlxSprite;
static var hitSHits:Int = 0;

function postCreate(){
    fontShit = "Finn";

    hudTxt.scale.y = hudTxt.scale.x += .25;

    bar = new FlxSprite(190, 490);
    bar.frames = Paths.getSparrowAtlas('healthbar/iconbar');
    bar.animation.addByPrefix('bar', 'Icons Bar0', 24, false);
    bar.animation.addByPrefix('bar1', 'Icons Bar 1', 24, false);
    bar.animation.addByPrefix('bar2', 'Icons Bar 2', 24, false);
    bar.animation.addByPrefix('bar3', 'Icons Bar 3', 24, false);
    bar.animation.addByPrefix('barLoss1', 'Icon Bar 1 Lost', 24, false);
    bar.animation.addByPrefix('barLoss2', 'Icon bar 2 Lost', 24, false);
    bar.scrollFactor.set();
    bar.updateHitbox();
    bar.antialiasing = true;
    bar.cameras = [camHUD];
	insert(members.indexOf(iconP1)-2, bar);
    bar.animation.play('bar1');
    if (!downscroll){
        bar.y = 580;
    }

    switch(curSong){
        default:
            bar.alpha = 1;
        case "mindless", "come-along-with-me":
            bar.alpha = 0.001;
    }

    for (hBars in [healthBar,healthBarBG])hBars.alpha = 0.001;
}

function beatHit(curBeat){
    bar.animation.play(bar.animation.curAnim.name);
}

function onPlayerMiss(e){
    if (e.noteType == "" || e.noteType == null) return;// hell yeah the real mechanic of finn&jake hpBar
    
    if (e.noteType == "Dodge Note" || e.noteType == "Sword-parry Note"){
        hitSHits++;
        if (hitSHits == 1){
            bar.animation.play("bar2");
        } else if (hitSHits == 2){
            bar.animation.play("bar3");
        }
        else if (hitSHits == 3)health -= 2;// yuh

        trace(hitSHits);// trace how much that you missed
    }
}

function postUpdate(elapsed:Float){
    iconP1.x = 620;
    iconP2.x = 520;
}