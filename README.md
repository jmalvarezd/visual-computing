# Taller de análisis de imágenes por software

## Propósito

Introducir el análisis de imágenes/video en el lenguaje de [Processing](https://processing.org/), mediante el desarrollo de tareas basicas en transformacion de imagenes y videos.

## Tareas

Implementar las siguientes operaciones de análisis para imágenes/video:

* Conversión a escala de grises.
* Aplicación de algunas [máscaras de convolución](https://en.wikipedia.org/wiki/Kernel_(image_processing)).
* (solo para imágenes) Despliegue del histograma.
* (solo para imágenes) Segmentación de la imagen a partir del histograma.
* (solo para video) Medición de la [eficiencia computacional](https://processing.org/reference/frameRate.html) para las operaciones realizadas.

Emplear dos [canvas](https://processing.org/reference/PGraphics.html), uno para desplegar la imagen/video original y el otro para el resultado del análisis.

## Integrantes

Complete la tabla:

| Integrante | github nick |
|------------|-------------|
| Nicolas Campuzano Angulo | ncampuzano |
| Juan Manuel Alvarez | jmalvarezd |

## Discusión

Al ejecutar la aplicacion en processing, esta automaticamente carga el archivo data/leopard.jpg como imagen base para manipulacion.

Usando los botones de la parte inferior de la aplicacion, o los atajos de teclado (ctrl+h, ctrl+1, ctrl+4), ctrl+g, etc), podemos aplicar las diferentes mascaras de convolucion, poner un filtro gris, o mostrar un histograma del brillo de los pixeles de la imagen. Tambien podemos pasar al modo pelicula.

### Modo Pelicula

Al entrar al modo pelicula, el programa automaticamente carga y reproduce data/landscape.mp4. Esto puede tomar algunos segundos la primera vez que se carga el archivo. Durante la reproduccion de la pelicula, podemos aplicar cualquiera de las mascaras de convolucion, el filtro blanco y negro, o regresar al modo imagen.

### Mascaras de Convolucion

El programa ofrece 6 mascaras de convolucion diferentes para la manipulacion de la imagen o el video que se este mostrando. 

### Modo gris

Mediante el calculo del brillo de cada pixel del archivo original, podemos transformarle en una imagen en tonos de grises.

### Modo Histograma

Se muestra un histograma del brillo de cada pixel. Arrastrando el mouse desde una barra inicial hasta una barra final del histograma modificara la imagen, mostrando en su color original todos los pixeles cuyo brillo esten dentro del rango seleccionado, y transformando en verde brillante todos los demas pixeles.

(Unicamente disponible en modo imagen)

## Entrega

* Hacer [fork](https://help.github.com/articles/fork-a-repo/) de la plantilla. Plazo: 28/4/19 a las 24h.
* (todos los integrantes) Presentar el trabajo presencialmente en la siguiente sesión de taller.
