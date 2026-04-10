# data_prep.R
# Carga, limpieza y preparación del dataset Credit Card Fraud
# Centraliza toda la lógica de datos

library(dplyr)
library(readr)

# ── CARGA ─────────────────────────────────────────────────────────────────────
data_path <- "data/creditcard.csv"

if (!file.exists(data_path)) {
  # Ruta alternativa (escritorio del usuario)
  alt_path <- "C:/Users/User/OneDrive/Escritorio/dataviz_python/data/creditcard.csv"
  if (file.exists(alt_path)) {
    file.copy(alt_path, data_path)
  } else {
    stop("No se encontró el archivo creditcard.csv. 
         Colócalo en la carpeta 'data/' del proyecto.")
  }
}

df_raw <- read_csv(data_path, show_col_types = FALSE)

# ── LIMPIEZA ──────────────────────────────────────────────────────────────────

# 1. Eliminar duplicados
n_antes <- nrow(df_raw)
df_clean <- df_raw %>% distinct()
n_despues <- nrow(df_clean)
n_duplicados <- n_antes - n_despues

# 2. Crear variable Hour a partir de Time
df_clean <- df_clean %>%
  mutate(
    Hour = floor((Time %% 86400) / 3600),  # Hora del día (0-23)
    Class_label = ifelse(Class == 1, "Fraude", "No Fraude"),
    Class_label = factor(Class_label, levels = c("No Fraude", "Fraude"))
  )

# 3. Verificar valores faltantes
missing_summary <- df_clean %>%
  summarise(across(everything(), ~sum(is.na(.)))) %>%
  tidyr::pivot_longer(everything(), names_to = "Variable", values_to = "Missing") %>%
  mutate(Porcentaje = round(Missing / nrow(df_clean) * 100, 4))

# ── SUBSETS ───────────────────────────────────────────────────────────────────
df_fraud    <- df_clean %>% filter(Class == 1)
df_no_fraud <- df_clean %>% filter(Class == 0)

# ── ESTADÍSTICAS GLOBALES ─────────────────────────────────────────────────────
stats_global <- list(
  total_transacciones  = nrow(df_clean),
  n_fraude             = sum(df_clean$Class == 1),
  n_no_fraude          = sum(df_clean$Class == 0),
  pct_fraude           = round(mean(df_clean$Class == 1) * 100, 4),
  n_duplicados         = n_duplicados,
  n_variables          = ncol(df_clean) - 3,  # excluye Hour, Class_label
  amount_median_fraud  = median(df_fraud$Amount),
  amount_median_normal = median(df_no_fraud$Amount)
)

# ── FUNCIÓN RESUMEN ESTADÍSTICO ───────────────────────────────────────────────
resumen_var <- function(variable) {
  list(
    mean   = mean(variable, na.rm = TRUE),
    sd     = sd(variable, na.rm = TRUE),
    median = median(variable, na.rm = TRUE),
    IQR    = IQR(variable, na.rm = TRUE),
    min    = min(variable, na.rm = TRUE),
    max    = max(variable, na.rm = TRUE),
    Q1     = quantile(variable, 0.25, na.rm = TRUE),
    Q3     = quantile(variable, 0.75, na.rm = TRUE)
  )
}

X <- df_clean %>% select(V1:V28, Amount, Time)

# ── Cálculos estáticos (se ejecutan UNA sola vez) ──


vif_values <- sapply(colnames(X), obtener_vif, datos = X)

vif_data <- data.frame(
  Variable = names(vif_values),
  VIF      = vif_values
)

# Y calculas los datos igual que VIF
rbc_values <- sapply(colnames(X), obtener_rbc)

rbc_data <- data.frame(
  Variable = names(rbc_values),
  RBC      = rbc_values
)

tiempo <- df_clean %>%
  group_by(Hour, Class) %>%
  summarise(Mediana_Amount = median(Amount, na.rm = TRUE),
            .groups = "drop") %>%
  mutate(Tipo = ifelse(Class == 0, "No Fraude", "Fraude"))  # ← F mayúscula


No_Fraude <- df_clean[which(df_clean$Class == 0), ]
densidad1 <- density(No_Fraude$Time)

Fraude <- df_clean[which(df_clean$Class == 1), ]
densidad2 <- density(Fraude$Time)


message(sprintf(
  "✔ Dataset cargado: %d transacciones | %d fraude (%.2f%%) | %d duplicados eliminados",
  stats_global$total_transacciones,
  stats_global$n_fraude,
  stats_global$pct_fraude,
  stats_global$n_duplicados
))