import flixel.effects.FlxFlicker;

public var startMF:Bool = false;

function onCountdown(event) {
    event.cancel();
}

static var startOnTime:Float = 0;

function onPostStartCountdown(){

	Conductor.songPosition = 0;
    Conductor.songPosition = (-0.67 * 5) * 1000;

    if(startOnTime < 0) startOnTime = 0;

        if (startOnTime > 0) {
            setSongTime(startOnTime - 350);
            return;
    }
}

function postCreate() {
    countShit();

    canPause = true;

    switch(curSong){
        case 'suffering-siblings', 'brotherly-love', 'blessed-by-swords', 'what-am-i', 'retcon', 'childs-play':
            curCameraTarget = 1;

        default:
            return;
    }
}
function onSongStart(){
    trace("Countdown Shits");

    if (curSong != 'suffering-siblings')
        curCameraTarget = 0;
    

    if(curSong == "my-amazing-world") camHUD.alpha = 1;

	if(startOnTime > 0)
	{
		setSongTime(startOnTime - 500);
	}
	startOnTime = 0;
}

function countShit(){
    switch(curSong){
        case 'suffering-siblings', 'brotherly-love', 'blessed-by-swords', 'what-am-i':
            new FlxTimer().start(0.5, function(tmr:FlxTimer){
                FlxG.sound.play(Paths.sound(introSounds[0]));
                countNum.offset.x = 60;
                countNum.offset.y = 60;
                countNum.animation.play('3', true);
                
                if (StringTools.contains(gf.curCharacter, "pibby") && StringTools.contains(boyfriend.curCharacter, "newbf")){
                    bfIntro.playAnim('3'); 
                    pibbyIntro.playAnim('3');
                    
                    boyfriend.alpha = 0.0001; 
                    bfIntro.alpha = 1; 
                    gf.alpha = 0.0001; 
                    pibbyIntro.alpha = 1;
                }
                
                camera.zoom += 0.14;
                FlxTween.tween(camera, {zoom: camera.zoom-0.06}, 0.4, {ease: FlxEase.quartOut});
                
                countNum.alpha = 1;

                new FlxTimer().start(0.67, function(tmr:FlxTimer){
                    FlxG.sound.play(Paths.sound(introSounds[1]));
                    countNum.offset.x = 0;
                    countNum.offset.y = 0;
                    countNum.animation.play('2', true);
                    
                    if (StringTools.contains(gf.curCharacter, "pibby") && StringTools.contains(boyfriend.curCharacter, "newbf")){
                        bfIntro.playAnim('2');
                        pibbyIntro.playAnim('2');
                    }

                    camera.zoom += 0.14;
                    FlxTween.tween(camera, {zoom: camera.zoom-0.06}, 0.4, {ease: FlxEase.quartOut});
                    
                    new FlxTimer().start(0.67, function(tmr:FlxTimer){
                        FlxG.sound.play(Paths.sound(introSounds[2]));
                        countNum.offset.x = 0;
                        countNum.offset.y = 0;
                        countNum.animation.play('1', true);
                    
                        if (StringTools.contains(gf.curCharacter, "pibby") && StringTools.contains(boyfriend.curCharacter, "newbf")){
                            bfIntro.playAnim('1');
                            pibbyIntro.playAnim('1');
                        }

                        camera.zoom += 0.14;
                        FlxTween.tween(camera, {zoom: camera.zoom-0.06}, 0.4, {ease: FlxEase.quartOut});

                        new FlxTimer().start(0.67, function(tmr:FlxTimer){
                            FlxG.sound.play(Paths.sound(introSounds[3]));
                            countNum.offset.x = 140;
                            countNum.offset.y = 50;
                            countNum.animation.play('Go', true);
                    
                            if (StringTools.contains(gf.curCharacter, "pibby") && StringTools.contains(boyfriend.curCharacter, "newbf")){
                                bfIntro.playAnim('go');
                                pibbyIntro.playAnim('go');
                            }

                            FlxTween.tween(camera, {zoom: camera.zoom-0.20}, 0.4, {ease: FlxEase.quartOut});

                            new FlxTimer().start(0.5, function(tmr:FlxTimer){

                                remove(countNum);
                                new FlxTimer().start(0.5, function(tmr:FlxTimer){
                                    seenCutscene = true;
                                    inCutscene = false;

                                    camHUD.alpha = 1;
                                    textFlickShit();
                    
                                    if (StringTools.contains(gf.curCharacter, "pibby") && StringTools.contains(boyfriend.curCharacter, "newbf")){
                                        boyfriend.alpha = 1;
                                        gf.alpha = 1;
    
                                        for (introsChars in [bfIntro, pibbyIntro]){
                                            introsChars.kill();
                                            introsChars.destroy();
                                            remove(introsChars);
                                        }
                                    }

                                });
                            });
                        });
                    });
                });
            });

        case "childs-play", "retcon", "childs-play-v2":
            new FlxTimer().start(0.5, function(tmr:FlxTimer){
                FlxG.sound.play(Paths.sound(introSounds[0]));
                countNum.offset.x = 60;
                countNum.offset.y = 60;
                countNum.animation.play('3', true);
                bfIntro.playAnim('3'); 
                
                if (curSong == "childs-play-v2"){
                    tweenCamZoom(defaultCamZoom+0.06, 0.4, true, FlxEase.quartOut);
                } else if (curSong != "childs-play-v2"){
                    camera.zoom += 0.14;
                    FlxTween.tween(camera, {zoom: camera.zoom-0.06}, 0.4, {ease: FlxEase.quartOut});
                }
                countNum.alpha = 1;
                boyfriend.alpha = 0.0001; 
                bfIntro.alpha = 1; 
                new FlxTimer().start(0.67, function(tmr:FlxTimer){
                    FlxG.sound.play(Paths.sound(introSounds[1]));
                    countNum.offset.x = 0;
                    countNum.offset.y = 0;
                    countNum.animation.play('2', true);
                    bfIntro.playAnim('2');
                
                    if (curSong == "childs-play-v2"){
                        tweenCamZoom(defaultCamZoom+0.06, 0.4, true, FlxEase.quartOut);
                    } else if (curSong != "childs-play-v2"){
                        camera.zoom += 0.14;
                        FlxTween.tween(camera, {zoom: camera.zoom-0.06}, 0.4, {ease: FlxEase.quartOut});
                    }
                    new FlxTimer().start(0.67, function(tmr:FlxTimer){
                        FlxG.sound.play(Paths.sound(introSounds[2]));
                        countNum.offset.x = 0;
                        countNum.offset.y = 0;
                        countNum.animation.play('1', true);
                        bfIntro.playAnim('1'); 
                
                        if (curSong == "childs-play-v2"){
                            tweenCamZoom(defaultCamZoom+0.14, 0);
                            tweenCamZoom(defaultCamZoom+0.06, 0.4, true, FlxEase.quartOut);
                        } else if (curSong != "childs-play-v2"){
                            camera.zoom += 0.14;
                            FlxTween.tween(camera, {zoom: camera.zoom-0.06}, 0.4, {ease: FlxEase.quartOut});
                        }
                        new FlxTimer().start(0.67, function(tmr:FlxTimer){
                            FlxG.sound.play(Paths.sound(introSounds[3]));
                            countNum.offset.x = 140;
                            countNum.offset.y = 50;
                            countNum.animation.play('Go', true);
                            bfIntro.playAnim('go');

                            //camCinema.flash();
                
                            if (curSong == "childs-play-v2"){
                                tweenCamZoom(defaultCamZoom-0.20, 0.4, true, FlxEase.quartOut);
                            } else if (curSong != "childs-play-v2"){
                                FlxTween.tween(camera, {zoom: camera.zoom-0.20}, 0.4, {ease: FlxEase.quartOut});
                            }
                            new FlxTimer().start(0.5, function(tmr:FlxTimer){

                                remove(countNum);
                                new FlxTimer().start(0.5, function(tmr:FlxTimer){
                                    boyfriend.alpha = 1;
    
                                    bfIntro.kill();
                                    bfIntro.destroy();
                                    remove(bfIntro);

                                    seenCutscene = true;
                                    inCutscene = false;

                                    if(curSong != "retcon") camHUD.alpha = 1;
                                    
                                    var timer = curSong == "childs-play-v2"? 34 : curSong == "retcon"? 37 : curSong == "childs-play"? 67 : 0;
                                    textFlickShit(timer);

                                });
                            });
                        });
                    });
                });
            });

        default:
            new FlxTimer().start(0.5, function(tmr:FlxTimer){
                FlxG.sound.play(Paths.sound(introSounds[0]));
                countNum.offset.x = 60;
                countNum.offset.y = 60;
                countNum.animation.play('3', true);
                countNum.alpha = 1;
                new FlxTimer().start(0.67, function(tmr:FlxTimer){
                    FlxG.sound.play(Paths.sound(introSounds[1]));
                    countNum.offset.x = 0;
                    countNum.offset.y = 0;
                    countNum.animation.play('2', true);
                    new FlxTimer().start(0.67, function(tmr:FlxTimer){
                        FlxG.sound.play(Paths.sound(introSounds[2]));
                        countNum.offset.x = 0;
                        countNum.offset.y = 0;
                        countNum.animation.play('1', true);
                        new FlxTimer().start(0.67, function(tmr:FlxTimer){
                            FlxG.sound.play(Paths.sound(introSounds[3]));
                            countNum.offset.x = 140;
                            countNum.offset.y = 50;
                            countNum.animation.play('Go', true);

                            //camCinema.flash();

                            switch(curSong) {
                                case "my-amazing-world", "forgotten-world", "come-along-with-me":
                                    camHUD.alpha = 0.001;

                                default:
                                    camHUD.alpha = 1;
                            }

                            new FlxTimer().start(0.5, function(tmr:FlxTimer){
                                remove(countNum);
                                new FlxTimer().start(0.5, function(tmr:FlxTimer){
                                    inCutscene = false;
                                    textFlickShit();

                                });
                            });
                        });
                    });
                });
            });
    }
}

