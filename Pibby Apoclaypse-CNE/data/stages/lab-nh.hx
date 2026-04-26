import openfl.geom.ColorTransform;

function postCreate(){

    remove(nhcutscene);
    nhcutscene.cameras = [camHUD];
    nhcutscene.scrollFactor.set();
    nhcutscene.active = false;
    insert(members.indexOf(iconP1)+2, nhcutscene);

    hudTxt.visible = false;
}
function onEvent(e){
    if (e.event.name == "AppleFilter"){
        if (e.event.params[0] == true){
            iconP2.color = 0x0000000;
        } else {
            iconP2.color = 0xFFFFFFF;
        }
    }
}
function onSongStart(){
    nhcutscene.active = true;
}

function onPlayerHit(note) iconP1.scale.set(1.1, 1.1);
function onDadHit(note) iconP2.scale.set(1.1, 1.1);
function stepHit(){
    if (curSong == "no-hero-remix"){
        if (curStep == 32){
            nhcutscene.alpha = 0.0001;
        }
        if (curStep == 464){
            bg.alpha = 0.0001;
            bgNh.alpha = 1;
        }
        if (curStep == 592){
            bg.alpha = 1;
            bgNh.alpha = 0.0001;
        }
    }
}