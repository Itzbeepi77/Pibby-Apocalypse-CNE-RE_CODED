if (strumLines.members[0] != null){
    for (dads in [strumLines.members[0].characters]){
        if (dads != null){
            if (dads.sprite != null) graphicCache.cache(Paths.image("characters/" + dads.sprite));

            if (dads.icon != null && dads.xml != null && dads.xml.exists("icon")) graphicCache.cache(Paths.image("icons/" + dads.xml.get("icon")));
        }
    }
}

if (strumLines.members[1] != null){
    for (bfs in [strumLines.members[1].characters]){
        if (bfs != null){
            if (bfs.sprite != null) graphicCache.cache(Paths.image("characters/" + bfs.sprite));

            if (bfs.icon != null && bfs.xml != null && bfs.xml.exists("icon")) graphicCache.cache(Paths.image("icons/" + bfs.xml.get("icon")));
        }
    }
}

if (strumLines.members[2] != null){
    for (gfs in [strumLines.members[2].characters]){
        if (gfs != null){
            if (gfs.sprite != null) graphicCache.cache(Paths.image("characters/" + gfs.sprite));

            if (gfs.icon != null && gfs.xml != null && gfs.xml.exists("icon")) graphicCache.cache(Paths.image("icons/" + gfs.xml.get("icon")));
        }
    }
}

if (strumLines.members[3] != null){
    for (extraChar in [strumLines.members[3].characters]){
        if (extraChar != null){
            if (extraChar.sprite != null) graphicCache.cache(Paths.image("characters/" + extraChar.sprite));

            if (extraChar.icon != null && extraChar.xml != null && extraChar.xml.exists("icon")) graphicCache.cache(Paths.image("icons/" + extraChar.xml.get("icon")));
        }
    }
}

for (intros in [bfIntro,pibbyIntro]){
    if (intros != null){
        if (intros.sprite != null) graphicCache.cache(Paths.image("characters/" + intros.sprite));
    }
}

function onPostNoteCreation(e){
    (e.note.sprite == null) ? graphicCache.cache(Paths.image("game/notes/default")) : graphicCache.cache(Paths.image("game/notes/" + e.note.sprite));
}

function onPostStrumCreation(e){
    (e.strum.sprite == null) ? graphicCache.cache(Paths.image("game/notes/default")) : graphicCache.cache(Paths.image("game/notes/" + e.strum.sprite));
}