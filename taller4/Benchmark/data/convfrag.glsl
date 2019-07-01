#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform vec2 texOffset; // Passing by processing. That's mean (1/width, 1/height)

uniform bool showMask; // Passing with Set function
uniform int maskSelected; // Passing with Set function

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
  
  vec2 tc0 = vertTexCoord.st + vec2(-texOffset.s, -texOffset.t);
  vec2 tc1 = vertTexCoord.st + vec2(         0.0, -texOffset.t);
  vec2 tc2 = vertTexCoord.st + vec2(+texOffset.s, -texOffset.t);
  vec2 tc3 = vertTexCoord.st + vec2(-texOffset.s,          0.0);
  vec2 tc4 = vertTexCoord.st + vec2(         0.0,          0.0);
  vec2 tc5 = vertTexCoord.st + vec2(+texOffset.s,          0.0);
  vec2 tc6 = vertTexCoord.st + vec2(-texOffset.s, +texOffset.t);
  vec2 tc7 = vertTexCoord.st + vec2(         0.0, +texOffset.t);
  vec2 tc8 = vertTexCoord.st + vec2(+texOffset.s, +texOffset.t);
  
  vec4 col0 = texture2D(texture, tc0);
  vec4 col1 = texture2D(texture, tc1);
  vec4 col2 = texture2D(texture, tc2);
  vec4 col3 = texture2D(texture, tc3);
  vec4 col4 = texture2D(texture, tc4);
  vec4 col5 = texture2D(texture, tc5);
  vec4 col6 = texture2D(texture, tc6);
  vec4 col7 = texture2D(texture, tc7);
  vec4 col8 = texture2D(texture, tc8);

  vec4 sum =  texture2D(texture, vertTexCoord.st) * vertColor ;
  /*
    EDGE DETECTION
  */
  if (showMask && maskSelected == 1) {
    sum = col1 + col3 + col5 + col7 + (-4 * col4);
  }
  /*
    EDGE DETECTION 2
  */
  if (showMask && maskSelected == 2) {
    sum = 8.0 * col4 - (col0 + col1 + col2 + col3 + col5 + col6 + col7 + col8);
  }
  /*
    SHARPEN
  */
  if (showMask && maskSelected == 3) {
    sum = -1 * (col1 + col3 + col5 + col7) +  (5 * col4);
  }
  /*
    BOX BLUR
  */
  if (showMask && maskSelected == 4) {
    sum = 0.1111*(col0 + col1 + col2 + col3 + col4  + col5 + col6 + col7 + col8);
  }
  /*
    GAUSSIAN BLUR 3x3
  */
  if (showMask && maskSelected == 5) {
    sum = ((col0 + col2 + col6 + col8) * 0.0625) + ((col1 + col3 + col5 + col7) * 0.125) + (col4 *0.25);
  }
  if (showMask && maskSelected == 6) {
    vec2 tc9 = vertTexCoord.st + vec2(-texOffset.s * 2, -texOffset.t * 2);
    vec2 tc10 = vertTexCoord.st + vec2(-texOffset.s, -texOffset.t * 2);
    vec2 tc11 = vertTexCoord.st + vec2(0.0, -texOffset.t * 2);
    vec2 tc12 = vertTexCoord.st + vec2(texOffset.s, -texOffset.t * 2);
    vec2 tc13 = vertTexCoord.st + vec2(texOffset.s * 2, -texOffset.t * 2);

    vec2 tc14 = vertTexCoord.st + vec2(-texOffset.s * 2, -texOffset.t);
    vec2 tc15 = vertTexCoord.st + vec2(texOffset.s * 2, -texOffset.t);

    vec2 tc16 = vertTexCoord.st + vec2(-texOffset.s * 2, 0.0);
    vec2 tc17 = vertTexCoord.st + vec2(texOffset.s * 2, 0.0);

    vec2 tc18 = vertTexCoord.st + vec2(-texOffset.s * 2, texOffset.t);
    vec2 tc19 = vertTexCoord.st + vec2(texOffset.s * 2, texOffset.t);
    
    vec2 tc20 = vertTexCoord.st + vec2(-texOffset.s * 2, texOffset.t * 2);
    vec2 tc21 = vertTexCoord.st + vec2(-texOffset.s, texOffset.t * 2);
    vec2 tc22 = vertTexCoord.st + vec2(0.0, texOffset.t * 2);
    vec2 tc23 = vertTexCoord.st + vec2(texOffset.s, texOffset.t * 2);
    vec2 tc24 = vertTexCoord.st + vec2(texOffset.s * 2, texOffset.t * 2);

    vec4 col9 = texture2D(texture, tc9);
    vec4 col10 = texture2D(texture, tc10);
    vec4 col11 = texture2D(texture, tc11);
    vec4 col12 = texture2D(texture, tc12);
    vec4 col13 = texture2D(texture, tc13);
    vec4 col14 = texture2D(texture, tc14);
    vec4 col15 = texture2D(texture, tc15);
    vec4 col16 = texture2D(texture, tc16);
    vec4 col17 = texture2D(texture, tc17);
    vec4 col18 = texture2D(texture, tc18);
    vec4 col19 = texture2D(texture, tc19);
    vec4 col20 = texture2D(texture, tc20);
    vec4 col21 = texture2D(texture, tc21);
    vec4 col22 = texture2D(texture, tc22);
    vec4 col23 = texture2D(texture, tc23);
    vec4 col24 = texture2D(texture, tc24);

    sum = 0.00390625 * (col9 + col13 + col20 + col24) 
      + 0.015625 * (col10 + col12 + col14 + col15+ col18 + col19 + col21 + col23)
      + 0.0234375 * (col11 + col16 + col17 + col22) + 0.0625 * (col0 + col2 + col6 + col8)
      + 0.09375 * (col1 + col3 + col7 + col5) 
      + 0.125 * col4;
  }
  gl_FragColor = vec4(sum.rgb, 1.0);
}