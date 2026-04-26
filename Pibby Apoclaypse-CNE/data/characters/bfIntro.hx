var self = this;
var game = PlayState.instance;

function update(elapsed) {
    self.angle = game.boyfriend.angle;
}

// yuh
if (PlayState.SONG.meta.name == "Retcon"){
    function postCreate(){
        floating(self, -22.5, 22.5, 2.5, 2.5);
    }
    
    function floating(obj, val1, val2, time1, time2){
        FlxTween.tween(obj, {y: obj.y + val1}, time1, {
            ease: FlxEase.sineInOut,
            onComplete: function(twn){
                FlxTween.tween(obj, {y: obj.y + val2}, time2, {
                    ease: FlxEase.sineInOut,
                    onComplete: function(twn){
                        floating(obj, val1, val2, time1, time2);     
                    }
                });
            }
        });
    }
}