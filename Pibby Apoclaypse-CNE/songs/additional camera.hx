import flixel.FlxCamera;
import funkin.game.HudCamera;

static var camHUD2:FlxCamera;// extra cams for some reasons

static var camCinema:HudCamera;// extra cams2 for some reasons

function create(){
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(camCinema = new HudCamera(), false);
    camCinema.bgColor = FlxColor.TRANSPARENT;
    FlxG.cameras.add(camHUD, false);

    FlxG.cameras.add(camHUD2 = new FlxCamera(), false);
    camHUD2.bgColor = FlxColor.TRANSPARENT;
}
function postUpdate(){
    camHUD2.scroll = camHUD.scroll;
    camCinema.scroll = camHUD.scroll;
    camCinema.zoom = camHUD.zoom;
}