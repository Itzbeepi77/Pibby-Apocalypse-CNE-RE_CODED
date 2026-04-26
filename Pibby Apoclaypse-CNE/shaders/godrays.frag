#pragma header

const int NUM_SAMPLES = 50;
//const float Exposure = 0.4; // Directly scale the effect (0 = no effect, 1 = full)
const float Exposure = 0.6; // Directly scale the effect (0 = no effect, 1 = full)
//const float MyDecay = 1.8;
const float MyDecay = 1.0;
//const float CircleSize = 1.0;
const float CircleSize = 1.0;
//const float CircleSize = 0.1;

float Weight = 1.0 / float(NUM_SAMPLES);
float Decay = 1.0 - MyDecay / float(NUM_SAMPLES);

vec2 LightPos;
uniform vec2 _LightPos;

// green screen effect on input texture where the foreground is made black, with a white gradient dot as background
vec4 occlusion(vec2 q)
{
	float i = clamp(length((q-LightPos)*vec2(openfl_TextureSize.x/openfl_TextureSize.y, 1.0))/CircleSize, 0.0, 1.0);
	i = 1.0 - i*i;

	vec4 bg = vec4(i,i,i,i);
	vec4 fg = flixel_texture2D( bitmap, q ).rgba;

	float k = 1.0-fg.a;
	fg = vec4(k,k,k,k);

	return mix(fg, bg, k);
}


// god ray effect
vec4 godray(vec2 texCoord)
{
    vec3 myColor = vec3(252.0/255.0, 143.0/255.0, 25.0/255.0);
     vec4 color = vec4(0,0,0,0);
    // Set up illumination decay factor.
    float illuminationDecay = 1.0;
    // Evaluate summation from Equation 3 NUM_SAMPLES iterations.
    for (int i = 0; i < NUM_SAMPLES; i++)
    {
        // Step sample location along ray.
        vec2 uv = mix(texCoord, LightPos, float(i) / float(NUM_SAMPLES-1));

        // Retrieve sample at new location.
        vec4 sampl = occlusion(uv);
        // Apply sample attenuation scale/decay factors.
        sampl *= illuminationDecay * Weight;
        // Accumulate combined color.
        color += sampl;
        // Update exponential decay factor.
        illuminationDecay *= Decay;
    }
    // Output final color with a further scale control factor.
    return vec4(myColor, 1.0) * vec4( color * Exposure );
}

void main()
{
	vec2 uv = openfl_TextureCoordv.xy;
	vec2 fragCoord = uv * openfl_TextureSize.xy;

	LightPos = _LightPos;// / openfl_TextureSize.xy;
	// fragColor = godray(uv) + vec4(greenscreen(uv),1);
	// fragColor = vec4(greenscreen(uv),1);
	vec4 gr = godray(uv);
	gl_FragColor = gr + flixel_texture2D(bitmap, uv);
}