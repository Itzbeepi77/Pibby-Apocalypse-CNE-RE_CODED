import flixel.text.FlxTextBorderStyle;
import openfl.text.TextField;
import openfl.text.TextFormat;
import flixel.FlxG;
import flixel.FlxSprite;

var pibbyShader:CustomShader = new CustomShader('glitchThingy');

var curSelected:Int = 0;

var glitchTime:Float = 0;

var people:Array<Dynamic> = []; // push people to this depending on the role

var bg:FlxSprite;
var creditSpr:FlxSprite;
var twitter:FlxSprite;
var youtube:FlxSprite;
var creditsText:FlxText;
var currentGroup:FlxText;

var quoteText:FlxText;

var creditData:Array = Json.parse(Assets.getText(Paths.json('config/credits')));

function create(){
    if (Options.gameplayShaders){
        FlxG.camera.addShader(pibbyShader);
    
        pibbyShader.iMouseX = 500;
        pibbyShader.NUM_SAMPLES = 3;
    }

    window.title = "Pibby: Apocalypse - Credits";
    
	FlxG.mouse.visible = true;

    FlxG.sound.playMusic(Paths.music("creditsmenu"));

    people = creditData.people;

    bg = new FlxSprite();
    bg.frames = Paths.getSparrowAtlas('menus/fpmenu/background');
    bg.animation.addByPrefix('idle', 'background idle', 30, true);
    bg.animation.play('idle');
    bg.antialiasing = true;
    add(bg);
    bg.screenCenter();

    creditsText = new FlxText(20, 20, 0, '< BACK', 30);
    creditsText.setFormat(Paths.font("menuFont.ttf"), 54, FlxColor.WHITE, "left");
    add(creditsText);

    currentGroup = new FlxText(0, 0, 0, "", 70);
    currentGroup.setFormat(Paths.font("menuFont.ttf"), 70, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    currentGroup.borderSize = 1.5;
    currentGroup.screenCenter();
    add(currentGroup);

    quoteText = new FlxText(20, 0, 0, "", 20);
    quoteText.setFormat(Paths.font("menuFont.ttf"), 20, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    quoteText.borderSize = 1.5;
    quoteText.screenCenter();
    add(quoteText);

    currentGroup.x -= 600;
    quoteText.x -= 600;

    currentGroup.y -= 35;
    quoteText.y += 35;

    creditSpr = new FlxSprite(0, 0);
    creditSpr.scale.set(0.4, 0.4);
    creditSpr.updateHitbox();
    creditSpr.screenCenter();
    creditSpr.x -= 40;
    creditSpr.y -= 800;
    creditSpr.alpha = 0.6;
    add(creditSpr);

    youtube = new FlxSprite(150, FlxG.height - 130);
    youtube.loadGraphic(Paths.image("menus/pacredits/youtube"));
    youtube.alpha = 0.6;
    
    twitter = new FlxSprite(youtube.x - youtube.width, youtube.y);
    twitter.loadGraphic(Paths.image("menus/pacredits/twitter"));
    twitter.alpha = 0.6;

    twitter.scale.x = 0.3;
    twitter.scale.y = 0.3;

    youtube.scale.x = 0.08;
    youtube.scale.y = 0.08;

    twitter.updateHitbox();
    youtube.updateHitbox();

    youtube.setPosition(150, FlxG.height - 130);
    twitter.setPosition(youtube.x - youtube.width, youtube.y);
    add(twitter);
    add(youtube);

    /*for (person in people)
        {
            Paths.returnGraphic('menus/pacreditarts/' + person[1] + 1, null, true);
            Paths.returnGraphic('menus/pacreditarts/' + person[1] + 2, null, true);
        }*/

	if (people != null) {
		quoteText.text = people[curSelected][0] + ' - ' + people[curSelected][2] + '\n"' + people[curSelected][5] + '"';
	}

	currentGroup.text = people[curSelected][6];
    creditSpr.loadGraphic(Paths.image("menus/pacreditarts/" + people[curSelected][1] + FlxG.random.int(1, 2)));

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
    
    var leftP = controls.LEFT_P;
    var rightP = controls.RIGHT_P;

    if (controls.BACK){
        FlxG.switchState(new MainMenuState());
        FlxG.sound.playMusic(Paths.music('freakyMenu_' + funnyMenuMusic));
    }

    if (leftP){
        changeSelection(-1);
    }
    if (rightP){
        changeSelection(1);
    }

    if (FlxG.mouse.overlaps(creditSpr)){
        creditSpr.alpha = lerp(creditSpr.alpha, 1, 0.25);
    } else {
        creditSpr.alpha = lerp(creditSpr.alpha, 0.6, 0.25);
    }

    if (FlxG.mouse.overlaps(youtube)){
        youtube.alpha = lerp(youtube.alpha, 1, 0.25);
    } else {
        youtube.alpha = lerp(youtube.alpha, 0.6, 0.25);
    }
    
    if (FlxG.mouse.overlaps(twitter)){
        twitter.alpha = lerp(twitter.alpha, 1, 0.25);
    } else {
        twitter.alpha = lerp(twitter.alpha, 0.6, 0.25);
    }
    
    if (FlxG.mouse.overlaps(youtube) && FlxG.mouse.justPressed){
        CoolUtil.openURL("https://" + people[curSelected][3]);
    }
    if (FlxG.mouse.overlaps(twitter) && FlxG.mouse.justPressed){
        CoolUtil.openURL("https://" + people[curSelected][4]);
    }
    
    creditSpr.scale.x = FlxMath.lerp(creditSpr.scale.x, 0.4, FlxMath.bound(elapsed * 3.8, 0, 1));
    creditSpr.scale.y = FlxMath.lerp(creditSpr.scale.y, 0.4, FlxMath.bound(elapsed * 3.8, 0, 1));

}

function changeSelection(thing:Int) {
    curSelected += thing;

    if (curSelected < 0)
        curSelected = people.length - 1;
    if (curSelected >= people.length)
        curSelected = 0;

    if (people != null) {
        quoteText.text = people[curSelected][0] + ' - ' + people[curSelected][2] + '\n"' + people[curSelected][5] + '"';
    }

    currentGroup.text = people[curSelected][6];

    creditSpr.loadGraphic(Paths.image("menus/pacreditarts/" + people[curSelected][1] + FlxG.random.int(1, 2)));
}
