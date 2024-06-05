import openfl.geom.ColorTransform;

var bAbg = new FunkinSprite();
function postCreate(){
	for (event in events) {
		if (event.name == 'AppleFilter') {
            bAbg.makeSolid(FlxG.width+10, FlxG.height+12, event.params[2]);// had to make it like this if not it will be blacking your screen
            bAbg.zoomFactor = 0;
            bAbg.scrollFactor.set();
            bAbg.screenCenter();
            bAbg.alpha = 0.0001;
            if (gf != null){
                insert(members.indexOf(gf), bAbg);
            } else {
                insert(members.indexOf(dad), bAbg);
            }
        }
    }
}
function onEvent(e) {
    if (e.event.name == "AppleFilter"){
        if (e.event.params[0] == true || e.event.params[0] == null){
            //FlxTween.tween(bAbg, {alpha: 1}, e.event.params[1], {ease: FlxEase.quadInOut});
            bAbg.alpha = 1;
            bAbg.colorTransform.color = e.event.params[2];

            for (bfs in strumLines.members[1].characters) bfs.colorTransform.color = e.event.params[1];
            for (dads in strumLines.members[0].characters) dads.colorTransform.color = e.event.params[1];
            if (gf != null){
                for (gfs in strumLines.members[2].characters) gfs.colorTransform.color = e.event.params[1];
            }
        } else {
            bAbg.alpha = 0.0001;
            for (bfs in strumLines.members[1].characters) bfs.setColorTransform();
            for (dads in strumLines.members[0].characters) dads.setColorTransform();
            if (gf != null){
                for (gfs in strumLines.members[2].characters) gfs.setColorTransform();
            }
            if (Options.gameplayShaders) bloom.size = 0.0;
        }
    }
}