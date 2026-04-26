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

/*var redirectStates:Map<FlxState, String> = [
    TitleState => 'PibbyMenu'
];*/

var fakeFPS:FPS;// steal :P
var realFPS:FPS;

var memoryPeak:Float = 0;
var lastDebugMode:Int = 1;

//var fpsUpdateTimer:Float = 999999;

function new() {
    Handle.init([]);

    // taken from swords v-slice script
    fakeFPS = new FPS(-999999, -999999, 0xFFFFFFFF);
    fakeFPS.visible = false;
    Main.instance.addChild(fakeFPS);

    realFPS = new TextField();
    realFPS.x = 10;
    realFPS.y = 3;
    realFPS.text = "FPS: 0\n \nRAM: 0mb / 0mb peak";
    realFPS.autoSize = 1; // 1 = left
    realFPS.alpha = 0.5;

    var format:TextFormat = new TextFormat(Paths.font("vcr.ttf"), 12, 0xFFFFFFFF);
    format.leading = -4;

    realFPS.defaultTextFormat = format;
    realFPS.addEventListener("enterFrame", onEnterFrame);
    Main.instance.addChild(realFPS);
    
    lastDebugMode = Framerate.debugMode;
    coolDebugMode = lastDebugMode;
    
    Framerate.fpsCounter.visible = false;
    Framerate.memoryCounter.visible = false;
    Framerate.codenameBuildField.visible = false;
        
    Framerate.instance.visible = false;
}


// taken from swords v-slice script
function onEnterFrame(e) {
    var lastTime:Float = Timer.stamp();
    //fpsUpdateTimer += FlxG.elapsed * 1000;

    var memory:Float = MemoryUtil.currentMemUsage();
    if(memory > memoryPeak)
        memoryPeak = memory;

    var text:String = "FPS: " + fakeFPS.currentFPS;
    if(Framerate.debugMode >= 1)
        text += "\n\nRAM: " + CoolUtil.getSizeString(memory).toLowerCase() + " / " + CoolUtil.getSizeString(memoryPeak).toLowerCase() + " peak ";

    text += "\n\nPIBBY: APOCALYPSE [CNE PORT BUILD]";
    realFPS.text = text;
}

function destroy(){
    Framerate.codenameBuildField.visible = true;
    Framerate.fpsCounter.visible = true;
    Framerate.memoryCounter.visible = true;

    Main.instance.removeChild(fakeFPS);

    //realFPS.removeEventListener("enterFrame", onEnterFrame);
    Main.instance.removeChild(realFPS);

    Framerate.debugMode = lastDebugMode;
    Framerate.instance.visible = true;
}

function preStateSwitch() {
    Framerate.fpsCounter.visible = false;
    Framerate.memoryCounter.visible = false;
    Framerate.codenameBuildField.visible = false;
        
    Framerate.instance.visible = false;
    
    /*for (redirectState in redirectStates.keys())
        if (FlxG.game._requestedState is redirectState)
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));*/
}

function preStateCreate(st){
    if (st == "TitleState"){
        trace("Hello fuckers");
    }
}