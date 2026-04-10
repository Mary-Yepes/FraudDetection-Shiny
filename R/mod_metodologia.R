metodologiaUI <- function(id) {
  ns <- NS(id)
  
  div(class = "page-fade-in",
      
      div(
        style = "margin-top: 10px; font-size: 14px; color: black; font-weight: bold; border-left: 4px solid #2e86c1; padding-left: 12px; font-size: 20px;",
        p("Metodología")
      ),
      
      div(
        style = "margin-top: 10px; font-size: 15px; color: #6c757d;",
        p("El proyecto se desarrolla bajo un enfoque cuantitativo de alcance descriptivo-correlacional. Tiene las siguientes fases:")
      ),
      
      br(),
      
      layout_columns(
        col_widths = c(6, 6),
        fill = FALSE,
        
        card(
          fill = FALSE, class = "eda-card",
          card_header(
            class = "eda-card-header",
            style = "display:flex; align-items:center; gap:12px;",
            div(style = "font-size:1.6rem; font-weight:800; color:#4a7abf; line-height:1;", "01"),
            div(
              h5("Dataset", class = "card-title-text", style = "margin:0;"),
              p("Fuente de datos", style = "margin:0; font-size:0.75rem; color:#8a9bbf;")
            )
          ),
          card_body(class = "eda-card-body",
                    p("Se utilizó el dataset Credit Card Fraud Detection (Kaggle / ULB Machine Learning Group), que tiene 284.807 transacciones realizadas por titulares de tarjetas de crédito europeos en dos días de septiembre de 2013.")
          )
        ),
        
        card(
          fill = FALSE, class = "eda-card",
          card_header(
            class = "eda-card-header",
            style = "display:flex; align-items:center; gap:12px;",
            div(style = "font-size:1.6rem; font-weight:800; color:#4a7abf; line-height:1;", "02"),
            div(
              h5("Preprocesamiento", class = "card-title-text", style = "margin:0;"),
              p("Limpieza y preparación", style = "margin:0; font-size:0.75rem; color:#8a9bbf;")
            )
          ),
          card_body(class = "eda-card-body",
                    p("Se identificaron y eliminaron 1.081 registros duplicados, quedando 283.726 transacciones únicas. También, se verificó la presencia de valores faltantes (NaN), sin encontrar ninguno. La variable Class fue transformada a string para el EDA y a float64 para el modelado.")
          )
        )
      ),
      
      br(),
      
      layout_columns(
        col_widths = c(6, 6),
        fill = FALSE,
        
        card(
          fill = FALSE, class = "eda-card",
          card_header(
            class = "eda-card-header",
            style = "display:flex; align-items:center; gap:12px;",
            div(style = "font-size:1.6rem; font-weight:800; color:#4a7abf; line-height:1;", "03"),
            div(
              h5("EDA", class = "card-title-text", style = "margin:0;"),
              p("Análisis Exploratorio", style = "margin:0; font-size:0.75rem; color:#8a9bbf;")
            )
          ),
          card_body(class = "eda-card-body",
                    p("Se realizó un análisis univariado y bivariado con estadísticas descriptivas y visualizaciones interactivas. Se incluyen la prueba no paramétrica U de Mann-Whitney, el coeficiente RBC como tamaño de efecto, y un análisis multivariado con matrices de correlación de Spearman y cálculo del VIF.")
          )
        ),
        
        card(
          fill = FALSE, class = "eda-card",
          card_header(
            class = "eda-card-header",
            style = "display:flex; align-items:center; gap:12px;",
            div(style = "font-size:1.6rem; font-weight:800; color:#4a7abf; line-height:1;", "04"),
            div(
              h5("Implementación en Shiny", class = "card-title-text", style = "margin:0;"),
              p("Dashboard interactivo", style = "margin:0; font-size:0.75rem; color:#8a9bbf;")
            )
          ),
          card_body(class = "eda-card-body",
                    p("Los resultados del análisis se integraron en una aplicación Dash modular (Detección de Fraude Financiero) con arquitectura de tabs. En el futuro se planea implementar un modelo de regresión logística para generar un formulario intaractivo.")
          )
        )
      ),
      
      br(),
      
      # ── Flujo del pipeline ──
      card(
        fill = FALSE, class = "eda-card",
        card_header(class = "eda-card-header", h5("Flujo del pipeline", class = "card-title-text")),
        card_body(
          class = "eda-card-body",
          div(
            style = "display:flex; flex-wrap:wrap; align-items:center; gap:8px;",
            
            pipeline_step("Carga del CSV",     "creditcard.csv → R"),
            pipeline_arrow(),
            pipeline_step("Limpieza",          "Eliminación de duplicados"),
            pipeline_arrow(),
            pipeline_step("EDA",               "Univariado → Bivariado → Multivariado"),
            pipeline_arrow(),
            pipeline_step("Entrenamiento",     "GridSearchCV + StratifiedKFold"),
            pipeline_arrow(),
            pipeline_step("Evaluación",        "Precision / Recall / F1 / ROC-AUC"),
            pipeline_arrow(),
            pipeline_step("Predicción",        "Formulario interactivo")
          )
        )
      )
  )
}

metodologiaServer <- function(id) {
  moduleServer(id, function(input, output, session) {})
}

# ── helpers internos ──
pipeline_step <- function(titulo, subtitulo) {
  div(
    style = "background:#1a2540; color:white; border-radius:8px; padding:10px 16px; text-align:center; min-width:140px;",
    div(style = "font-size:0.85rem; font-weight:600;", titulo),
    div(style = "font-size:0.72rem; color:#8a9bbf; margin-top:3px;", subtitulo)
  )
}

pipeline_arrow <- function() {
  div(style = "font-size:1.2rem; color:#4a6fa5; font-weight:bold;", "→")
}