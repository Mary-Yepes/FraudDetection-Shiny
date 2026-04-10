# ============================================================
# R/mod_descripcion.R — Módulo Descripción del Dataset
# ============================================================

mod_descripcion_ui <- function(id) {
  ns <- NS(id)
  tagList(
    tags$div(class = "page-header fade-in",
             tags$h2("Descripción del Conjunto de Datos"),
             tags$p("Estructura, variables y estadísticas generales del dataset")
    ),
    
    fluidRow(
      class = "fade-in",
      column(3, uiOutput(ns("kpi_filas"))),
      column(3, uiOutput(ns("kpi_cols"))),
      column(3, uiOutput(ns("kpi_duplic"))),
      column(3, uiOutput(ns("kpi_nas")))
    ),
    
    fluidRow(
      class = "mt-4 fade-in",
      column(5,
             content_card(
               titulo    = "Variables del dataset",
               subtitulo = "31 variables en total",
               tags$table(class = "var-table",
                          tags$thead(tags$tr(
                            tags$th("Variable"), tags$th("Tipo"), tags$th("Descripción")
                          )),
                          tags$tbody(
                            tags$tr(tags$td(tags$code("Time")),   tags$td("Numérica"), tags$td("Segundos desde la primera transacción")),
                            tags$tr(tags$td(tags$code("V1–V28")), tags$td("Numérica"), tags$td("Componentes PCA (datos anonimizados)")),
                            tags$tr(tags$td(tags$code("Amount")), tags$td("Numérica"), tags$td("Monto de la transacción en euros (€)")),
                            tags$tr(tags$td(tags$code("Class")),  tags$td("Binaria"),  tags$td("0 = legítima, 1 = fraude"))
                          )
               )
             )
      ),
      column(7,
             content_card(
               titulo    = "Resumen estadístico de Amount y Time",
               subtitulo = "Variables originales no anonimizadas",
               DTOutput(ns("tabla_resumen"))
             )
      )
    ),
    
    fluidRow(
      class = "mt-3 fade-in",
      column(12,
             content_card(
               titulo    = "Primeras filas del dataset",
               subtitulo = "Vista preliminar de las observaciones",
               DTOutput(ns("tabla_head"))
             )
      )
    )
  )
}

mod_descripcion_server <- function(id, df) {
  moduleServer(id, function(input, output, session) {
    
    output$kpi_filas  <- renderUI(value_card("Observaciones",
                                             format(nrow(df), big.mark=","), "Filas totales", COL_NO_FRAUDE, "table"))
    output$kpi_cols   <- renderUI(value_card("Variables",
                                             ncol(df), "Columnas", COL_ACENTO, "columns"))
    output$kpi_duplic <- renderUI(value_card("Duplicados",
                                             "1", "Eliminados en limpieza", COL_WARN, "copy"))
    output$kpi_nas    <- renderUI(value_card("Valores faltantes",
                                             "0", "Dataset completo", COL_FRAUDE, "check-circle"))
    
    # Resumen estadístico de Amount y Time
    output$tabla_resumen <- renderDT({
      vars <- c("Time", "Amount")
      df_num <- df[, vars, drop = FALSE]
      # Solo valores numéricos
      df_num$Time   <- as.numeric(as.character(df_num$Time))
      df_num$Amount <- as.numeric(as.character(df_num$Amount))
      
      res <- do.call(rbind, lapply(vars, function(v) {
        s <- resumen_stats(df_num[[v]])
        data.frame(
          Variable  = v,
          n         = format(s$n, big.mark=","),
          Media     = sprintf("%.2f", s$mean),
          SD        = sprintf("%.2f", s$sd),
          Mediana   = sprintf("%.2f", s$median),
          IQR       = sprintf("%.2f", s$IQR),
          Mínimo    = sprintf("%.2f", s$min),
          Máximo    = sprintf("%.2f", s$max),
          check.names = FALSE
        )
      }))
      
      datatable(res,
                rownames  = FALSE,
                options   = list(dom = "t", pageLength = 5),
                class     = "dt-custom"
      )
    })
    
    # Preview del dataset
    output$tabla_head <- renderDT({
      preview <- head(df, 20)
      # Redondear V columnas para mejor lectura
      v_cols <- grep("^V", names(preview), value = TRUE)
      preview[v_cols] <- lapply(preview[v_cols], function(x) round(as.numeric(x), 3))
      preview$Time   <- round(as.numeric(preview$Time), 0)
      preview$Amount <- round(as.numeric(preview$Amount), 2)
      
      datatable(preview,
                rownames  = FALSE,
                options   = list(scrollX = TRUE, pageLength = 10, dom = "tip"),
                class     = "dt-custom"
      )
    })
  })
}