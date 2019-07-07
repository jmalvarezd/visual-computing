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
    float falloff = 1.0/(1.0+( 0.000001*pow(distance(lightPos,ecPosition),2))); //Don't ask
    if (any(greaterThan(lightAmbient[i], zero_vec3))) {
      totalAmbient += lightAmbient[i];
    }
    if (any(greaterThan(lightSpecular[i], zero_vec3))) {
      totalBackSpecular  += falloff * lightSpecular[i] * max(0.0, dot(reflect(-normalize(lightPos - ecPosition), ecNormal * -one_float), cameraDirection));
      totalFrontSpecular   += falloff * lightSpecular[i] * max(0.0, dot(reflect(-normalize(lightPos - ecPosition), ecNormal ), cameraDirection));
    }
    
    if (any(greaterThan(lightDiffuse[i], zero_vec3))) {
      totalBackDiffuse += falloff * lightDiffuse[i] * max(0.0, dot(normalize(lightPos - ecPosition), ecNormal*  -one_float));
      totalFrontDiffuse  += falloff * lightDiffuse[i] * max(0.0, dot(normalize(lightPos - ecPosition), ecNormal ));
    }     
  }

  vertColor =    vec4(totalAmbient, 0) * ambient + 
                  vec4(totalFrontDiffuse, 1) * color + 
                  vec4(totalFrontSpecular, 0) * specular;

  backVertColor = vec4(totalAmbient, 0) * ambient + 
                  vec4(totalBackDiffuse, 1) * color + 
                  vec4(totalBackSpecular, 0) * specular; 
}