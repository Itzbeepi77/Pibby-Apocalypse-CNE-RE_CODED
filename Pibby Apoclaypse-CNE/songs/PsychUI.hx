import openfl.geom.Rectangle;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import flixel.ui.FlxBar;
import flixel.FlxG;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import flixel.math.FlxPoint;
import openfl.events.KeyboardEvent;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.ui.Keyboard;
import openfl.system.System;
import openfl.text.TextFormat;
import openfl.Lib;
import flixel.FlxG;
import funkin.options.Options;

public var songLength:Float = 0;

public var sicks:Int = 0;
public var goods:Int = 0;
public var bads:Int = 0;
public var shits:Int = 0;

public var timeBarBG:FlxSprite;
public var timeBar:FlxBar;
public var timeTxt:FlxText;
public var hudTxt:FlxText;
public var diffTxt:FlxText;
public var creditTxt:FlxText;
public var creditTxt2:FlxText;
public var barShit:FlxSprite;
public var songTxt:FlxTypeText;
public var hudTxtTween:FlxTween;

public var creditsText:FlxSpriteGroup;

public var fontShit = "vcr";

static var isFinnBar:Bool = true;

var ratingFC:String = "FC";
var ratingStuff:Array<Dynamic> = [
    ['You Suck!', 0.2], //From 0% to 19%
    ['Shit', 0.4], //From 20% to 39%
    ['Bad', 0.5], //From 40% to 49%
    ['Bruh', 0.6], //From 50% to 59%
    ['Meh', 0.69], //From 60% to 68%
    ['Nice', 0.7], //69%
    ['Good', 0.8], //From 70% to 79%
    ['Great', 0.9], //From 80% to 89%
    ['Sick!', 1], //From 90% to 99%
    ['Perfect!!', 1] //The value on this one isn't used actually, since Perfect is always "1"
];

function getRating(accuracy:Float):String {
    if (accuracy < 0) {
        return "?";
    }
    for (rating in ratingStuff) {
        if (accuracy < rating[1]) {
            return rating[0];
        }
    }
    return ratingStuff[ratingStuff.length - 1][0];
}

function getRatingFC(accuracy:Float, misses:Int):String {
    // this sucks but idk how to make it better lol
    if (misses == 0) {
        if (accuracy == 1.0) ratingFC = "SFC";
        else if (accuracy >= 0.9) ratingFC = "GFC";
        else ratingFC = "FC";
        
        if (bads > 0) ratingFC = "MFC";
        
        if (shits > 0) ratingFC = "DFC";
    }
    if (misses > 0) {
        if (misses < 10) ratingFC = "SDCB";
        else if (misses >= 10) ratingFC = "Clear";
    }
}

