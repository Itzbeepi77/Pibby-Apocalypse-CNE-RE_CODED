var camZoom:Float;
var hudZoom:Float;

function onEvent(eventEvent) {
    if (eventEvent.event.name == "Add Cam Zoom") {
            zoom(eventEvent);
        }
}
function zoom(eventEvent) {
    camZoom = Std.parseFloat(eventEvent.event.params[0]);
    hudZoom = Std.parseFloat(eventEvent.event.params[1]);

    FlxG.camera.zoom += 0.015 * camZoomingStrength;
    camHUD.zoom += 0.03 * camZoomingStrength;
}