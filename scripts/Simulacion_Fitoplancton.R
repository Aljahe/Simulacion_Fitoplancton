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

# Seleccionar columnas numéricas para análisis
vars_cor <- datos[, c("Temperatura (°C)", 
                      "O2 disuelto (mg/L)", 
                      "Fosfatos (mg/L)", 
                      "Nitratos (mg/L)", 
                      "Clorofila-a (µg/L)", 
                      "Zooplancton (org/L)", 
                      "Fitoplancton (cél/mL)")]

# Función para calcular rho y p-valor
spearman_results <- lapply(vars_cor[, -which(names(vars_cor) == "Fitoplancton (cél/mL)")], function(x) {
  test <- cor.test(x, vars_cor$`Fitoplancton (cél/mL)`, method = "spearman")
  c(rho = round(test$estimate, 4), p_value = round(test$p.value, 4))
})

# Convertir resultados en data.frame
df_cor <- do.call(rbind, spearman_results)
df_cor <- data.frame(Variable = rownames(df_cor), df_cor, row.names = NULL)

# Ver resultados
print(df_cor)


# Cargar librerías
library(ggplot2)

# Nuevo modelo con fosfatos
modelo2 <- lm(`Fitoplancton (cél/mL)` ~ `Fosfatos (mg/L)`, data = datos)

summary(modelo2)

# Gráfica correspondiente

ggplot(datos, aes(x = `Fosfatos (mg/L)`, y = `Fitoplancton (cél/mL)`)) +
  geom_point(color = "#1f77b4", size = 2, alpha = 0.7) +
  geom_smooth(method = "lm", color = "#d62728", se = TRUE, fill = "#ff9896") +
  labs(
    title = "Relación entre Fosfatos y Fitoplancton",
    x = "Fosfatos (mg/L)",
    y = "Fitoplancton (cél/mL)"
  ) +
  theme_minimal(base_size = 14)

# Crear un data frame con los resultados del modelo
resultado <- data.frame(
  Estadístico = c("Intercepto (α)", "Pendiente (β)", "R² (Coef. de determinación)", "Valor p", "Interpretación"),
  Valor = c(102.7, 1225.4, 0.68, "< 0.001", "Incremento significativo de fitoplancton con aumento de fosfatos")
)

# Guardar como CSV
write.csv(resultado, "analisis_regresion_fosfatos_fitoplancton.csv", row.names = FALSE)

# --- 9. Análisis de varianza (ANOVA) ---#

anova <- aov(`Fitoplancton (cél/mL)` ~ Estación, data = datos)
summary(anova)

# --- 9. Análisis de componenten principales (PCA) ---#

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

# Ver proporción de varianza explicada
summary(res.pca)

res.pca$var$coord


# --- 10. Análisis de conglomerados jerárquico (clustering jerárquico) ---#

# Preparar los datos númericos

# Seleccionamos solo las variables numéricas relevantes
vars_cluster <- datos %>%
  dplyr::select(
    `Temperatura (°C)`,
    `O2 disuelto (mg/L)`,
    `Fosfatos (mg/L)`,
    `Nitratos (mg/L)`,
    `Clorofila-a (µg/L)`,
    `Fitoplancton (cél/mL)`,
    `Zooplancton (org/L)`
  )

# Estandarizamos los datos (media = 0, sd = 1)
vars_scaled <- scale(vars_cluster)

# Crear los grupos usando k-means

set.seed(123)  # Para reproducibilidad
kmeans_result <- kmeans(vars_scaled, centers = 3, nstart = 25)

# 3. Guardar los grupos
grupos <- kmeans_result$cluster

# Visualizar clusters en un plano PCA

library(factoextra)

fviz_cluster(list(data = vars_scaled, cluster = grupos),
             palette = "Dark2", 
             geom = "point",
             ellipse.type = "convex",
             ggtheme = theme_minimal())


datos_cluster <- datos %>%
  mutate(Grupo_Cluster = grupos)

resumen_clusters <- datos_cluster %>%
  group_by(Grupo_Cluster) %>%
  summarise(across(where(is.numeric), mean, na.rm = TRUE))

print(resumen_clusters)

library(dplyr)

resumen_completo <- datos_cluster %>%
  group_by(Grupo_Cluster) %>%
  summarise(
    Temperatura = mean(`Temperatura (°C)`, na.rm = TRUE),
    O2_disuelo = mean(`O2 disuelto (mg/L)`, na.rm = TRUE),
    Fosfatos = mean(`Fosfatos (mg/L)`, na.rm = TRUE),
    Nitratos = mean(`Nitratos (mg/L)`, na.rm = TRUE),
    Clorofila = mean(`Clorofila-a (µg/L)`, na.rm = TRUE),
    Fitoplancton = mean(`Fitoplancton (cél/mL)`, na.rm = TRUE),
    Zooplancton = mean(`Zooplancton (org/L)`, na.rm = TRUE)
  )

# Crear vector con los nombres descriptivos
nombres_clusters <- c(
  "Mesotrófico productivo",
  "Oligotrófico frío",
  "Oligotrófico cálido"
)

# Asignar nombres según el número de cluster
resumen_clusters$Nombre_Cluster <- dplyr::case_when(
  resumen_clusters$Grupo_Cluster == 1 ~ nombres_clusters[1],
  resumen_clusters$Grupo_Cluster == 2 ~ nombres_clusters[2],
  resumen_clusters$Grupo_Cluster == 3 ~ nombres_clusters[3]
)

# Reordenar columnas para que el nombre aparezca junto al número del cluster
resumen_final <- resumen_clusters %>%
  dplyr::select(Grupo_Cluster, Nombre_Cluster, everything())

# Mostrar tabla final
print(resumen_final)

# Exportar tabla como archivo CSV
write.csv(resumen_final, "resumen_clusters.csv", row.names = FALSE)

# --- 11. Exportar resultados a tabals ---#

# Exportar datos a CSV
write.csv(datos, "datos_simulados_fitoplancton.csv", row.names = FALSE)

# Exportar resumen del modelo
capture.output(summary(modelo2), file = "resumen_regresion.txt")
capture.output(summary(anova), file = "resumen_anova.txt")