function create() {
    timeTxt = new FlxText(0, 75, 400, "X:XX - X:XX", 22);
    timeTxt.setFormat(Paths.font(fontShit + ".ttf"), 22, FlxColor.WHTE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    timeTxt.antialiasing = true;
    timeTxt.scrollFactor.set();
    timeTxt.alpha = 0;
    timeTxt.borderColor = 0xFF000000;
    timeTxt.borderSize = 2;
    timeTxt.screenCenter(FlxAxes.X);

    diffTxt = new FlxText(0, timeTxt.y + 50, FlxG.width, '[' + (PlayState.difficulty.toUpperCase()) + ']', 22);
    diffTxt.setFormat(Paths.font(fontShit + ".ttf"), 22, colouredBarB, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    diffTxt.antialiasing = true;
    diffTxt.scrollFactor.set();
    diffTxt.borderColor = 0xFF000000;
    diffTxt.borderSize = 2;
    diffTxt.alpha = 0.001;
    diffTxt.screenCenter(FlxAxes.X);

    hudTxt = new FlxText(0, 685, FlxG.width, "Score: 0 | Combo Breaks: 0 | Rank: ?");
    hudTxt.setFormat(Paths.font(fontShit + ".ttf"), 15, FlxColor.WHTE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    hudTxt.borderSize = 1.25;
    hudTxt.antialiasing = true;
    hudTxt.scrollFactor.set();
    hudTxt.screenCenter(FlxAxes.X);

    timeBarBG = new FunkinSprite(0, FlxG.height).makeSolid(1, 1, 0xFF000000);
    timeBarBG.setGraphicSize(FlxG.width/3.2, 22);
    timeBarBG.scrollFactor.set();
    timeBarBG.updateHitbox();
    timeBarBG.x = timeTxt.x;
    timeBarBG.y = timeTxt.y - 50;
    timeBarBG.alpha = 0;
    add(timeBarBG);

    timeBar = new FlxBar(timeBarBG.x + 4, timeBarBG.y + 4, FlxBar.FILL_LEFT_TO_RIGHT, Std.int(timeBarBG.width - 8), Std.int(timeBarBG.height - 8), null,
    '', 0, 1);
    timeBar.scrollFactor.set();
    timeBar.createFilledBar(0xFF000000,colouredBar);
    timeBar.numDivisions = 100000;
    timeBar.alpha = 0;
    timeBar.value = Conductor.songPosition / Conductor.songDuration;
    timeBar.unbounded = true;
    add(timeBarBG);
    add(timeBar);
    add(timeTxt);
    add(diffTxt);

    timeBarBG.x = timeBar.x - 4;
    timeBarBG.y = timeBar.y - 4;
    hudTxt.x += (!isFinnBar? 50 : 0);

    hudTxt.cameras = [camHUD];
    timeBar.cameras = [camHUD];
    timeBarBG.cameras = [camHUD];
    timeTxt.cameras = [camHUD];
    diffTxt.cameras = [camHUD];
    
    creditsText = new FlxSpriteGroup();
    add(creditsText);

    creditsText.cameras = [camHUD2];

    creditTxt = new FlxText(0, diffTxt.y - 100, FlxG.width, PlayState.SONG.meta.displayName, 22);
    creditTxt.setFormat(Paths.font(fontShit + ".ttf"), 50, colouredBar, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    creditTxt.antialiasing = true;
    creditTxt.scrollFactor.set();
    creditTxt.borderColor = 0xFF000000;
    creditTxt.borderSize = 2;
    creditTxt.screenCenter(FlxAxes.X);
    

    creditTxt2 = new FlxText(0, creditTxt.y, FlxG.width, 'by - ' + composeNames(PlayState.SONG.meta.name), 22);
    creditTxt2.setFormat(Paths.font(fontShit + ".ttf"), 50, colouredBar, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    creditTxt2.antialiasing = true;
    creditTxt2.scrollFactor.set();
    creditTxt2.borderColor = 0xFF000000;
    creditTxt2.borderSize = 2;
    creditTxt2.screenCenter(FlxAxes.X);
    
    creditsText.add(creditTxt2);
    creditsText.add(creditTxt);
    
    barShit = new FlxSprite(creditTxt.x, creditTxt.y + creditTxt.height + 4).makeSolid(1, 1, colouredBar);
    barShit.scale.set(0, 6);
    barShit.updateHitbox();
    barShit.scrollFactor.set();
    barShit.screenCenter(FlxAxes.X);
    creditsText.add(barShit);

    songTxt = new FlxTypeText(25, timeBarBG.y, 0, "");
    songTxt.setFormat(Paths.font("horizon.otf"), 15, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    songTxt.scrollFactor.set();
    songTxt.alpha = 0.001;
    songTxt.borderSize = 2;
    add(songTxt);

    songTxt.cameras = [camHUD];

    songTxt.revive();
    songTxt.resetText(PlayState.SONG.meta.displayName);
    songTxt.start(0.1, true);

    for (i in [creditTxt, creditTxt2]) i.alpha = 0;
}

function onSongStart(){
    if (curSong == "childs-play"){
        songLength = 152000;
    }
    if (curSong == "retcon"){
        songLength = 150290;
    
    }
    for (i in [timeBar, timeBarBG, timeTxt]) FlxTween.tween(i, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
}

function update(elapsed:Float) {
    if (curStep >= 1){
        timeTxt.text = CoolUtil.timeToStr(Conductor.songPosition).split('.')[0] + ' - ' + CoolUtil.timeToStr(songLength).split('.')[0];
        timeBar.percent = (Conductor.songPosition/songLength)*100;
    }

    var acc = FlxMath.roundDecimal(Math.max(accuracy, 0) * 100, 2);
    var rating:String = getRating(accuracy);
    getRatingFC(accuracy, misses);
    if (songScore > 0 || acc > 0 || misses > 0)
        hudTxt.text = "Score: " + songScore + " | Combo Breaks: " + misses +  " | Rank: " + ratingFC + " (" + acc + "%)";
}

function onPlayerHit(event) {
    if (event.note.isSustainNote) return;

    if(hudTxtTween != null) hudTxtTween.cancel();
    hudTxt.angle = FlxG.random.int(-2,2, [-1, 0, 1]);
    hudTxtTween = FlxTween.tween(hudTxt, {angle: 0}, 0.2, {onComplete: function(twn:FlxTween) {hudTxtTween = null;}});

    switch (event.rating) {
        case "sick": sicks++;
        case "good": goods++;
        case "bad": bads++;
        case "shit": shits++;
    }
}

function postCreate() {
	songLength = inst.length;

    for (i in [missesTxt, accuracyTxt, scoreTxt]) i.visible = false;

    if (downscroll) hudTxt.y = healthBarBG.y - 58;
    else if (!downscroll) hudTxt.y = healthBarBG.y + 38;

    add(hudTxt);
}