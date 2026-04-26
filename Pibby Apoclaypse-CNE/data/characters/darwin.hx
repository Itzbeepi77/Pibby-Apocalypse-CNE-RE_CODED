function postCreate(){
	idleSuffix = FlxG.random.bool(25)? '-blink' : '';
	playAnim("idle" + idleSuffix,true);
}
function onDance(event) {
	event.cancel();
	idleSuffix = FlxG.random.bool(25)? '-blink' : '';
	playAnim("idle" + idleSuffix);
}
function beatHit(curBeat){
	if (curBeat % 2 == 0){
	}
}