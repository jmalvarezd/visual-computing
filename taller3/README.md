# Taller raster

## Propósito

Comprender algunos aspectos fundamentales del paradigma de rasterización.

## Tareas

Emplee coordenadas baricéntricas para:

1. Rasterizar un triángulo.
2. Sombrear su superficie a partir de los colores de sus vértices.
3. (opcional para grupos menores de dos) Implementar un [algoritmo de anti-aliasing](https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-practical-implementation) para sus aristas.

Referencias:

* [The barycentric conspiracy](https://fgiesen.wordpress.com/2013/02/06/the-barycentric-conspirac/)
* [Rasterization stage](https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-stage)

Implemente la función ```triangleRaster()``` del sketch adjunto para tal efecto, requiere la librería [nub](https://github.com/nakednous/nub/releases).

## Integrantes

Complete la tabla:

| Integrante | github nick |
|------------|-------------|
| Nicolas Campuzano Angulo | ncampuzano |
| Juan Manuel Alvarez | jmalvarezd |

## Discusión

### Rasterizar Un Triangulo

Las coordenadas baricéntricas son un elemento matemático que nos posibilita conocer el lado en el que se encuentra un punto especifico dada una línea (dos puntos), esto es importante ya que al realizar la verificación por los tres puntos de un triángulo podemos conocer si el punto está dentro o fuera del triángulo. Conociendo la posición del punto podemos hacer rasterización de un triángulo de manera adecuada. En nuestra implementacion, esto se realiza mediante el calculo de determinantes, en las funciones `pointLeftOfVertex()` y `isPointInsideTriangle()`, Asegurándonos que nuestro tiangulo sea construido en sentido contrario a las manecillas del reloj.

### Sombrear Su Superficie Con Color

Por otro lado, dado un triángulo y un punto, podemos obtener el área que forma este punto con cada combinación de par de vértices, el área es dada por el determinante de los tres puntos en cuestión. Cuando un área es negativa significa que el punto no está dentro del triángulo mientras que cuando un área es positiva podemos determinar su peso o incidencia en comparación con el área del triángulo dado. Esto es importante ya que al conocer su peso específico podemos darle un valor ponderado de alguna característica (el color, por ejemplo). Nosotros tomamos un pixel `P` dentro del triangulo `ABC` y, para cada borde (`AB`, `BC`, `CA`) hallamos el area del triangulo correspondiente (Triangulos `ABP`, `BCP`, `CAP`). La razon entre el area de cada uno de estos triangulos y el triangulo `ABC` nos da el aporte en coordenadas baricentricas de cada uno de los vertices.

### Anti Aliasing

Por último, la técnica utilizada para hacer anti-aliasing fue tomar cada pixel y subdividirlo en cuadrados más pequeños, verificar cada cuadrado si está dentro o fuera de triángulo con las coordenadas baricéntricas y multiplicamos la razón de cuadrados adentro del triángulo sobre cuadrados totales por el color Alpha, haciendo que los pixeles muy cercanos al borde se vean más “suaves”.

Referencias: https://www.kotaku.com.au/2011/12/what-is-fxaa/ 

https://fgiesen.wordpress.com/2013/02/06/the-barycentric-conspirac/

https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-stage


## Entrega

* Plazo: ~~2/6/19~~ 4/6/19 a las 24h.
