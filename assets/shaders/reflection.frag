#pragma header
uniform float reflectionY = 0.36;


    vec4 color = vec4(1.0);
    void main()
    {
      vec2 uv = openfl_TextureCoordv.xy / iResolution.xy;
      if(uv.y <= reflectionY)
      {
        float oy = uv.y;
        uv.y = 2.0 * reflectionY - uv.y;
        color = vec4(0.7, 0.85, 1.0, 1.0);
      }

        gl_FragColor = flixel_texture2D(bitmap, uv) * Color;
    }