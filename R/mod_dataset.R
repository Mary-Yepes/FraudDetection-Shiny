datasetUI <- function(id) {
  ns <- NS(id)
  
  div(class = "page-fade-in",
      
      div(
        style = "margin-top: 10px; color: black; font-weight: bold; border-left: 4px solid #2e86c1; padding-left: 12px; font-size: 17px;",
        p("Carga del dataset")
      ),
      
      div(
        style = "margin-top: 10px; font-size: 15px; color: #6c757d;",
        p("Estructura general del dataset Credit Card Fraud Detection tras la limpieza y preparación de los datos.")
      ),
      
      br(),
      
      # ── Value cards ──
      layout_columns(
        col_widths = c(3, 3, 3, 3),
        
        value_card("283,726", "FILAS (TRANSACCIONES)",   bg_color = "white", extra_class = "asikurto-card"),
        value_card("31",      "COLUMNAS",                bg_color = "white", extra_class = "asikurto-card"),
        value_card("0",       "VALORES NULOS",           bg_color = "white", extra_class = "asikurto-card"),
        value_card("1,081",   "DUPLICADOS ELIMINADOS",   bg_color = "white", extra_class = "asikurto-card")
      ),
      
      br(),
      
      layout_columns(
        col_widths = c(3, 3, 3, 3),
        
        value_card("30",       "VARIABLES NUMÉRICAS",    bg_color = "white", extra_class = "asikurto-card"),
        value_card("1",        "VARIABLES CATEGÓRICAS",  bg_color = "white", extra_class = "asikurto-card"),
        value_card("0s",       "TIME MÍNIMO",            bg_color = "white", extra_class = "asikurto-card"),
        value_card("172,792s", "TIME MÁXIMO",            bg_color = "white", extra_class = "asikurto-card")
      ),
      
      br(),
      
      # ── Análisis de datos atípicos ──
      card(
        fill = FALSE, class = "eda-card",
        card_header(
          class = "eda-card-header",
          div(style = "display:flex; justify-content:space-between; align-items:center;",
              h5("Análisis de datos atípicos", class = "card-title-text", style = "margin:0;")
          )
        ),
        card_body(class = "eda-card-body",
                  tags$ul(
                    tags$li("Las variables V1–V28 corresponden a componentes principales que se aplicaron por razones de confidencialidad. Teniendo en cuenta que PCA produce variables que ya están normalizadas y centradas, el análisis de outliers clásico no se puede aplicar, pues los valores 'extremos' no son errores, son parte de una transformación matemática, tampoco se pueden interpretar, pues no se saben qué mezcla de variables originales producen los valores.",
                            style = "margin-bottom: 10px;"),
                    tags$li("En cuanto a Time, el rango del dataset va de 0s a 172,792s, lo que corresponde exactamente a los dos días del estudio. Es un timestamp real que registra los segundos transcurridos desde la primera transacción, no una hora del día.",
                            style = "margin-bottom: 10px;"),
                    tags$li("Finalmente, en cuanto a las transacciones, en el contexto de detección de fraude, los valores extremos no se eliminan, ya que pueden corresponder precisamente a transacciones fraudulentas, que es lo que nos interesa detectar.",
                            style = "margin-bottom: 10px;")
                  )
        )
      ),
      
      br(),
      
      # ── Vista previa ──
      content_card(
        title = "Vista previa del dataset",
        div(
          style = "margin-bottom: 12px;",
          p("Número de filas a mostrar:", style = "font-size:14px; margin-bottom:6px;"),
          sliderInput(ns("n_filas"), label = NULL, min = 5, max = 50, value = 10, step = 5, width = "100%")
        ),
        uiOutput(ns("tabla_preview"))
      ),
      
      div(
        style = "font-style:italic; font-size:13px;",
        p("Para la descripción detallada de cada variable consulta la tabla de operacionalización en el marco teórico.")
      )
  )
}

datasetServer <- function(id, df) {
  moduleServer(id, function(input, output, session) {
    
    output$tabla_preview <- renderUI({
      
      n <- input$n_filas
      datos <- head(df, n)
      
      # filas
      filas <- lapply(1:nrow(datos), function(i) {
        bg <- if (i %% 2 == 0) "#f8fafc" else "#ffffff"
        
        tags$tr(
          style = paste0("background:", bg, ";"),
          lapply(1:ncol(datos), function(j) {
            tags$td(
              style = "padding:8px 12px; border:1px solid #e2e8f0; font-size:0.8rem;",
              as.character(datos[i, j])
            )
          })
        )
      })
      
      # tabla completa
      tags$table(
        style = "width:100%; border-collapse:collapse; font-family:'Inter',sans-serif;",
        
        tags$thead(
          tags$tr(
            lapply(names(datos), function(col) {
              tags$th(
                style = "background:#1a2540; color:white; font-weight:600; font-size:0.8rem; padding:10px 12px; text-align:left;",
                col
              )
            })
          )
        ),
        
        tags$tbody(filas)
      )
    })
  })
}