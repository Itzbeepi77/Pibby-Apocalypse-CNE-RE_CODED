import funkin.backend.chart.Chart;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import openfl.text.TextField;
import openfl.text.TextFormat;
import flixel.FlxG;
import flixel.ui.FlxBar;

// yuh
var pibbyShader:CustomShader = new CustomShader('glitchThingy');
var bloom:CustomShader = new CustomShader('bloom');// bloom shader

var songList:Array<ChartMetaData> = [];
var songListFound:Array<String> = [];
var curSelected:Int = 0;

var threatPercent:Int;
var threatLerp:Float = 0;

var dogeTxt:FlxText;

var songText:FlxTypeText;
var artistText:FlxTypeText;

var bg:FlxSprite;
var arrowL:FlxSprite;
var arrowR:FlxSprite;

var image:FlxSprite;
var stagebox:FlxSprite;
var stagebox_L:FlxSprite;
var stagebox_R:FlxSprite;

var threat:FlxSprite;
var levelBarBG:FlxSprite;
var levelBar:FlxBar;

var gradient:FlxSprite;

var saveY:Float;
var saveHeroY:Float;
var canPress = false;

var resetSecretTimer:FlxTimer;
var isResetTimerRunning:Bool = false;

var pressed:Float = 0;

var glitchTime:Float = 0;
var gradientSineThing:Float = 0;

