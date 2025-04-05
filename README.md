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

Los datos obtenidos fueron sometidos a un análisis exploratorio mediante estadísticos descriptivos de tendencia central. 

Para evaluar la significancia de la variación temporal de la biomasa de fitoplancton se realizó un análisis de varianza (ANOVA). Las relaciones entre la biomasa y los nutrientes (fosfatos y nitratos), así como con la temperatura, se exploraron mediante correlaciones no paramétricas de Spearman y análisis de regresión lineal simple.

Adicionalmente, se aplicó un análisis de componentes principales (ACP) con el fin de detectar patrones de organización de las variables de producción, condiciones climáticas y parámetros fisicoquímicos. Todos los análisis se realizaron en R. Por  último se realizó un análisis de clusters por grupos. 

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

# Análisis de la dinámica del fitoplancton en un lago eutrofizado

Este repositorio contiene el análisis de una base de datos simulada que evalúa cómo varía la biomasa del fitoplancton en función de la disponibilidad de nutrientes (fosfatos y nitratos), la temperatura y otros parámetros fisicoquímicos. Este estudio tiene como propósito simular un caso de eutrofización y evaluar relaciones que puedan orientar estrategias de manejo ecológico.

---

## Contenido del repositorio

- `script_fitoplancton.R`: script principal con análisis y visualización.
- `datos_lago.csv`: base de datos simulada.
- `analisis_regresion_fosfatos_fitoplancton.csv`: tabla resumen de regresión.

---

## Requisitos

Este análisis se ejecuta en R. Asegúrate de tener instalados los siguientes paquetes:

```r
install.packages(c("tidyverse", "psych"))
```

---

## Pasos del análisis

### 1. Carga de datos

Se cargan los datos desde un archivo `.csv` que contiene medidas simuladas de temperatura, oxígeno disuelto, nutrientes, clorofila-a, zooplancton y fitoplancton en diferentes estaciones del año.

### 2. Análisis Descriptivo

Se realizaron análisis descriptivos y visualizaciones para comprender la distribución y variabilidad de las variables físico-químicas y biológicas.

#### Estadísticos Descriptivos

Se usó la función `describe()` del paquete `psych` para calcular medidas de tendencia central, dispersión y forma (media, mediana, desviación estándar, curtosis, etc.) de las variables numéricas.

#### Visualización Exploratoria

Se generaron histogramas y diagramas de caja (boxplots) para analizar la distribución del fitoplancton y su variación estacional:

- Histograma de la biomasa de fitoplancton.
- Boxplot por estación del año.

### 3. Análisis de Correlación y Regresión

Se exploraron relaciones entre la biomasa de fitoplancton y otras variables mediante:

- **Correlación de Spearman** para evaluar asociaciones no paramétricas.
- **Regresión lineal simple** entre fitoplancton y fosfatos.

### 4. Análisis descriptivo

Se realiza un resumen estadístico de las variables cuantitativas utilizando la función `describe()` del paquete `psych`. Esto permite observar promedios, desviaciones estándar, mínimos, máximos, entre otros indicadores básicos de las variables físicas, químicas y biológicas.

### 5. Visualización exploratoria

Se emplean histogramas y diagramas de caja (boxplots) para explorar la distribución de la biomasa fitoplanctónica en el lago, incluyendo su variación por estación del año.

### 6. Análisis de correlación y regresión

Se evalúan correlaciones de Spearman entre fitoplancton y variables ambientales (temperatura, oxígeno disuelto, fosfatos, nitratos, clorofila-a, zooplancton). Posteriormente, se construye un modelo lineal para explorar la relación entre la concentración de fosfatos y la abundancia de fitoplancton, incluyendo visualización gráfica y exportación de los resultados a un archivo CSV.

### 7. Análisis de varianza (ANOVA)

Se aplicó un análisis de varianza de una vía (ANOVA) para evaluar si existen diferencias significativas en la biomasa del fitoplancton entre estaciones del año. Este análisis permite identificar patrones estacionales en la producción biológica del lago.

**Código clave:**
```r
anova <- aov(`Fitoplancton (cél/mL)` ~ Estación, data = datos)
summary(anova)
```

