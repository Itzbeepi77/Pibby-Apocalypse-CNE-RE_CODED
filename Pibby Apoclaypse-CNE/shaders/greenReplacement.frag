#pragma header
const float threshold = 0.5;
const float padding = 0.05;

uniform vec3 replacementColour;

void main()
{
    vec2 uv = openfl_TextureCoordv;
        
    vec4 greenScreen = vec4(0.,1.,0.,1.);
    vec3 color = flixel_texture2D(bitmap, uv).rgb;
    float alpha = flixel_texture2D(bitmap, uv).a;
        
    vec3 diff = color.xyz - greenScreen.xyz;
    float fac = smoothstep(threshold-padding,threshold+padding, dot(diff,diff));
        
    color = mix(color.rgb, replacementColour, 1.-fac);
    gl_FragColor = vec4(color.rgb * alpha, alpha);
}