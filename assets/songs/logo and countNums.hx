import funkin.backend.FunkinSprite;
import Date;

var timDate = Date.now();
function postCreate(){
    trace(timDate);

    CNlogo = new FunkinSprite();
    if (timDate.getHours() >= 17 && timDate.getHours() <= 24){
        CNlogo.x = 450;
        CNlogo.y = 360;
        CNlogo.loadGraphic(Paths.image("aslogo"));
        CNlogo.setGraphicSize(Std.int(CNlogo.width * 0.09));
    } else if (timDate.getHours() >= 1 && timDate.getHours() <= 6){
        CNlogo.x = 450;
        CNlogo.y = 360;
        CNlogo.loadGraphic(Paths.image("aslogo"));
        CNlogo.setGraphicSize(Std.int(CNlogo.width * 0.09));
    } else if (timDate.getHours() >= 6 && timDate.getHours() <= 17){
        CNlogo.loadGraphic(Paths.image("cnlogo"));
        CNlogo.setGraphicSize(Std.int(CNlogo.width * 0.17));
        CNlogo.x = 675;
        CNlogo.y = 240;
    }
    CNlogo.scrollFactor.set();
    CNlogo.alpha = 0.5;
    add(CNlogo);
        
    CNlogo.cameras = [camHUD2];
    CNlogo.zoomFactor = 0;
    
    countNum = new FlxSprite(350, 200);// countdown numbers thingys
    countNum.frames = Paths.getSparrowAtlas('Numbers');
    countNum.animation.addByPrefix('1', '1', 24, false);
    countNum.animation.addByPrefix('2', '2', 24, false);
    countNum.animation.addByPrefix('3', '3', 24, false);
    countNum.animation.addByPrefix('Go', 'Go', 24, false);
    countNum.updateHitbox();
    countNum.alpha = 0.001;
    countNum.cameras = [camHUD2];
    countNum.antialiasing = true;
	insert(members.indexOf(boyfriend)+1, countNum);
    
    if (downscroll){
        CNlogo.y -= 360;
    } else {
        CNlogo.y = 360;
    }
}