public function textFlickShit(?delay:Int = 0){

    FlxTween.tween(creditTxt, {alpha: 1, y: creditTxt.y + 250}, 2, {startDelay: delay, 
        ease: FlxEase.sineInOut, onComplete: function(twn){
            creditTxt2.y = creditTxt.y;
            
            barShit.y = creditTxt.y + creditTxt.height + 8;

            FlxTween.tween(creditTxt2, {y:  creditTxt.y + 75, alpha: 1}, 2, {
                ease: FlxEase.sineInOut, onComplete: function(twn){
                }
            });

            FlxTween.tween(barShit.scale, {x: creditTxt.width/2}, 2.75, {
                ease: FlxEase.cubeInOut, onComplete: function(twn){
            
                    FlxTween.tween(barShit.scale, {x: 0}, 1.75, {startDelay: 2, 
                        ease: FlxEase.quartInOut, onComplete: function(twn){

                            for (texts in [creditTxt,creditTxt2])
                                FlxFlicker.flicker(texts, 1, 0.06, false,  false,
                                    function(flick){
                                        songTxt.x = -25;
                                        FlxTween.tween(songTxt, {alpha: 1, 'x': 25}, 1);
                                        songTxt.revive();
                                        songTxt.resetText(PlayState.SONG.meta.displayName);
                                        songTxt.start(0.1, true);
                                        songTxt.completeCallback = function() {
                                            FlxFlicker.flicker(songTxt, 0.8, 0.06, true,  false, function(flick){
                                                if(Options.gameplayShaders) songTxt.shader = shaderTextChoose.get(FlxG.save.data.shadertext);

                                                songTxt.blend = 1;
                                            });
                                        }

                                        diffTxt.alpha = 1;
                                        FlxFlicker.flicker(diffTxt, 1, 0.06, true,  false, function(flick){
                                            if(Options.gameplayShaders) diffTxt.shader = shaderTextChoose.get(FlxG.save.data.shadertext);
                                        });
                            });
                        }
                    });
                    
                }
            });
        }
    });
}
public function setSongTime(time:Float)
{
	if(time < 0) time = 0;

    FlxG.sound.music.pause();
	vocals.pause();

	FlxG.sound.music.time = time;
	//FlxG.sound.music.pitch = playbackRate;
	FlxG.sound.music.play();

	if (Conductor.songPosition <= vocals.length)
	{
		vocals.time = time;
		//vocals.pitch = playbackRate;
	}
	vocals.play();
	Conductor.songPosition = time;
	songTime = time;
}