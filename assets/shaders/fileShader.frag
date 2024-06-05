#pragma header
    vec2 uv;
    vec2 fragCoord;
    vec2 iResolution;
    uniform float iTime;
    #define iChannel0 bitmap
    #define iChannel1 bitmap
    #define texture texture2D
    #define fragColor gl_FragColor

    // https://www.shadertoy.com/view/NtGfWw

    float noise(vec2 p)
    {
        float s = texture(iChannel1,vec2(1.0,2.0*cos(iTime))*iTime*8.0 + p*1.0).x;
        s *= s;
        return s;
    }

    float onOff(float a, float b, float c)
    {
        return step(c, sin(iTime + a*cos(iTime*b)));
    }

    float ramp(float y, float start, float end)
    {
        float inside = step(start,y) - step(end,y);
        float fact = (y-start)/(end-start)*inside;
        return (1.0-fact) * inside;
        
    }

    float stripes(vec2 uv)
    {
        
        float noi = noise(uv*vec2(0.5,1.0) + vec2(1.0,3.0));
        return ramp(mod(uv.y*4.0 + iTime/2.0+sin(iTime + sin(iTime*0.63)),1.0),0.5,0.6)*noi;
    }

    vec3 getVideo(vec2 uv)
    {
        vec2 look = uv;
        float window = 1.0/(1.+20.0*(look.y-mod(iTime/4.0,1.0))*(look.y-mod(iTime/4.0,1.0)));
        look.x = look.x + sin(look.y*10.0 + iTime)/50.0*onOff(4.0,4.0,0.3)*(1.+cos(iTime*80.0))*window;
        float vShift = 0.4*onOff(2.0,3.0,0.9)*(sin(iTime)*sin(iTime*20.0) + 
                                            (0.5 + 0.1*sin(iTime*200.0)*cos(iTime)));
        look.y = mod(look.y + vShift, 1.0);
        vec3 video = vec3(texture2D(iChannel0,look));
        return video;
    }

    vec2 screenDistort(vec2 uv)
    {
        uv -= vec2(0.5,0.5);
        uv = uv*1.2*(1.0/1.2+2.0*uv.x*uv.x*uv.y*uv.y);
        uv += vec2(0.5,0.5);
        return uv;
    }

    void main()
    {
 	  uv = openfl_TextureCoordv.xy;
	  fragCoord = openfl_TextureCoordv*openfl_TextureSize;
	  iResolution = openfl_TextureSize;
    vec2 fragCoord = openfl_TextureCoordv * iResolution;
        vec2 uv = fragCoord.xy / iResolution.xy;
        uv = screenDistort(uv);
        vec3 video = getVideo(uv);
        float vigAmt = 3.0+0.3*sin(iTime + 5.0*cos(iTime*5.0));
        float vignette = (1.0-vigAmt*(uv.y-.5)*(uv.y-0.5))*(1.0-vigAmt*(uv.x-0.5)*(uv.x-0.5));
        
        video += stripes(uv);
        video += noise(uv*2.0)/2.0;
        video *= vignette;
        video *= (12.0+mod(uv.y*30.0+iTime,1.0))/13.0;
        
        gl_FragColor = vec4(video,1.0);
    gl_FragColor.a = texture2D(bitmap, openfl_TextureCoordv).a;
    }