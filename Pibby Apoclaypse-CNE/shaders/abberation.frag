#pragma header
/*
https://www.shadertoy.com/view/wtt3z2
*/
    
uniform float aberration;
    
vec3 tex2D(sampler2D _tex,vec2 _p)
{
    vec3 col=flixel_texture2D(_tex,_p).xyz;
    if(0.5<abs(_p.x-0.5)){
        col=vec3(0.1);
    }
    return col;
}
    
void main() {
    vec2 uv = openfl_TextureCoordv; //openfl_TextureCoordv.xy*2.0 / openfl_TextureSize.xy-vec2(1.0);
        
    vec2 trueAberration = aberration * pow((uv - 0.5), vec2(3.0, 3.0));
    // vec4 texColor = tex2D(bitmap, uv_prj.st);
    gl_FragColor = vec4(
        flixel_texture2D(bitmap, uv + trueAberration).r, 
        flixel_texture2D(bitmap, uv).g, 
        flixel_texture2D(bitmap, uv - trueAberration).b, 
        flixel_texture2D(bitmap,uv).a
    );
}