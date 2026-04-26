importScript("data/scripts/iconP3");

function create(){
    iconP3.alpha = 0.001;
}

function stepHit(step){
    if (step == 1568){
        iconP3.alpha = 1;
    }
}