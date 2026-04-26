var zoomTween:FlxTween = null;

function onEvent(eventEvent) {
  var params:Array = eventEvent.event.params;
  if (eventEvent.event.name == "cameraZoomTween") {
    var flxease:String = params[3] + (params[3] == "linear" ? "" : params[4]);

    if (zoomTween != null) zoomTween.cancel();

    camZooming = true;

    switch (params[0]){
      case "default":
        zoomTween = FlxTween.tween(camera, {zoom: params[1]}, params[2], {ease: Reflect.field(FlxEase, flxease)});
        defaultCamZoom = params[1];

      case "only camera":
        zoomTween = FlxTween.tween(camera, {zoom: params[1]}, params[2], {ease: Reflect.field(FlxEase, flxease)});

      case "stinky tween defaultZoom":
        zoomTween = FlxTween.tween(PlayState.instance, {defaultCamZoom: params[1]}, params[2], {ease: Reflect.field(FlxEase, flxease)});

      case "stinky old defaultZoom":
        var fucker:NumTween;
        if (fucker != null) fucker.cancel();
        fucker = FlxTween.num(defaultCamZoom, params[1], params[2], {ease: Reflect.field(FlxEase, flxease), onUpdate: function(){
          defaultCamZoom = fucker.value;}});
    }
  }
}