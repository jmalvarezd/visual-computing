#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D textureBrick;
uniform sampler2D normalMap;

uniform vec4 lightPosition[8];
uniform int lightCount;
uniform vec3 lightDiffuse[8];
uniform vec3 lightAmbient[8];
uniform vec3 lightSpecular[8];


uniform vec4 ambient;
uniform vec4 specular;
uniform bool bump;

varying vec4 vertColor;
varying vec4 backVertColor;
varying vec4 vertTexCoord;
varying vec3 cameraDirection;
varying vec3 ecNormal;
varying vec3 ecPosition;

vec4 intensity;
vec4 backIntensity;


const float one_float = 1.0;
const vec3 zero_vec3 = vec3(0);

void main() {

  vec3 normal = normalize(ecNormal);
  if(bump){
    normal = texture2D(normalMap, vertTexCoord.xy).rgb*2.0 - 1.0;
    normal = normalize(normal);
    normal.y = -normal.y;
  }      
  // Light calculations
  vec3 totalAmbient = vec3(0, 0, 0);
  
  vec3 totalFrontDiffuse = vec3(0, 0, 0);
  vec3 totalFrontSpecular = vec3(0, 0, 0);
    
  vec3 totalBackDiffuse = vec3(0, 0, 0);
  vec3 totalBackSpecular = vec3(0, 0, 0);

  for (int i = 0; i < lightCount; i++) {
    vec3 lightPos = lightPosition[i].xyz;
    float falloff = 1.0/(1.0+( 0.000001*pow(distance(lightPos,ecPosition),2))); //Don't ask
    vec3 lightDir = normalize(lightPos - ecPosition);
    if (any(greaterThan(lightAmbient[i], zero_vec3))) {
      totalAmbient += lightAmbient[i];
    }
    if (any(greaterThan(lightSpecular[i], zero_vec3))) {
      totalBackSpecular +=  falloff * 
                            lightSpecular[i] * 
                            pow(max(0.0, dot(reflect(-lightDir, normal * -one_float), cameraDirection)),8);
      totalFrontSpecular += falloff * 
                            lightSpecular[i] * 
                            pow(max(0.0, dot(reflect(-lightDir, normal ), cameraDirection)),8);
    }
    
    if (any(greaterThan(lightDiffuse[i], zero_vec3))) {
      totalBackDiffuse += falloff * 
                          lightDiffuse[i] * 
                          max(0.0, dot(lightDir, normal*  -one_float));
      totalFrontDiffuse +=  falloff * 
                            lightDiffuse[i] * 
                            max(0.0, dot(lightDir, normal ));
    }     
  }

  intensity =    vec4(totalAmbient, 0) * ambient + 
                  vec4(totalFrontDiffuse, 1) * vertColor + 
                  vec4(totalFrontSpecular, 0) * specular;

  backIntensity = vec4(totalAmbient, 0) * ambient + 
                  vec4(totalBackDiffuse, 1) * backVertColor + 
                  vec4(totalBackSpecular, 0) * specular; 
  
  gl_FragColor = texture2D(textureBrick, vertTexCoord.st) * (gl_FrontFacing ? intensity : backIntensity);
}