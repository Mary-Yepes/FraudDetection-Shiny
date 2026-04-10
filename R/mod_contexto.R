# R/mod_contexto.R

contextoUI <- function(id) {
  ns <- NS(id)
  
  div(class = "page-fade-in",
      
      layout_columns(
        col_widths = c(3, 3, 3, 3),
        
        value_card(
          "283,726",
          "TOTAL DE TRANSACCIONES",
          bg_color = "white",
          extra_class = "asikurto-card"
        ),
        
        value_card(
          "283,253",
          "NO FRAUDALENTAS",
          bg_color = "white",
          extra_class = "asikurto-card"
        ),
        
        value_card(
          "473",
          "FRAUDALENTAS",
          bg_color = "white",
          extra_class = "asikurto-card"
        ),
        
        value_card(
          "0.17%",  # <- este cambio
          "TASA DE FRAUDE",
          bg_color = "white",
          extra_class = "asikurto-card"
        )
      ),
        
      
      br(),
        
      layout_columns(
        col_widths = c(6, 6),
        
        content_card(
          title = "Distribución de clases",
          plotlyOutput(ns("plot_clase_pie"), height = "400px")
        ),
        
        div(  # ← div en vez de card, para agrupar sin envoltura visual
          card(
            fill = FALSE,
            class = "eda-card",
            card_header(class = "eda-card-header", h5("Desbalance de clases", class = "card-title-text")),
            card_body(
              class = "eda-card-body",
              p("El dataset presenta un desbalance muy fuerte en la variable respuesta Class. Se tienen 283.726 transacciones totales, el 99.83% corresponde a 
                transacciones normales y solo el 0.17% a transacciones fraudulentas."),
              p("Este desequilibrio tiene implicaciones directas sobre los modelos predictivos:"),
              tags$ul(
                tags$li("Los modelos usualmente tienden a clasificar todo como no fraude y aun así obtener alta precisión (accuracy)."),
                tags$li("Con esto en mente, se debe tener en cuenta al recall como una métrica muy importante, pues un falso negativo implica no detectar una transacción fraudulenta."),
                tags$li("Se debe emplear validación cruzada estratificada (StratifiedKFold) para mantener la proporción de clases en cada fold.")
              )
            )
          ),
          
          
          card(
            fill = FALSE,
            class = "eda-card",
            card_header(class = "eda-card-header", h5("Costo del fraude no detectado (Falso Negativo)", class = "card-title-text")),
            card_body(class = "eda-card-body", p("Un falso negativo ocurre cuando el modelo clasifica una transacción fraudulenta como legítima. Las consecuencias incluyen 
                                                 pérdidas económicas tanto para la empresa como para el cliente, daño en la reputación de los bancos y posibles sanciones 
                                                 regulatorias. En contextos financieros, este error es considerado el más costoso."))
          ),
          
          card(
            fill = FALSE,
            class = "eda-card",
            card_header(class = "eda-card-header", h5("Costo de las alarmas falsas (Falso Positivo)", class = "card-title-text")),
            card_body(class = "eda-card-body", p("Un falso positivo bloquea una transacción legítima, aunque se podría pensar que no es tan grave como un falso negativo, 
                                                 en realidad genera molestias en la experiencia del cliente, llamadas al soporte y posible pérdida de confianza en el 
                                                 servicio. Por lo que se debe encontrar un balance entre precision y recall, por medio de la optimización de F1-score 
                                                 según la tolerancia al riesgo de las empresas."))
          )
        )
      )
    )
      

}

contextoServer <- function(id, df) {
  moduleServer(id, function(input, output, session) {
    
    output$plot_clase_pie <- renderPlotly({
      tabla <- df %>%
        mutate(Class_label = ifelse(Class == 1, "Fraude", "No Fraude")) %>%
        count(Class_label) %>%
        mutate(pct = round(n / sum(n) * 100, 2))
      
      plot_ly(
        tabla,
        labels = ~Class_label,
        values = ~n,
        type   = "pie",
        hole   = 0.5,
        marker = list(colors = c("#c0392b", "#4a6fa5"),
                      line   = list(color = "#ffffff", width = 2)),
        textinfo = "label+percent",
        hovertemplate = "%{label}: %{value:,}<br>%{percent}<extra></extra>"
      ) %>%
        plotly_layout()
    })
  })
}