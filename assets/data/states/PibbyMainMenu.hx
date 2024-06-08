// this is it..
import flixel.text.FlxTextBorderStyle;
import flixel.effects.FlxFlicker;
import funkin.editors.EditorPicker;
import funkin.options.OptionsMenu;
import funkin.menus.credits.CreditsMain;
import funkin.menus.ModSwitchMenu;

var vcr = new CustomShader("oldTVShader");

var curSelected:Int = 0;

var cinematicdown:FlxSprite;
var cinematicup:FlxSprite;

var texts:Array<Dynamic> = [];
var optionShit:Array<String> = ['FREEPLAY', 'CREDITS'];
var textGroups:FlxTypedGroup;
var text:FunkinText;

var options:FlxSprite;
var discord:FlxSprite;

var aweTxt:FlxText;
var verTxt:FlxText;

var barTab:FlxSprite;

public var canAccessDebugMenus:Bool = true;

function create(){
    window.title = "Pibby: Apocalypse - Main Menu";
    
	FlxG.mouse.visible = true;
    
	var bg:FlxSprite = new FlxSprite(0, -10).loadGraphic(Paths.image('menus/pibymenu/BACKGROUND'));
	bg.scrollFactor.set(0, 0);
	bg.setGraphicSize(Std.int(bg.width * 0.8));
	bg.updateHitbox();
	bg.screenCenter(FlxAxes.X);
	bg.antialiasing = true;
	if (Options.gameplayShaders)
		bg.shader = vcr;
	add(bg);

    cinematicdown = new FlxSprite().makeSolid(FlxG.width, 70, FlxColor.BLACK);
    cinematicdown.scrollFactor.set();
    cinematicdown.setPosition(0, FlxG.height - 70);
    cinematicdown.antialiasing = true;
    add(cinematicdown);

    cinematicup = new FlxSprite().makeSolid(FlxG.width, 100, FlxColor.BLACK);
    cinematicup.scrollFactor.set();
    cinematicup.antialiasing = true;
    add(cinematicup);

    options = new FlxSprite().loadGraphic(Paths.image('menus/pibymenu/Options'));
    options.alpha = 0.4;
    options.scale.set(0.3, 0.3);
    options.updateHitbox();
    options.setPosition(FlxG.width - 97, FlxG.height - 63);
    options.antialiasing = true;
    add(options);

    discord = new FlxSprite().loadGraphic(Paths.image('menus/pibymenu/discord'));
    discord.alpha = 0.4;
    discord.scale.set(0.3, 0.3);
    discord.updateHitbox();
    discord.setPosition(options.x - 85, FlxG.height - 60);
    discord.antialiasing = true;
    add(discord);

    aweTxt = new FlxText(0, FlxG.height - 35, 0,
        'Now Playing: Menu Theme' + (funnyMenuMusic == "2" ? '(Alt)' : '') + ' - By ' + (funnyMenuMusic == "2" ? 'Sodukoru' : 'GoddessAwe') + '♪', 8);
    aweTxt.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, "left");
    aweTxt.alpha = 1;
    aweTxt.antialiasing = true;
    add(aweTxt);
    verTxt = new FlxText(0, FlxG.height - 65, 0, 'PIBBY: APOCALYPSE DEMO {CNE PORT} - V0.7.15 [RE-CODED]', 8);
    verTxt.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, "left");
    verTxt.alpha = 1;
    verTxt.antialiasing = true;
    add(verTxt);

    textGroups = new FlxTypedGroup();
	add(textGroups);

    for(i2 in 0...optionShit.length) {// stolen from Cyber Sensation code :))
        var i = optionShit.length - i2 - 1;

        text = new FunkinText(FlxG.width - 240 - (i2 * 720), 25, 0, upper(optionShit[i]), 48);
        text.font = Paths.font('vcr.ttf');
        text.borderStyle = FlxTextBorderStyle.NONE;
        text.alpha = 0.4;
        optionShit.ID = i;
        var scr:Float = (optionShit.length - 4) * 0.135;
        if (optionShit.length < 6)
            scr = 0;
        text.scrollFactor.set(0, scr);
        text.antialiasing = true;
        text.updateHitbox();
        text.x -= 125;

        trace(text);
        add(text);

        var bar = new FlxSprite(text.x, text.y + text.height + 4).makeSolid(1, 1, FlxColor.WHITE);
        bar.scale.set(text.width, 6);
        bar.updateHitbox();
        bar.scrollFactor.set();
        add(bar);

        texts.insert(0, {
            bar: bar,
            text: text,
            t: 0
        });
    }

}
function upper(str:String) {
    var c = str.split(" ");
    for(i in 0...c.length)
        c[i] = c[i].substr(0, 1).toUpperCase() + c[i].substr(1);
    return c.join(" ");
}

var tvTime:Float = 0;
function update(elapsed){
    if (Options.gameplayShaders){
        tvTime += elapsed;
        vcr.iTime = tvTime;
    }
    if (controls.BACK){
		FlxG.switchState(new TitleState());
    }
    if (controls.ACCEPT)
        {
            selectItem();
        }

    if (controls.RIGHT_P)
        changeItem(-1);
    if (controls.LEFT_P)
        changeItem(1);

    if (FlxG.mouse.overlaps(options)){
        options.alpha = lerp(options.alpha, 1, 0.05);
    } else {
        options.alpha = lerp(options.alpha, 0.4, 0.05);
    }
    
    if (FlxG.mouse.overlaps(discord)){
        discord.alpha = lerp(discord.alpha, 1, 0.05);
    } else {
        discord.alpha = lerp(discord.alpha, 0.4, 0.05);
    }
    
    if (FlxG.mouse.overlaps(options) && FlxG.mouse.justPressed){
        FlxG.switchState(new OptionsMenu());
    }
    if (FlxG.mouse.overlaps(discord) && FlxG.mouse.justPressed){
        CoolUtil.openURL("https://discord.gg/pibbyapocalypse");
    }

    for(i in 0...texts.length) {
        var t = texts[i];
        t.text.alpha = lerp(t.text.alpha, (curSelected == i ? 1 : 0.4), 0.08);
        t.bar.alpha = lerp(t.bar.alpha, (curSelected == i ? 1 : 0), 0.08);
        t.bar.scale.x = lerp(t.bar.scale.x, (curSelected == i ? t.text.width : 0), 0.25);
    }
}

function changeItem(change:Int = 0){
    curSelected += change;
        
    if (curSelected < 0)
        curSelected = optionShit.length - 1;
    if (curSelected >= optionShit.length)
        curSelected = 0;
}

function selectItem(){
    selectedSomethin = true;
    for(i in 0...texts.length) {
        var t = texts[i];
        t.text.alpha = lerp(t.text.alpha, (curSelected == i ? 1 : 0), 0.08);
        t.bar.alpha = lerp(t.bar.alpha, (curSelected == i ? 1 : 0), 0.08);
        t.bar.scale.x = lerp(t.bar.scale.x, (curSelected == i ? 0 : 0), 0.25);

        FlxFlicker.flicker(t.text, 1, 0.06, (curSelected == i ? false : true),  false, function(flick:FlxFlicker)
            {
                var daChoice:String = optionShit[curSelected];

                switch (daChoice)
                {
                    case 'FREEPLAY':
                        FlxG.switchState(new FreeplayState());
                        trace("FreePlay Menu Selected");
                    case 'CREDITS':
                        FlxG.switchState(new ModState("CreditsPibbyMenu"));
                        trace("Credits Menu Selected");
                }
            });
    }
}