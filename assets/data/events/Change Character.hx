var preloadedCharacters = [];

function postCreate() {
	for (event in events) {
		if (event.name == 'Change Character') {
			var shit = strumLines.members[event.params[0]].characters[0];
			var char = new Character(shit.x, shit.y, event.params[1], shit.isPlayer);
			char.alpha = 0.001;
			insert(members.indexOf(shit), char);
			preloadedCharacters.push([char, strumLines.members[event.params[0]]]);
		}
	}
}

function onEvent(_) {
	if (_.event.name == 'Change Character') {
		var stuff = preloadedCharacters.pop();
		var char = stuff[0];
		var offsetarr = _.event.params[3] != null ? _.event.params[3].split(',') : null;

		stage.applyCharStuff(char, stuff[1].data.position, 1);
		if (offsetarr != null) {
			char.x += Std.parseFloat(offsetarr[0]);
			char.y += Std.parseFloat(offsetarr[1]);
		}
		char.angle = stuff[1].characters[0].angle;
		char.alpha = stuff[1].characters[0].alpha;
		char.color = _.event.params[4] != false ? stuff[1].characters[0].color : 0xFFFFFFFF;

		remove(stuff[1].characters[0]);
		stuff[1].characters[0] = char;

		if (_.event.params[2] || _.event.params[2] == null) {
			if (stuff[1].opponentSide) {
				iconP2.setIcon(char.icon!=null?char.icon:char.curCharacter);
			} else {
				iconP1.setIcon(char.icon!=null?char.icon:char.curCharacter);
			}
		}
	}
}