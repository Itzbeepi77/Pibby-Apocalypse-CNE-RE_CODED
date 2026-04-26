importScript("data/scripts/iconP3");// pibby
importScript("data/scripts/iconP4");// jake

function stepHit(curStep){
    if (curStep == 2400){// change pibby icon
        iconP3.setIcon(strumLines.members[2].characters[1] != null && strumLines.members[2].characters[1].icon!=null?strumLines.members[2].characters[1].icon:strumLines.members[2].characters[1].curCharacter);
    }
}