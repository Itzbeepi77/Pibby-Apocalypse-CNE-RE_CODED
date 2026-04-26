public var globalHitOffset = 0;

public var judgements = [
    {
        window: 45 + globalHitOffset,
        score: 300,
        accuracy: 1,
        name: "sick"
    },
    {
        window: 90 + globalHitOffset,
        score: 200,
        accuracy: 0.75,
        name: "good"
    },
    {
        window: 135 + globalHitOffset,
        score: 100,
        accuracy: 0.25,
        name: "bad"
    },
    {
        window: 160 + globalHitOffset,
        score: 50,
        accuracy: 0,
        name: "shit"
    }
];

function onPlayerHit(e)
{
    var noteDiff = Math.abs(Conductor.songPosition - e.note.strumTime);

    // monster of monsters code no way????
    // (i just ported it to softcode, since its originally hardcoded from the mod itself, original code by nebula) - syrup
    // thanks for the goat script, syrup - Notbeep
    for(j in judgements)
    {
        if(noteDiff <= j.window)
        {
            e.rating = j.name;
            e.score = j.score;
            e.accuracy = j.accuracy;

            break;
        }
    }

    // fixes a lil issue
    if (e.rating != 'sick') e.showSplash = false;
}