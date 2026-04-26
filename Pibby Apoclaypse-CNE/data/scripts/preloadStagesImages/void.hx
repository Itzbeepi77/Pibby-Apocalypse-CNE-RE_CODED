var stageFolder = "stages/" + curStage + "/";
if (stage.getSprite("bg") != null){
    graphicCache.cache(Paths.image(stageFolder + "void"));
}
if (stage.getSprite("glitch") != null){
    graphicCache.cache(Paths.image(stageFolder + "gumballglitchbg"));
}