#pragma header

uniform vec3 iResolution;
uniform float distortionScale;

void main()
{
    vec2 baseUV = openfl_TextureCoordv.xy;
    
    vec2 fromCentre = baseUV - 0.5;
    fromCentre.y *= (openfl_TextureSize.y / openfl_TextureSize.x);
    float radius = length(fromCentre);
    fromCentre = radius > 1e-6
        ? (fromCentre * (1.0 / radius))
        : vec2(0);
    
    float strength = 1.0 - 0.5;
    float distortion = distortionScale * pow(radius, 2.0) * strength;
    
    vec2 distortUV = baseUV - fromCentre * distortion;
    
    vec4 planeLens = flixel_texture2D(bitmap, distortUV);
    
    gl_FragColor = vec4(planeLens.r, planeLens.g, planeLens.b, planeLens.a);
}