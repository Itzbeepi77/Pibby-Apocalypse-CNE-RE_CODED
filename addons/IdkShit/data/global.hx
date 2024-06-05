import funkin.backend.utils.WindowUtils;
import openfl.Lib;
import lime.graphics.Image;
import funkin.backend.system.framerate.Framerate;
import funkin.backend.system.framerate.FramerateCounter;

import hxvlc.util.Handle;

static var redirectStates:Map<FlxState, String> = [
    FreeplayState => "FreeplayMenu",
    MainMenuState => "PibbyMainMenu"
];

public static var funnyMenuMusic:String = "";// for uhh mainmenu and title music

public static var isGFPlay:Bool = false;// for game over anim
public static var isJakePlay:Bool = false;// for game over anim

var cursorShit:FunkinSprite;

function new() {
    Handle.init([]);

    funnyMenuMusic = FlxG.random.bool(5) ? "2" : "1";// it will do it once you start the mod
    
    if (FlxG.save.data.healthShit == null) FlxG.save.data.healthShit = true;
    if (FlxG.save.data.doubleShit == null) FlxG.save.data.doubleShit = true;
    if (FlxG.save.data.glitchShit == null) FlxG.save.data.glitchShit = true;
    if (FlxG.save.data.shaderShit == null) FlxG.save.data.shaderShit = true;

    if (FlxG.save.data.glitchIcon == null) FlxG.save.data.glitchIcon = true;

    // Idfc if this is too long just stfu
    if (FlxG.save.data.funnyGoofyAhhPibbyCorruptedAngleCameraMovingMFSTFUKYSIDCLikeRealyGoofyAhhShitMFTurnOnThisOptionToHaveASurprise == null)
        FlxG.save.data.funnyGoofyAhhPibbyCorruptedAngleCameraMovingMFSTFUKYSIDCLikeRealyGoofyAhhShitMFTurnOnThisOptionToHaveASurprise = false;
}

function update(elapsed){
	if (FlxG.keys.justPressed.F5) FlxG.resetState();

	cursorShit = new FunkinSprite().loadGraphic(Paths.image("cursor/mouse (" + FlxG.random.int(1, 10) + ")"));

	FlxG.mouse.load(cursorShit.pixels);
}

function destroy() Framerate.codenameBuildField.visible = true;

function preStateSwitch() {
    WindowUtils.resetTitle();
	window.title = "Pibby: Apocalypse";
    window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('icon'))));
    for (redirectState in redirectStates.keys())
        if (FlxG.game._requestedState is redirectState)
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
    

    Framerate.fpsCounter.visible = true;
    Framerate.memoryCounter.visible = true;
    Framerate.codenameBuildField.visible = false;

	FlxG.mouse.useSystemCursor = false;
	FlxG.mouse.visible = true;
    
	cursorShit = new FunkinSprite().loadGraphic(Paths.image("cursor/mouse (1)"));

	FlxG.mouse.load(cursorShit.pixels);
}