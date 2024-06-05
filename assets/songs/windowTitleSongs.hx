function postCreate(){
    var windowTitle = "Pibby: Apocalypse - Now Playing: " + PlayState.SONG.meta.displayName;
    switch (curSong){
        case "blessed-by-swords":
            window.title = windowTitle + " - By Lettush";
        case "mindless":
            window.title = windowTitle + " - By Sevc_Ext_277";
        case "brotherly-love":
            window.title = windowTitle + " - By Kylevi";
        case "suffering-siblings":
            window.title = windowTitle + " - By Awe (Ft. Saster & Shxdow)";
        case "come-along-with-me", "forgotten-world":// will add child's play v2 and my finale later if I want to
            window.title = windowTitle + " - By Awe";
        case "childs-play":
            window.title = windowTitle + " - By Yoosuf Meekail";
        case "my-amazing-world":
            window.title = windowTitle + " - By Corn";
        case "retcon":
            window.title = windowTitle + " - By Rareblin (Ft. PattyDeCaffy)";
        case "wretched_gems":
            window.title = windowTitle + " - By Spades (Ft. Stormy & Myakish)";
        case "no-hero-remix":
            window.title = windowTitle + " - By RunDown";
            
        // moved/split, this song is gonna be it's own playable mod (like oneshot or bonus/extra update or smth)
        /*case "what-am-i":
            window.title = windowTitle + " - By IZincl";
        
        case "my-doll":
            window.title = windowTitle + " - By End-Sella (Ft. DemonStep)";*/
    }
}