function create(){
    if (Options.gameplayShaders){
        FlxG.camera.addShader(pibbyShader);
    
        pibbyShader.iMouseX = 500;
        pibbyShader.NUM_SAMPLES = 3;
        bloom.size = 100;
    }

    window.title = "Pibby: Apocalypse - Freeplay";
    
	FlxG.mouse.visible = true;

    FlxG.sound.playMusic(Paths.music("fpmenu"));

    songListFound = CoolUtil.coolTextFile(Paths.txt('freeplaySonglist'));// gets the songList that are typed inside `data/freeplaySonglist.txt`
    if (songListFound.length > 0) {
        for(s in songListFound)
            songList.push(Chart.loadChartMeta(s, "normal"));
    }

    new FlxTimer().start(0.5, grah -> canPress = true);

    bg = new FlxSprite();
    bg.frames = Paths.getSparrowAtlas('menus/fpmenu/background');
    bg.animation.addByPrefix('idle', 'background idle', 30, true);
    bg.animation.play('idle');
    bg.antialiasing = true;
    add(bg);
    bg.screenCenter();
    
    saveY = FlxG.camera.y;
    
	threat = new FlxSprite().loadGraphic(Paths.image('menus/fpmenu/threatLevel'));
	threat.antialiasing = true;
	add(threat);
	threat.screenCenter();

    image = new FlxSprite().loadGraphic(Paths.image('menus/fpmenu/stage/' + songList[curSelected].displayName));
    image.antialiasing = true;
    add(image);
    image.screenCenter();

    stagebox = new FlxSprite().loadGraphic(Paths.image('menus/fpmenu/stageBox'));
    stagebox.antialiasing = true;
    add(stagebox);
    stagebox.screenCenter();
    
    stagebox_L = new FlxSprite().loadGraphicFromSprite(stagebox);
    stagebox_L.alpha = 0.6;
    add(stagebox_L);
    stagebox_L.x = stagebox.x - 500;
    stagebox_L.setGraphicSize(Std.int(stagebox_L.width * 0.45));

    stagebox_R = new FlxSprite().loadGraphicFromSprite(stagebox);
    stagebox_R.alpha = 0.6;
    add(stagebox_R);
    stagebox_R.x = stagebox.x + 500;
    stagebox_R.setGraphicSize(Std.int(stagebox_R.width * 0.45));

    arrowL = new FlxSprite().loadGraphic(Paths.image('menus/fpmenu/arrowL'));
    arrowL.antialiasing = true;
    add(arrowL);
    arrowL.scale.set(4, 4);
    arrowL.blend = "ADD";
    if (Options.gameplayShaders) arrowL.shader = bloom;
    arrowL.screenCenter();

    arrowR = new FlxSprite().loadGraphic(Paths.image('menus/fpmenu/arrowR'));
    arrowR.antialiasing = true;
    add(arrowR);
    arrowR.scale.set(4, 4);
    arrowR.blend = "ADD";
    if (Options.gameplayShaders) arrowR.shader = bloom;
    arrowR.screenCenter();
    
	songText = new FlxTypeText(image.x, image.y + 35, FlxG.width * 1, songList[curSelected].displayName);
	songText.antialiasing = true;
	songText.setFormat(Paths.font("menuFont.ttf"), 64, FlxColor.WHITE, "center");
	songText.blend = "ADD";
	if (Options.gameplayShaders) songText.shader = bloom;
	add(songText);

	artistText = new FlxTypeText(songText.x, songText.y + 80, FlxG.width * 1, getSongArtist(songList[curSelected].displayName).toUpperCase());
	artistText.antialiasing = true;
	artistText.setFormat(Paths.font("menuFont.ttf"), 36, FlxColor.WHITE, "center");
	artistText.blend = "ADD";
	if (Options.gameplayShaders) artistText.shader = bloom;
	add(artistText);
    
	levelBarBG = new FlxSprite(threat.x + 630, threat.y + 510).loadGraphic(Paths.image('menus/fpmenu/threatBarBG'));
	levelBarBG.antialiasing = true;
	add(levelBarBG);

	levelBar = new FlxBar(levelBarBG.x + 4, levelBarBG.y + 4, FlxBar.LEFT_TO_RIGHT, Std.int(levelBarBG.width - 8), Std.int(levelBarBG.height - 8), this,
		'threatLerp', 0, 100);
	levelBar.scrollFactor.set();
	levelBar.createFilledBar(0x00000000, FlxColor.WHITE);
    levelBar.unbounded = true;
	levelBar.antialiasing = true;
	add(levelBar);
    
	gradient = new FlxSprite(0, 0, Paths.image('gradient'));
	gradient.screenCenter();
	gradient.setGraphicSize(Std.int(gradient.width * 0.75));
	gradient.alpha = 0;
	gradient.antialiasing = true;
	add(gradient);

	FlxTween.tween(gradient, {alpha: 1}, 1, {ease: FlxEase.sineInOut, type: FlxTween.PINGPONG});

    dogeTxt = new FlxText(0, FlxG.height - 50, 0, "♪ Now Playing: Freeplay Theme - By Doge ♪", 8);
    dogeTxt.setFormat(Paths.font("menuFont.ttf"), 24, FlxColor.WHITE, "left");
    dogeTxt.alpha = 0;
    dogeTxt.antialiasing = true;
    add(dogeTxt);

    FlxTween.tween(dogeTxt, {alpha: 1}, 1.5, {
        ease: FlxEase.quadInOut, 
        startDelay: 2,
        onComplete: 
        function (twn:FlxTween)
            {
                FlxTween.tween(dogeTxt, {alpha: 0}, 1.5, {
                    ease: FlxEase.quadInOut, startDelay: 2});
            }
    });

    noHeroIntro = new FlxSprite(-200, -400);
    noHeroIntro.frames = Paths.getSparrowAtlas('noherocutscenefirst');
    noHeroIntro.animation.addByPrefix('finnJumpscareMomento', 'play003', 24, true);
    noHeroIntro.animation.play('finnJumpscareMomento',true);
    noHeroIntro.scrollFactor.set();

    add(noHeroIntro);
    saveHeroY = noHeroIntro.y;
    noHeroIntro.alpha = 0.001;

    Conductor.bpm = 100;
    
    artistText.alpha = 0;

    songText.revive();
    songText.resetText(songList[curSelected].displayName.toUpperCase());
    songText.start(0.1, true);
    songText.alpha = 1;
    songText.completeCallback = function() {
        artistText.alpha = 1;
        artistText.resetText(getSongArtist(songList[curSelected].displayName).toUpperCase());
        artistText.start(0.05, true);
    };
    
}
function update(elapsed){
    if (FlxG.sound.music.volume < 0.7)
		FlxG.sound.music.volume += 0.5 * elapsed;
    
    if (FlxG.sound.music != null)
        Conductor.songPosition = FlxG.sound.music.time;

    if (Options.gameplayShaders){
        glitchTime += elapsed;
        pibbyShader.uTime = glitchTime;
        pibbyShader.glitchMultiply = glitchTime;
        if (FlxG.random.int(0, 1) < 0.01) {
            glitchTime = FlxG.random.float(0.2, 0.3);
        }
    }


    var upP = controls.UP_P;
    var leftP = controls.LEFT_P;
    var rightP = controls.RIGHT_P;
    var accept = controls.ACCEPT;

    if (controls.BACK){
        FlxG.switchState(new MainMenuState());
        FlxG.sound.playMusic(Paths.music('freakyMenu_' + funnyMenuMusic));
    }

	if (accept){
        goToSong();
    }

    if (songList.length > 1)
    {
        if (leftP)
        {
            FlxTween.tween(arrowL, {alpha: 0.4}, 0.1, {
                ease: FlxEase.quadInOut,
                onComplete: 
                function (twn:FlxTween)
                    {
                        FlxTween.tween(arrowL, {alpha: 1}, 0.1, {
                            ease: FlxEase.quadInOut,
                            onComplete: 
                            function (twn:FlxTween)
                                {
                                    arrowL.alpha = 1;
                                }});
                    }});
                    changeSong(-1);
        }
        if (rightP)
        {
            FlxTween.tween(arrowR, {alpha: 0.4}, 0.1, {
                ease: FlxEase.quadInOut,
                onComplete: 
                function (twn:FlxTween)
                    {
                        FlxTween.tween(arrowR, {alpha: 1}, 0.1, {
                            ease: FlxEase.quadInOut,
                            onComplete: 
                            function (twn:FlxTween)
                                {
                                    arrowR.alpha = 1;
                                }});
                    }});
                    changeSong(1);
        }
    }

    if (upP) {
        pressed += 1;
        var funnyNum:Int = 20;
        noHeroIntro.alpha += pressed/40;
        FlxG.camera.y += funnyNum;
        noHeroIntro.y -= funnyNum;
        var fuckNum:Int;
        /*allowGlitch = true;
        new FlxTimer().start(0.35, function(tmr:FlxTimer) {
            allowGlitch = false;
        });*/
        var gameObjects = [bg, arrowL, arrowR, image, stagebox, stagebox_L, stagebox_R, threat, levelBarBG, gradient];
        for(index in 0...gameObjects.length){
            fuckNum = Std.int(100*pressed);
            if (gameObjects[index] != null && gameObjects[index].exists) {
                gameObjects[index].offset.x = 0 + FlxG.random.int(-fuckNum, fuckNum);
                gameObjects[index].offset.y = 0 + FlxG.random.int(-fuckNum, fuckNum);
            }else{
                continue;
            }
        }
        FlxG.sound.music.volume -= pressed/10;
        FlxG.sound.play(Paths.sound('glitchhit'),10*pressed);
        if (!isResetTimerRunning) {
            resetSecretTimer = new FlxTimer().start(3, function(tmr:FlxTimer) {
                pressed = 0;
                FlxTween.tween(noHeroIntro, {alpha: 0.001}, 0.25, {ease: FlxEase.quadInOut});
                FlxG.camera.y = saveY;
                noHeroIntro.y = saveHeroY;
                var gameObjects = [bg, arrowL, arrowR, image, stagebox, stagebox_L, stagebox_R, threat, levelBarBG, gradient];
                for(index in 0...gameObjects.length){
                    if (gameObjects[index] != null && gameObjects[index].exists) {
                        gameObjects[index].offset.x = 0;
                        gameObjects[index].offset.y = 0;
                    }else{
                        continue;
                    }
                }
                FlxG.sound.music.volume = 1;
                isResetTimerRunning = false;
            });
        }
        isResetTimerRunning = true;
        if (pressed == 8) {
            PlayState.loadSong("No-Hero-Remix", "normal");
            FlxG.switchState(new PlayState());
        }
    }

    threatLerp = lerp(threatLerp, getSongLevel(songList[curSelected]), 0.05);
    

    bg.animation.play('idle');

    Conductor.bpm = 100; // in case the code sucks and stays with the bpm

    // todo: fix this
    stagebox.y = 3 + Math.sin(Conductor.songPosition/600)*((FlxG.height * 0.015));
    image.y = 3 + Math.sin(Conductor.songPosition/600)*((FlxG.height * 0.015));
    if (arrowL != null) arrowL.y = 290 + Math.sin(Conductor.songPosition/600)*((FlxG.height * 0.065));
    if (arrowR != null) arrowR.y = 290 + Math.sin(Conductor.songPosition/600)*((FlxG.height * 0.065));
}

