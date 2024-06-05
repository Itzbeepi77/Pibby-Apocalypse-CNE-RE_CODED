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

static var isFinnBar:Bool = true;
static var songLength:Float = 0;

static var sicks:Int = 0;
static var goods:Int = 0;
static var bads:Int = 0;
static var shits:Int = 0;

static var timeBarBG:FlxSprite;
static var timeBar:FlxBar;
static var timeTxt:FlxText;
static var hudTxt:FlxText;
static var hudTxtTween:FlxTween;

static var fontShit = "";

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
        else if (accuracy >= 0.99) ratingFC = "GFC";
        else ratingFC = "FC";
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
    timeBar.numDivisions = 8000;
    timeBar.alpha = 0;
    timeBar.value = Conductor.songPosition / Conductor.songDuration;
    timeBar.unbounded = true;
    add(timeBarBG);
    add(timeBar);
    add(timeTxt);

    timeBarBG.x = timeBar.x - 4;
    timeBarBG.y = timeBar.y - 4;
    hudTxt.x += (!isFinnBar? 50 : 0);

    hudTxt.cameras = [camHUD];
    timeBar.cameras = [camHUD];
    timeBarBG.cameras = [camHUD];
    timeTxt.cameras = [camHUD];
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
    hudTxt.angle = FlxG.random.float(-2.5,2.5);
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