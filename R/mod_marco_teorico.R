# R/mod_marco_teorico.R

marcoTeoricoUI <- function(id) {
  ns <- NS(id)
  
  div(class = "page-fade-in",
      
      layout_columns(
        col_widths = c(4, 4, 4),
        fill = FALSE,
        
        card(
          fill = FALSE, class = "eda-card",
          card_header(class = "eda-card-header", h5("Fraude Financiero", class = "card-title-text")),
          card_body(class = "eda-card-body",
                    p("El fraude con tarjeta de crédito es el uso ilegal y no autorizado de la tarjeta de crédito o de los datos de la tarjeta de otra persona para realizar 
        transacciones o compras fraudulentas (Microblink, s.f.). La detección temprana de este es esencial para reducir pérdidas, proteger a usuarios y 
        mantener confianza en los sistemas de pago digitales (Bolton & Hand, 2002).")
          )
        ),
        
        card(
          fill = FALSE, class = "eda-card",
          card_header(class = "eda-card-header", h5("Clasificación Binaria", class = "card-title-text")),
          card_body(class = "eda-card-body",
                    p("La detección de fraude se puede observar como un problema de clasificación binaria supervisada, en el que la variable objetivo 
        toma el valor 1 (fraude) o 0 (no fraude). No obstante, como se mencionó anteriormente, la complejidad está en el desbalance de clases que exige estrategias 
        específicas de modelado, que se profundizarán en el futuro.")
          )
        ),
        
        card(
          fill = FALSE, class = "eda-card",
          card_header(class = "eda-card-header", h5("Regresión logística", class = "card-title-text")),
          card_body(class = "eda-card-body",
                    p("La regresión logística es un modelo estadístico que predice la probabilidad de ocurrencia de un evento binario en función de un conjunto de variables 
        predictoras, mediante la función sigmoide (Hosmer et al., 2013). Es interpretable, eficiente computacionalmente y da probabilidades calibradas, por lo que 
        es base sólida para problemas de detección de fraude.")
          )
        )
      ),
      
      br(),
      
      layout_columns(
        col_widths = c(4, 4, 4),
        fill = FALSE,
        
        card(
          fill = FALSE, class = "eda-card",
          card_header(class = "eda-card-header", h5("Correlación de Spearman y VIF", class = "card-title-text")),
          card_body(class = "eda-card-body",
                    p("La correlación de Spearman evalúa de forma no paramétrica la relación monótona entre dos variables sin asumir normalidad. El Factor de Inflación de la Varianza (VIF) mide la multicolinealidad entre variables explicativas: un VIF ≥ 5 indica multicolinealidad moderada y un VIF ≥ 10 indica multicolinealidad severa, y esto puede afectar la estabilidad de los coeficientes del modelo.")
          )
        ),
        
        card(
          fill = FALSE, class = "eda-card",
          card_header(class = "eda-card-header", h5("Prueba de U de Mann-Whitney", class = "card-title-text")),
          card_body(class = "eda-card-body",
                    p("Dado que las variables del dataset presentan distribuciones asimétricas, alta presencia de valores atípicos y hay un marcado desbalance de clases, se realizó la prueba no paramétrica de U de Mann-Whitney, que permite comparar las medianas de las distribuciones entre las transacciones no fraudulentas y fraudulentas sin asumir una distribución normal.")
          )
        ),
        
        card(
          fill = FALSE, class = "eda-card",
          card_header(class = "eda-card-header", h5("Coeficiente de RBC y solapamiento IQR", class = "card-title-text")),
          card_body(class = "eda-card-body",
                    p("Debido a que el gran tamaño muestral puede hacer que diferencias pequeñas resulten estadísticamente significativas, para medir la capacidad discriminativa 
            de cada variable, se calculó el coeficiente RBC (Rank Biserial Correlation) como medida de tamaño de efecto, y un índice de solapamiento basado en los 
            rangos intercuartílicos (IQR) de ambas clases. Luego, tenemos:"),
                    tags$ul(
                      tags$li(strong("Alto poder discriminante: "), "cuando los intervalos intercuartílicos no se solapan y el coeficiente RBC es |RBC| > 0.5.",
                              style = "margin-bottom: 10px;"),
                      tags$li(strong("Moderado poder discriminante: "), "cuando el tamaño del efecto es moderado (0.3 ≤ |RBC| ≤ 0.5), aunque los cuartiles puedan superponerse parcialmente.",
                              style = "margin-bottom: 10px;"),
                      tags$li(strong("Bajo poder discriminante: "), "cuando los cuartiles se solapan ampliamente y el tamaño del efecto es muy bajo (|RBC| < 0.3).",
                              style = "margin-bottom: 10px;")
                    )
          )
        )
        
      ),
      
      br(),
      
      card(
        fill  = FALSE,    # ← se ajusta al alto de la tabla
        class = "eda-card",
        card_header(class = "eda-card-header", h5("Tabla de Operacionalización de Variables", class = "card-title-text")),
        card_body(class = "eda-card-body", uiOutput(ns("tabla_operacional")))
      )
  )
}

marcoTeoricoServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    output$tabla_operacional <- renderUI({
      tabla <- data.frame(
        Variable    = c("Time", "V1–V28", "Amount", "Class"),
        Tipo        = c("Cuantitativa continua", "Cuantitativa continua", "Cuantitativa continua", "Cualitativa nominal"),
        Nivel       = c("De razón", "De intervalo", "De razón", "Dicotómica"),
        Descripción = c(
          "Segundos transcurridos desde la primera transacción del dataset.",
          "Componentes principales (PCA) que anonimizan las variables originales.",
          "Monto de la transacción en euros.",
          "Indicador de fraude: 0 = legítima, 1 = fraudulenta."
        ),
        Rol = c("Predictora", "Predictoras", "Predictora", "Variable objetivo")
      )
      
      filas <- lapply(1:nrow(tabla), function(i) {
        bg <- if (i %% 2 == 0) "#f8fafc" else "#ffffff"
        tags$tr(style = paste0("background:", bg, ";"),
                tags$td(style = "padding:10px 14px; font-weight:bold; border:1px solid #e2e8f0; font-size:0.85rem;", tabla$Variable[i]),
                tags$td(style = "padding:10px 14px; border:1px solid #e2e8f0; font-size:0.85rem;", tabla$Tipo[i]),
                tags$td(style = "padding:10px 14px; border:1px solid #e2e8f0; font-size:0.85rem;", tabla$Nivel[i]),
                tags$td(style = "padding:10px 14px; border:1px solid #e2e8f0; font-size:0.85rem;", tabla$Descripción[i]),
                tags$td(style = "padding:10px 14px; border:1px solid #e2e8f0; font-size:0.85rem;", tabla$Rol[i])
        )
      })
      
      tags$table(
        style = "width:100%; border-collapse:collapse; font-family:'Inter',sans-serif;",
        tags$thead(
          tags$tr(
            lapply(c("Variable","Tipo","Nivel","Descripción","Rol"), function(col) {
              tags$th(style = "background:#1a2540; color:white; font-weight:600; font-size:0.82rem; padding:10px 14px; text-align:left;", col)
            })
          )
        ),
        tags$tbody(filas)
      )
    })
  })
}