function onEvent(eventEvent) {
  var params:Array = eventEvent.event.params;
  if (eventEvent.event.name == "defaultZoomTween") {
    var flxease:String = params[2] + (params[2] == "linear" ? "" : params[3]);
    FlxTween.num(defaultCamZoom, params[0], params[1], {ease: Reflect.field(FlxEase, flxease), function(value) { defaultCamZoom = value; }});
  }
}