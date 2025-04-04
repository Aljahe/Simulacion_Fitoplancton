# Simulación de Datos Ecológicos - Lago Eutrós

## Descripción
Este repositorio contiene un script en R que genera un conjunto de datos simulados sobre la dinámica del fitoplancton en un lago eutrofizado. Se basa en un diseño de muestreo que contempla variaciones estacionales y espaciales en parámetros físico-químicos y biológicos del lago.

## Estructura del Repositorio
- `simulacion_fitoplancton.R`: Script en R con la generación de datos simulados.
- `README.md`: Este archivo con información del proyecto.
- (Opcional) `Simulacion_Fitoplancton_Lago_Eutros_2024.xlsx`: Archivo Excel con los datos generados.

## Metodología

### Zona de Estudio
El estudio simula el Lago Eutrós, un lago eutrofizado en una región templada (45°N, 80°O). Se asume un clima templado húmedo (Köppen: Cfb), con un área de 12 km² y profundidades entre 6 y 18 metros.

### Diseño de Muestreo
Se establecen tres sectores con distintos niveles de impacto:
- **Sector A**: Influencia agrícola (altos nutrientes)
- **Sector B**: Descargas domésticas moderadas
- **Sector C**: Bosque ripario (menor impacto)

Cada sector se muestrea en tres profundidades (superficie, media y fondo) y en tres puntos por sector, en cada estación del año (invierno, primavera, verano, otoño), sumando 36 puntos de muestreo.

### Parámetros Medidos
| Parámetro            | Método / Instrumento |
|----------------------|---------------------|
| Temperatura (°C)    | Sonda multiparamétrica (YSI ProDSS) |
| Oxígeno disuelto (mg/L) | Sensor óptico (YSI ProODO) |
| Fosfatos (mg/L)     | Espectrofotómetro (Hach DR6000) |
| Nitratos (mg/L)     | Reducción de cadmio (Hach DR6000) |
| Clorofila-a (µg/L)  | Extracción con acetona + fluorometría (Turner Designs TD-700) |
| Fitoplancton (cél/mL) | Recuento en cámara de Sedgwick-Rafter (microscopía óptica) |
| Zooplancton (org/L) | Filtración en red de 64 µm + estereomicroscopía |

## Uso del Script

### Requisitos
Para ejecutar el script, se requiere tener instalado R y las siguientes librerías:
```r
install.packages("dplyr")
install.packages("writexl") # Opcional para guardar en Excel
```

### Ejecución
Cargar el script en R y ejecutarlo para generar los datos simulados.
Para guardar los datos en un archivo Excel, descomentar la sección correspondiente en el script.

### Visualización de los Datos
Los primeros registros del dataset pueden visualizarse con:
```r
head(datos)
```

## Contacto
Para dudas o sugerencias, puedes escribir a [Aljahe].

