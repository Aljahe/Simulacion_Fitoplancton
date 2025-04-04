# Simulación de datos ecológicos para el Lago Eutrós
# Autor: [Álvaro Jaimes, Carolina Maldonado y Maria Paula]
# Descripción: Este script genera un conjunto de datos simulados sobre la dinámica del fitoplancton en un lago eutrofizado.
# Fecha: Abril de 2025

# --- 1. Cargar paquetes necesarios ---
library(dplyr)

# --- 2. Definir los componentes del diseño de muestreo ---
anios <- 2024
estaciones <- c("Invierno", "Primavera", "Verano", "Otoño")
sectores <- c("A", "B", "C")
puntos <- 1:3
profundidades <- c("Superficie", "Media", "Fondo")

# --- 3. Definir rangos de valores por estación y sector ---
get_valor <- function(rango) runif(1, min = rango[1], max = rango[2])

rangos <- list(
  Temperatura = list(
    Invierno = c(2, 6), Primavera = c(8, 14),
    Verano = c(18, 26), Otoño = c(10, 16)
  ),
  Oxigeno = c(4, 12),
  Fosfatos = list(A = c(0.3, 1.2), B = c(0.1, 0.4), C = c(0.01, 0.1)),
  Nitratos = list(A = c(1.0, 3.5), B = c(0.5, 1.5), C = c(0.1, 0.5)),
  Clorofila = list(A = c(30, 80), B = c(10, 30), C = c(2, 10)),
  Fitoplancton = list(A = c(50000, 120000), B = c(20000, 50000), C = c(5000, 20000)),
  Zooplancton = c(20, 150)
)

# --- 4. Generar datos simulados ---

set.seed(123)  # Para asegurar reproducibilidad

datos <- expand.grid(
  Año = anios,
  Estación = estaciones,
  Sector = sectores,
  Punto = puntos,
  Profundidad = profundidades
) %>%
  rowwise() %>%
  mutate(
    `Temperatura (°C)` = round(runif(1, rangos$Temperatura[[Estación]][1], rangos$Temperatura[[Estación]][2]), 1),
    `O2 disuelto (mg/L)` = round(runif(1, rangos$Oxigeno[1], rangos$Oxigeno[2]), 2),
    `Fosfatos (mg/L)` = round(runif(1, rangos$Fosfatos[[Sector]][1], rangos$Fosfatos[[Sector]][2]), 3),
    `Nitratos (mg/L)` = round(runif(1, rangos$Nitratos[[Sector]][1], rangos$Nitratos[[Sector]][2]), 3),
    `Clorofila-a (µg/L)` = round(runif(1, rangos$Clorofila[[Sector]][1], rangos$Clorofila[[Sector]][2]), 2),
    `Fitoplancton (cél/mL)` = round(runif(1, rangos$Fitoplancton[[Sector]][1], rangos$Fitoplancton[[Sector]][2])),
    `Zooplancton (org/L)` = round(runif(1, rangos$Zooplancton[1], rangos$Zooplancton[2]))
  ) %>%
  ungroup()

# --- 5. Visualizar los primeros registros ---#
head(datos)

# --- 6. Análisis descriptivos ---#

library(psych)
describe(datos[, 6:12])  # Estadísticos básicos de las variables cuantitativas

# --- 7. Visualización exploratoria ---#

library(ggplot2)

# Histograma de fitoplancton
ggplot(datos, aes(x = `Fitoplancton (cél/mL)`)) +
  geom_histogram(fill = "skyblue", color = "black") +
  labs(title = "Distribución del fitoplancton", x = "Células/mL", y = "Frecuencia")

# Boxplot por estación
ggplot(datos, aes(x = Estación, y = `Fitoplancton (cél/mL)`, fill = Estación)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Fitoplancton por estación", y = "Células/mL")

# --- 8. Análisis de correlación y regresión ---#

# Correlación de Spearman
cor.test(datos$`Fitoplancton (cél/mL)`, datos$`Temperatura (°C)`, method = "spearman")

# Regresión lineal
modelo <- lm(`Fitoplancton (cél/mL)` ~ `Temperatura (°C)`, data = datos)
summary(modelo)

# --- 9. Análisis de varianza (ANOVA) ---#

anova <- aov(`Fitoplancton (cél/mL)` ~ Estación, data = datos)
summary(anova)

# --- 9. Análisis de componenten principales (PCA) ---#

library(FactoMineR)
library(factoextra)

library(FactoMineR)
library(factoextra)

# Paso 1: Seleccionar solo variables numéricas
variables_numericas <- datos[, c("Temperatura (°C)", "O2 disuelto (mg/L)", "Fosfatos (mg/L)",
                                 "Nitratos (mg/L)", "Clorofila-a (µg/L)", 
                                 "Fitoplancton (cél/mL)", "Zooplancton (org/L)")]

# Paso 2: Realizar PCA
res.pca <- PCA(variables_numericas, scale.unit = TRUE, graph = FALSE)

# Paso 3: Graficar con elipsoides por estación
fviz_pca_ind(res.pca,
             habillage = datos$Estación,       # Agrupar por estación
             addEllipses = TRUE,               # Agregar elipsoides
             ellipse.level = 0.95,             # Nivel de confianza
             palette = "Dark2",
             repel = TRUE,
             title = "PCA: Variables ambientales y biológicas\nAgrupadas por estación")


# --- 10. Exportar resultados a tabals ---#

# Exportar datos a CSV
write.csv(datos, "datos_simulados_fitoplancton.csv", row.names = FALSE)

# Exportar resumen del modelo
capture.output(summary(modelo), file = "resumen_regresion.txt")
capture.output(summary(anova), file = "resumen_anova.txt")


