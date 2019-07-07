uniform mat4 modelview;
uniform mat4 transform;
uniform mat4 transformMatrix;
uniform mat3 normalMatrix;

uniform vec4 lightPosition[8];
uniform int lightCount;
uniform vec3 lightDiffuse[8];
uniform vec3 lightAmbient[8];
uniform vec3 lightSpecular[8];

attribute vec4 position;
attribute vec4 color;
attribute vec4 ambient;
attribute vec4 specular;
attribute vec3 normal;

const float one_float = 1.0;
const vec3 zero_vec3 = vec3(0);

varying vec4 vertColor;
varying vec4 backVertColor;

void main() {
  gl_Position = transformMatrix * position;
  vec3 ecPosition = vec3(modelview * position);  
  vec3 ecNormal = normalize(normalMatrix * normal);
  vec3 cameraDirection = normalize(0 - ecPosition);

    
  // Light calculations
  vec3 totalAmbient = vec3(0, 0, 0);
  
  vec3 totalFrontDiffuse = vec3(0, 0, 0);
  vec3 totalFrontSpecular = vec3(0, 0, 0);
    
  vec3 totalBackDiffuse = vec3(0, 0, 0);
  vec3 totalBackSpecular = vec3(0, 0, 0);

  for (int i = 0; i < lightCount; i++) {
    vec3 lightPos = lightPosition[i].xyz;
    if (any(greaterThan(lightAmbient[i], zero_vec3))) {
      totalAmbient += lightAmbient[i];
    }
    if (any(greaterThan(lightSpecular[i], zero_vec3))) {
      totalFrontDiffuse  += lightSpecular[i] * max(0.0, dot(reflect(-normalize(lightPos - ecPosition), ecNormal             ), cameraDirection));
      totalBackDiffuse   += lightSpecular[i] * max(0.0, dot(reflect(-normalize(lightPos - ecPosition), ecNormal * -one_float), cameraDirection));
    }
    
    if (any(greaterThan(lightDiffuse[i], zero_vec3))) {
      totalFrontSpecular += lightDiffuse[i] * max(0.0, dot(normalize(lightPos - ecPosition), ecNormal));
      totalBackSpecular  += lightDiffuse[i] * max(0.0, dot(normalize(lightPos - ecPosition), ecNormal * -one_float));
    }     
  }

  vertColor =    vec4(totalAmbient, 0) * ambient + 
                  vec4(totalFrontDiffuse, 1) * color + 
                  vec4(totalFrontSpecular, 0) * specular;

  backVertColor = vec4(totalAmbient, 0) * ambient + 
                  vec4(totalBackDiffuse, 1) * color + 
                  vec4(totalBackSpecular, 0) * specular; 
}