**Interpretación esperada:**  
Un valor de *p* < 0.05 indicaría que al menos una estación presenta diferencias significativas en comparación con las otras, en términos de biomasa fitoplanctónica.

### 8. Análisis de Componentes Principales (PCA)

Se realizó un Análisis de Componentes Principales (PCA) para reducir la dimensionalidad del conjunto de variables ambientales y biológicas, y visualizar patrones de agrupamiento por estación.

**Variables utilizadas:**  
Temperatura, oxígeno disuelto, fosfatos, nitratos, clorofila-a, fitoplancton y zooplancton.

**Pasos del análisis:**
1. Selección de variables numéricas.
2. Estandarización (opcional, se usó `scale.unit = TRUE`).
3. Cálculo de componentes principales.
4. Visualización con elipsoides de agrupamiento por estación.

**Código clave:**
```r
res.pca <- PCA(variables_numericas, scale.unit = TRUE, graph = FALSE)
fviz_pca_ind(res.pca, habillage = datos$Estación, addEllipses = TRUE)
```

**Interpretación esperada:**  
El gráfico PCA permite observar si los grupos estacionales presentan patrones diferenciados en el espacio multivariado. Las variables con mayor contribución a los componentes principales pueden interpretarse como las más influyentes en la dinámica del ecosistema.

---

Puedes ejecutar cada bloque de código directamente desde el script `.R`, asegurándote de tener cargadas las librerías necesarias (`psych`, `ggplot2`, `FactoMineR`, `factoextra`).

### 9. Análisis de Componentes Principales (PCA)

Se realizó un Análisis de Componentes Principales (PCA) para reducir la dimensionalidad del conjunto de variables ambientales y biológicas, y visualizar patrones de agrupamiento por estación.

Variables utilizadas:Temperatura, oxígeno disuelto, fosfatos, nitratos, clorofila-a, fitoplancton y zooplancton.

Pasos del análisis:

Selección de variables numéricas.

Estandarización (opcional, se usó scale.unit = TRUE).

Cálculo de componentes principales.

Visualización con elipsoides de agrupamiento por estación.

Código clave:

res.pca <- PCA(variables_numericas, scale.unit = TRUE, graph = FALSE)
fviz_pca_ind(res.pca, habillage = datos$Estación, addEllipses = TRUE)

Interpretación esperada:El gráfico PCA permite observar si los grupos estacionales presentan patrones diferenciados en el espacio multivariado. Las variables con mayor contribución a los componentes principales pueden interpretarse como las más influyentes en la dinámica del ecosistema.

### 10. Análisis de Conglomerados (Clustering jerárquico y k-means)

Se empleó un enfoque de agrupamiento para identificar patrones ocultos entre las observaciones, basándose en variables físico-químicas y biológicas.

Pasos principales:

Selección de variables numéricas.

Estandarización de los datos.

Aplicación de k-means con 3 centros.

Visualización del agrupamiento en el espacio PCA.

Cálculo de estadísticas promedio por grupo.

Asignación de nombres descriptivos a los grupos.

Grupos identificados:

Grupo 1: Mesotrófico productivo

Grupo 2: Oligotrófico frío

Grupo 3: Oligotrófico cálido

Visualización del clustering:

fviz_cluster(list(data = vars_scaled, cluster = grupos),
             palette = "Dark2",
             geom = "point",
             ellipse.type = "convex")

Interpretación esperada:Los grupos reflejan diferencias en el estado trófico y condiciones ambientales del lago, proporcionando una herramienta útil para la caracterización del ecosistema.

### 11. Exportación de resultados

Se exportaron los resultados más relevantes del análisis, incluyendo:

Tabla de datos simulados (datos_simulados_fitoplancton.csv)

Resultados de regresión lineal (resumen_regresion.txt)

Resultados del ANOVA (resumen_anova.txt)

Resumen de los clusters (resumen_clusters.csv)

Puedes ejecutar cada bloque de código directamente desde el script .R, asegurándote de tener cargadas las librerías necesarias (psych, ggplot2, FactoMineR, factoextra, dplyr).


## Contacto
Para dudas o sugerencias, puedes escribir a [Aljahe].

