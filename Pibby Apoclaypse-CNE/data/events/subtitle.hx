import flixel.text.FlxTextBorderStyle;

var sub:FlxText;
function create() {
    for (event in events){
        if (event.name == "subtitle"){
            sub = new FlxText(0, 152, 400, "", 50);
            sub.setFormat(hudTxt.font, 50, 0xFFFFFFF, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            sub.scrollFactor.set();
            sub.borderColor = 0xFF000000;
            sub.borderSize = 2;
            sub.screenCenter(FlxAxes.X);
            add(sub);
            sub.cameras = [camHUD];
        }
    }
}

function onEvent(e) {
    if (e.event.name == "subtitle"){
        sub.scale.x = 1.2;
        sub.scale.y = 1.2;
        sub.color = e.event.params[0];
        sub.font = hudTxt.font;
        sub.borderColor = 0xFF000000;
        sub.text = e.event.params[1];
        FlxTween.tween(sub.scale, {x: 1, y: 1}, 0.2, {
            ease: FlxEase.circOut
        });
        FlxTween.num(1, 0.0001, 5, {ease: FlxEase.circOut, startDelay: 0.3}, function(v:Float) {
            sub.alpha  = v;
        });
    }
}