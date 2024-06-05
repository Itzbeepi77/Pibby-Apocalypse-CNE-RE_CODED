#pragma header // I (WIZARDMANTIS441) STOLE THIS FROM BBPANZU AND CLEANED IT LOL!!!

// BLOOM SETTINGS
float _dim = 1.8;           // screen brightness
float _directions = 16.0;   // i have no clue
float _quality = 8.0;       // less = more white glow??
uniform float size = 18.0;
float _sizex = size/1280.0;          // how much bloom
float _sizey = size/720.0;          // how much bloom

void main(void) {
	vec2 uv = openfl_TextureCoordv;
	float Pi = 6.28318530718; // pi * 2
	vec4 _color = flixel_texture2D(bitmap, uv);
	for (float d = 0.0; d < Pi; d += Pi / _directions) {
		for (float i = 1.0 / _quality; i <= 1.0; i += 1.0 / _quality) {
			float ex = (cos(d) * _sizey * i);
			float why = (sin(d) * _sizey * i);
			_color += flixel_texture2D(bitmap, uv + vec2(ex, why));
		}
	}

	_color /= (_dim * _quality) * _directions - 15.0;
	vec4 bloom = (flixel_texture2D(bitmap, uv) / _dim) + _color;
	gl_FragColor = bloom;
}