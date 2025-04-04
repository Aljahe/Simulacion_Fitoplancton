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

**36 puntos de muestreo por estación → 144 registros totales**

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
## Exploración y limpieza de datos

Este paso inicial permite inspeccionar la estructura de la base de datos simulada, verificar que todos los datos estén correctamente formateados y detectar posibles valores perdidos que puedan afectar los análisis posteriores.

### Código en R:

```r
# Cargar paquetes
library(tidyverse)

# Ver primeras filas
head(datos)

# Revisar nombres de columnas
colnames(datos)

# Estructura general
str(datos)

# Estadísticas básicas
summary(datos)

# Verificación de valores NA
colSums(is.na(datos))

## Análisis estadísticos

Los datos obtenidos fueron sometidos a un análisis exploratorio mediante estadísticos descriptivos de tendencia central (media aritmética, MA) y de dispersión (desviación estándar, S, y coeficiente de variación relativa de Pearson, CV). 

Para evaluar la significancia de la variación temporal de la biomasa de fitoplancton se realizó un análisis de varianza (ANOVA). Las relaciones entre la biomasa y los nutrientes (fosfatos y nitratos), así como con la temperatura, se exploraron mediante correlaciones no paramétricas de Spearman y análisis de regresión lineal simple.

Adicionalmente, se aplicó un análisis de componentes principales (ACP) con el fin de detectar patrones de organización de las variables de producción, condiciones climáticas y parámetros fisicoquímicos. Todos los análisis se realizaron en R.

## Estructura del Repositorio

- `simulacion_fitoplancton.R`: Script para generar los datos simulados.
- `analisis_estadistico.R`: Script con el análisis exploratorio y multivariado.
- `README.md`: Documento con toda la información del proyecto.
- `figuras/`: Carpeta con los gráficos del análisis.
- `tablas/`: Carpeta con salidas CSV de los resultados estadísticos.

---

## Requisitos

Instala los paquetes necesarios en R:

```r
install.packages(c("dplyr", "ggplot2", "writexl", "psych", "FactoMineR", "factoextra", "readxl"))

## Contacto
Para dudas o sugerencias, puedes escribir a [Aljahe].

