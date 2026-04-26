    #pragma header

    uniform float bIntens;
    uniform float invertValue;
    
    void main(){
        vec2 uv = openfl_TextureCoordv.xy;
        
        // get snapped position
        float psize = 0.04 * bIntens;
        float psq = 1.0 / psize;
    
        float px = floor(uv.x * psq + 0.5) * psize;
        float py = floor(uv.y * psq + 0.5) * psize;
        
        vec4 colSnap = flixel_texture2D(bitmap, vec2(px, py));
        
        float lum = pow(1.0 - (colSnap.r + colSnap.g + colSnap.b) / 3.0, bIntens);
        
        float qsize = psize * lum;
        float qsq = 1.0 / qsize;
    
        float qx = floor(uv.x * qsq + 0.5) * qsize;
        float qy = floor(uv.y * qsq + 0.5) * qsize;
    
        float rx = (px - qx) * lum + uv.x;
        float ry = (py - qy) * lum + uv.y;
    
        vec4 mierdaColor = flixel_texture2D(bitmap, vec2(rx, ry));

        gl_FragColor = mix(mierdaColor, vec4(1.0 - mierdaColor.r, 1.0 - mierdaColor.g, 1.0 - mierdaColor.b, mierdaColor.a) * mierdaColor.a, invertValue);
    }