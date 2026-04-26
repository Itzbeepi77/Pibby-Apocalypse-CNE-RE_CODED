























import Type;
import haxe.Timer;
import funkin.backend.utils.WindowUtils;
import openfl.Lib;
import lime.graphics.Image;
import funkin.backend.system.framerate.Framerate;
import funkin.backend.system.framerate.FramerateCounter;

import openfl.display.FPS;
import openfl.text.TextField;
import openfl.text.TextFormat;

import funkin.backend.utils.MemoryUtil;

import funkin.backend.system.Main;

import hxvlc.util.Handle;
import hxvlc.flixel.FlxVideoSprite;

var redirectStates:Map<FlxState, String> = [
    FreeplayState => "FreeplayMenu",
    MainMenuState => "PibbyMainMenu"
];

public static var funnyMenuMusic:String = "";// for uhh mainmenu and title music

public static var isGFPlay:Bool = false;// for game over anim
public static var isJakePlay:Bool = false;// for game over anim

public static var lastSongSelect:Int = 0;// broken, it makes your game crashed

var cursorShit:FunkinSprite;

var fakeFPS:FPS;// steal :P
var realFPS:FPS;

var memoryPeak:Float = 0;
var lastDebugMode:Int = 1;

//var fpsUpdateTimer:Float = 999999;

function new() {
    Handle.init([]);

    funnyMenuMusic = FlxG.random.bool(5) ? "2" : "1";// it will do it once you start the mod

	FlxG.mouse.useSystemCursor = false;
	FlxG.mouse.visible = true;
    
    FlxG.save.data.healthShit ??= true;
    FlxG.save.data.doubleShit ??= true;
    FlxG.save.data.glitchShit ??= true;
    FlxG.save.data.shaderShit ??= true;

    FlxG.save.data.glitchIcon ??= true;

    // Idfc if this is too long just stfu
    FlxG.save.data.funnyGoofyAhhPibbyCorruptedAngleCameraMovingMFSTFUKYSIDCLikeRealyGoofyAhhShitMFTurnOnThisOptionToHaveASurprise ??= false;
    
    FlxG.save.data.goreShit ??= false;
    
    FlxG.save.data.shadertext ??= "null";

	cursorShit = new FunkinSprite().loadGraphic(Paths.image("cursor/mouse (1)"));

	FlxG.mouse.load(cursorShit.pixels);
}

function update(elapsed){

	cursorShit = new FunkinSprite().loadGraphic(Paths.image("cursor/mouse (" + FlxG.random.int(1, 10) + ")"));

	FlxG.mouse.load(cursorShit.pixels);
}

function preStateSwitch() {
    WindowUtils.resetTitle();
	window.title = "Pibby: Apocalypse";
    window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('icon'))));
    for (redirectState in redirectStates.keys())
        if (FlxG.game._requestedState is redirectState)
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}