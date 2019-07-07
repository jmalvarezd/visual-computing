# Taller de shaders

## Propósito

Estudiar los [patrones de diseño de shaders](http://visualcomputing.github.io/Shaders/#/4).

## Tarea

1. Hacer un _benchmark_ entre la implementación por software y la de shaders de varias máscaras de convolución aplicadas a imágenes y video.
2. Implementar un modelo de iluminación que combine luz ambiental con varias fuentes puntuales de luz especular y difusa. Tener presente _factores de atenuación_ para las fuentes de iluminación puntuales.
3. (grupos de dos o más) Implementar el [bump mapping](https://en.wikipedia.org/wiki/Bump_mapping).

## Integrantes

Complete la tabla:

| Integrante | github nick |
|------------|-------------|
| Nicolas Campuzano Angulo | ncampuzano |
| Juan Manuel Alvarez | jmalvarezd |

## Informe

1. La realización del benchmark está situada en el proyecto **Benchmark**. Con los botones podemos hacer la interacción y la aplicación de las máscaras en cada escenario. Para el benchmark de imagen podemos ver la diferencia del `frameRate` al cambiar entre hadware y software. Por otro lado, para hacer el benchmark del vídeo se debe primero presionar el botón del vídeo y luego de una de las máscaras, esto hará que se haga una primera reproducción aplicando la máscara de convolución en software y luego otra en hadware. Al final, se mostrarán los resultados de cada uno de ellos. **Nota** La eficiencia computacional se ve bastante afectada si no se hace un _resize_ de la imagen antes de la aplicación de la máscara de convolución. Igualmente, cabe anotar que la diferencia en una máscara de 5x5 es bastante notoria.

2. 


## Entrega

Fecha límite ~~Lunes 1/7/19~~ Domingo 7/7/19 a las 24h. Sustentaciones: 10/7/19 y 11/7/19.
