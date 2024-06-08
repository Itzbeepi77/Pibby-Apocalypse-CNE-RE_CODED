function stepHit(curStep){
    switch(curStep){
        case 1198:
            FlxTween.num(152000, 198390, 3, {onUpdate: function(v:FlxTween){
                songLength = v.value;
            }});
            
        case 1456:
            FlxTween.num(198390, inst.length, 3, {onUpdate: function(v:FlxTween){
                songLength = v.value;
            }});
    }
}