function changeSong(change:Int) {
    curSelected += change;

    if (curSelected < 0)
        curSelected = songList.length - 1;
    if (curSelected >= songList.length)
        curSelected = 0;

    artistText.alpha = 0;

    songText.revive();
    songText.resetText(songList[curSelected].displayName.toUpperCase());
    songText.start(0.1, true);
    songText.alpha = 1;
    songText.completeCallback = function() {
        artistText.alpha = 1;
        artistText.resetText(getSongArtist(songList[curSelected].displayName).toUpperCase());
        artistText.start(0.05, true);
    };

    image.loadGraphic(Paths.image('menus/fpmenu/stage/' + songList[curSelected].displayName));
    
    levelBar.updateBar();
}
function goToSong(){
    PlayState.loadSong(songList[curSelected].name, "normal");
    FlxG.switchState(new PlayState());
    FlxG.sound.music.volume = 0;
}
function getSongLevel(song:String){// kinda not worked.. (same goes to the meta data)
    threatPercent = 100;

    switch (song){
        case "Wretched Gems":
            threatPercent = 80;

        case "Mindless":
            threatPercent = 85;

        case "Blessed by Swords":
            threatPercent = 90;
    
        case "Brotherly Love":
            threatPercent = 80;

        case "Suffering Siblings":
            threatPercent = 95;

        case "Come Along With Me":
            threatPercent = 75;

        case "Child's Play":
            threatPercent = 20;

        case "My Amazing World":
            threatPercent = 45;

        case "Retcon":
            threatPercent = 55;

        case "Forgotten World":
            threatPercent = 65;

        case "No Hero Remix":
            threatPercent = 83;
    }
}
function getSongArtist(song:String){
    var artist:String = 'Kawai Sprite';

    switch (song){
        case "Wretched Gems":
            artist = 'Spades (ft. Stormy & Myakish)';

        case "Mindless":
            artist = 'Sevc_Ext_277';

        case "Blessed by Swords":
            artist = 'Lettush';
    
        case "Brotherly Love":
            artist = 'Kylevi';

        case "Suffering Siblings":
            artist = 'Awe (ft. Saster & Shxdow)';

        case "Come Along With Me":
            artist = 'Awe';

        case "Child's Play":
            artist = 'Yoosuf Meekail';

        case "My Amazing World":
            artist = 'Corn';

        case "Retcon":
            artist = 'Rareblin (ft. Pattydecaffy)';

        case "Forgotten World":
            artist = 'Awe';

        case "No Hero Remix":
            artist = 'Rundown';
    }
}