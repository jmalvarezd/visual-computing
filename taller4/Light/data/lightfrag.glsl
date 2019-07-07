#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D textureBrick;

varying vec4 vertColor;
varying vec4 backVertColor;
varying vec4 vertTexCoord;

void main() {
  gl_FragColor = texture2D(textureBrick, vertTexCoord.st) * (gl_FrontFacing ? vertColor : backVertColor);
}