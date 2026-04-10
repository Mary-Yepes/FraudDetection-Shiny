# R/mod_problema.R

problemaUI <- function(id) {
  ns <- NS(id)
  
  div(class = "page-fade-in",
      
      div(
        style = "margin-top: 10px; font-size: 14px; color: black; font-weight: bold; border-left: 4px solid #2e86c1; padding-left: 12px; font-size: 20px;",
        p("Planteamiento del problema")
      ),
      
      div(
        style = "margin-top: 10px; font-size: 14px; color: #6c757d;",
        p("El principal desafío es poder extraer patrones para poder identificar transacciones fraudulentas, a pesar del desbalance de clases. A continuación se 
          presentan distribuciones claves del dataset:")
      ),
      
      br(),
      
      layout_columns(
        col_widths = c(6, 6),
        
        content_card(
          title       = "Frecuencia por clase",
          full_screen = TRUE,
          plotlyOutput(ns("plot_clase_bar"), height = "320px")
        ),
        
        content_card(
          title       = "Monto de la transacción por clase",
          full_screen = TRUE,
          plotlyOutput(ns("plot_amount_class"), height = "320px")
        )
      ),
      
      br(),
      
      layout_columns(
        col_widths = c(6, 6),
        
        content_card(
          title       = "Distribución temporal (Time) ",
          full_screen = TRUE,
          plotlyOutput(ns("plot_hora"), height = "320px")
        ),
        
        content_card(
          title       = "Análisis por hora del día" ,
          full_screen = TRUE,
          plotlyOutput(ns("plot_time_density"), height = "320px")
        )
      )
  )
}

problemaServer <- function(id, df) {
  moduleServer(id, function(input, output, session) {
    
    # Gráfico de barras: clase
    output$plot_clase_bar <- renderPlotly({
      tabla <- df %>%
        mutate(Class_label = ifelse(Class == 1, "Fraude", "No Fraude"),
               Class_label = factor(Class_label, 
                                    levels = c("No Fraude", "Fraude"))) %>%
        count(Class_label, name = "Transacciones") %>%
        mutate(
          Pct    = round(Transacciones / sum(Transacciones) * 100, 2),
          Etiq   = paste0(fmt_number(Transacciones), " (", Pct, "%)"),
          Color  = ifelse(Class_label == "Fraude", color_fraude, color_no_fraude)
        )
      
      plot_ly(
        tabla, 
        x = ~Class_label, 
        y = ~Transacciones, 
        type = 'bar', 
        text = ~Etiq,
        hovertemplate = "Clase: %{x}<br>Transacciones: %{y:,}<br>%{customdata:.2f}%<extra></extra>",
        customdata = ~Pct,
        marker = list(
          color = '#2e86c1',
          line = list(color = 'rgb(8,48,107)',
                      width = 1.5)
        )) %>% 
        layout(title = "Distribución de transacciones: fraude vs no fraude",
               xaxis = list(title = "Tipo de transacción"),
               yaxis = list(title = "Número de transacciones"))
    })
    
    # Boxplot Amount por clase
    output$plot_amount_class <- renderPlotly({
      build_amount_box(df)
    })
    
    # Transacciones por hora
    output$plot_hora <- renderPlotly({
      plot_ly(df_clean, x = ~Time, color = ~Class_label, type = "histogram",
              nbinsx = 80, histnorm = "probability density",
              opacity = 0.6,
              colors = c("No Fraude" = "#2e86c1", "Fraude" = "#c0392b"),
              hovertemplate = "<b>Tipo:</b> %{fullData.name}<br><b>Tiempo:</b> %{x:,} s<br><b>Densidad:</b> %{y:.2e}<extra></extra>") %>%
        layout(barmode = "overlay",
               xaxis = list(title = "Tiempo (segundos desde la primera transacción)"),
               yaxis = list(title = "Densidad", tickformat = ".2e"),
               plot_bgcolor = "white",
               paper_bgcolor = "white",
               margin = list(t = 50, b = 40, l = 40, r = 20))
    })
    
    # Densidad temporal
    output$plot_time_density <- renderPlotly({
      plot_ly(
        tiempo,
        x           = ~Hour,
        y           = ~Mediana_Amount,
        color       = ~Tipo,
        colors      = c("No Fraude" = "#1f77b4", "Fraude" = "#d62728"),
        customdata  = ~Tipo,
        type        = "scatter",
        mode        = "lines+markers",
        hovertemplate = paste0(
          "<b>Hora relativa al inicio del registro:</b> %{x}<br>",
          "<b>Mediana del montot:</b> $%{y:.2f}<br>",
          "<b>Tipo de transacción:</b> %{customdata}",
          "<extra></extra>"
        )
      ) %>%
        layout(
          xaxis  = list(title = "Hora relativa al inicio del registro"),
          yaxis  = list(title = "Mediana del monto de la transacción"),
          legend = list(title = list(text = "Tipo de transacción"))
        )
    })
  })
}