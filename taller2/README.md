# Taller ilusiones visuales

## Propósito

Comprender algunos aspectos fundamentales de la [inferencia inconsciente](https://github.com/VisualComputing/Cognitive) de la percepción visual humana.

## Tareas

Implementar al menos 6 ilusiones de tres tipos distintos (paradójicas, geométricas, ambiguas, etc.), al menos dos con movimiento y dos con interactividad.

## Integrantes

Complete la tabla:

| Integrante | github nick |
|------------|-------------|
| Nicolas Campuzano Angulo | ncampuzano |
| Juan Manuel Alvarez | jmalvarezd |

## Discusión

1. Complete la tabla

| Ilusión | Categoria | Referencia | Tipo de interactividad (si aplica) | URL código base (si aplica) |
|---------|-----------|------------|------------------------------------|-----------------------------|
| Missing Corner Cube | Geométrica |https://michaelbach.de/ot/sze-missCornerCube/index.html| No aplica | No aplica  |
| Curved Herman Grid | Luminancia y contraste | https://michaelbach.de/ot/lum-herGridCurved/index.html | Al dar click curvan las líneas | No aplica |
| Frisén's Lazy Shadow | Luminancia y contraste | https://michaelbach.de/ot/lum-lazyShadow/index.html | Al dar click aparece un círculo con fondo | https://processing.org/examples/regularpolygon.html |
| Stereokinetic Effect | Movimiento y tiempo | https://michaelbach.de/ot/mot-ske/index.html | No aplica | https://gist.github.com/atduskgreg/1516424 |
| Poggendorff Illusion | Geométrica | https://michaelbach.de/ot/ang-poggendorff/index.html | El tamaño de los rectangulos obstructores depende del mouse | No aplica |
| Müller-Lyer Illusion | Geométrica Tamaños | https://michaelbach.de/ot/sze-muelue/index.html | Mouse para testear precision  | No Aplica |

2. Para completar este taller nos basamos principalmente en el indice de ilusiones de Michael Bach, material muy relevante por sus demostraciones interactivas y sus explicaciones a profundidad.

    Nos gustaria profundizar con respecto al modelado en 3 dimensiones y la iluminacion, pues la primera ilusion de nuestra lista fue muy interesante de construir.


    ### Missing Corner Cube
    
    Esta ilusion puede inmediatamente verse como un cubo con una esquina faltante. Sin embargo, tambien es posible ver dos interpretaciones alternativas: un cubo con un cubo mas pequeño como protuberancia en una de las esquinas, y una sala con un cubo en una de las esquinas.
    
    Esta ilusion es producto de la falta de pistas de iluminacion, combinado con una geometria especifica. La ilusion funciona con una perspectiva normal, pero es mas clara con la perspectiva usada actualmente: una perspectiva ortogonal. 
    
    ### Curved Herman Grid
    Esta ilusión se basa en la ilusión de Herman Grid la cual indica que, al ver una rejilla de lineas blancas y cuadrados negros nuestros ojos hacen una suma de los colores en los puntos de intersección, apróximando un circulo negro. El  cual al ver fijamente la intersección desparece.

    Por otra parte, cuando curvamos las líneas nuestros ojos dejan de hacer esa "suma de colores" ya que las intersecciones no son de angulo recto.

    ### Frisén's Lazy Shadow
    En la ilusión se pueden ver dos cosas: La primera vemos una sombra en el triangulo interno (blanco) y la segunda vemos los triangulos desfasados ya que nuestro sistema visual relaciona la velocidad con la luminancia, "entre más brille, más rápido".

    Al dar click y tener un fondo más luminico estático, nos damos cuenta que no existe ni sombra y que las figueras están alineadas en su movimiento.

    ### Stereokinetic Effect
    La ilusión se basa en kinetic depth effect (KDE). KDE se refiere al fenomeno en el cual creamos una estructura tridimensional cuando un objeto en dos dimensiones se mueve. La creación de esta estructura tridimensional es causada por las diferencias que se van dando en la imagen bidimensional al ser rotada. Este efecto fue demostrado en 1950 por Wallach y O'Connell.

    ### Poggendorff Illusion
    La ilusión de Poggendorff fue descubierta en 1860 por el fisico JC Poggendorff. En esta ilusion, una linea continua diagonal que pasa tras un rectangulo vertical obstructor parece discontinua. En nuestra implementación, multiples lineas diagonales paralelas pasan detras de multiples rectangulos verticales de tamaño variable. 
    
    ### Müller-Lyer Illusion
    La ilusión de Müller-Lyer consiste en una linea horizontal con dos puntos de flecha, una en cada extremo. La idea consiste en comprobar nuestra precision en medicion de distancias y tamaños, y como esta precision puede ser manipulada. Las puntas de flecha alrededor de la linea causan esta imprecision, pues nuestro cerebro interpreta flechas entrantes como objetos mas lejanos, y flechas salientes como objetos mas cercanos, generando una perspectiva ilusoria.
    
## Entrega

* Hacer [fork](https://help.github.com/articles/fork-a-repo/) de la plantilla. Plazo: 12/5/19 a las 24h.
* (todos los integrantes) Presentar el trabajo presencialmente en la siguiente sesión de taller.
