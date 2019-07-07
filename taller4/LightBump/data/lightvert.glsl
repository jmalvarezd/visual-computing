uniform mat4 modelview;
uniform mat4 transform;
uniform mat4 transformMatrix;
uniform mat3 normalMatrix;
uniform mat4 texMatrix;


attribute vec4 position;
attribute vec4 color;
attribute vec3 normal;
attribute vec2 texCoord;

const float one_float = 1.0;
const vec3 zero_vec3 = vec3(0);

varying vec4 vertColor;
varying vec4 backVertColor;
varying vec4 vertTexCoord;
varying vec3 cameraDirection;
varying vec3 ecNormal;
varying vec3 ecPosition;

void main() {
  gl_Position = transformMatrix * position;
  ecPosition = vec3(modelview * position);  
  ecNormal = normalize(normalMatrix * normal);
  cameraDirection = normalize(0 - ecPosition);
  
  vertTexCoord = texMatrix * vec4(texCoord, 1.0, 1.0);    

  vertColor = color;
  backVertColor = color;

  
}