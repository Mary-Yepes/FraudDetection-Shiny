# R/mod_resultados.R

resultadosUI <- function(id) {
  ns <- NS(id)
  
  div(class = "page-fade-in",
      
      div(
        style = "margin-top: 10px; color: black; font-weight: bold; border-left: 4px solid #2e86c1; padding-left: 12px; font-size: 17px;",
        p("Análisis Exploratorio de Datos")
      ),
    
      div(
        style = "margin-top: 10px; font-size: 15px; color: #6c757d;",
        p("Para ver de mejor manera la distribución de Amount, se recomienda seleccionar Log Amount en el análisis bivariado, pues esta tiene una alta asimetría 
          que no permite comparar las clases.")
      ),
      
      br(),
      
      # Tabs de resultados
      navset_card_tab(
        
        nav_panel("Análisis Univariado",
                  br(),
                  
                  selectizeInput(
                    ns("var_todas"), 
                    "Selecciona una variable:",
                    choices = c("Class", "Time", "Amount", "Log Amount", paste0("V", 1:28)), 
                    selected = "V1",
                    options = list(
                      placeholder = "Busca una variable...",
                      maxOptions = 1000
                    )
                  ),
                  
                  br(),
                  
                  
                  
                  layout_columns(
                    col_widths = c(6, 6),
                    
                    value_card(
                      textOutput(ns("asimetria_val")),
                      textOutput(ns("asimetria_nofraude")),
                      bg_color = "white",
                      extra_class = "asikurto-card"
                    ),
                    
                    value_card(
                      textOutput(ns("curtosis_val")),
                      textOutput(ns("asimetria_fraude")),
                      bg_color = "white",
                      extra_class = "asikurto-card"
                    )
                  ),
                  
                  br(),
                  layout_columns(
                    col_widths = c(12),
                    
                    content_card(
                      title = textOutput(ns("titulo_variable")),
                      full_screen = TRUE,
                      
                      plotlyOutput(ns("plot_de_variables"), width = "100%", height = "500px")
                    )
                  ),
                  
                  div(
                    style = "margin-top: 10px; font-size: 14px; color: #6c757d;",
                    textOutput(ns("descripcion_variable"))
                  )
        ),
        
        nav_panel("Análisis Bivariado",
                  br(),
                  
                  selectizeInput(
                    ns("var_todas_bivariado"), 
                    "Selecciona una variable:",
                    choices = c("Time", "Amount", "Log Amount", paste0("V", 1:28)), 
                    selected = "V1",
                    options = list(
                      placeholder = "Busca una variable...",
                      maxOptions = 1000
                    )
                  ),
                  
                  br(),
                  
                  layout_columns(
                    col_widths = c(3, 3, 3, 3),
                    
                    value_card(
                      textOutput(ns("estadistico")),
                      "ESTADÍSTICO U",
                      bg_color = "white",
                      extra_class = "asikurto-card"
                    ),
                    
                    value_card(
                      textOutput(ns("pvalor")),
                      "P-VALOR",
                      bg_color = "white",
                      extra_class = "asikurto-card"
                    ),
                    
                    value_card(
                      textOutput(ns("rbc")),
                      "RBC",
                      bg_color = "white",
                      extra_class = "asikurto-card"
                    ),
                    
                    value_card(
                      uiOutput(ns("poderdiscriminante")),  # <- este cambio
                      "PODER DISCRIMINANTE",
                      bg_color = "white",
                      extra_class = "asikurto-card"
                    )
                  ),
                  
                  br(),
                  
                  
                  layout_columns(
                    col_widths = c(12),
                    
                    content_card(
                      title    = textOutput(ns("titulo_class_variable")),
                      full_screen = TRUE,
                      plotlyOutput(ns("plot_pca_violin"), height = "500px", width = "100%")
                    )
                  ),
                  
                  div(
                    style = "margin-top: 10px; font-size: 14px; color: #6c757d;",
                    textOutput(ns("descripcion_bivariado"))
                  )
        ),
        
        nav_panel("Análisis Temporal",
                  
                  layout_columns(
                    col_widths = c(12),
                    
                    content_card(
                      title = "Análisis temporal de las transacciones",
                      full_screen = TRUE,
                      
                      p("El análisis exploratorio previo permite plantear una pregunta adicional: ¿tienden a concentrarse montos más elevados en ciertos intervalos de tiempo 
                        o el comportamiento del monto es independiente del tiempo en estos dos días? Para este análisis se usa la mediana de Amount debido al gran sesgo de esta 
                          variable.",
                        style = "font-size: 14px; color: #6c757d;"
                      ),
                      
                      plotlyOutput(ns("plot_hora_fraude"), height = "350px"),
                      
                      p("Note que Time representa los segundos transcurridos desde la primera transacción, luego, las horas son relativas al inicio del registro y no 
                        corresponden necesariamente a horas del día reales. Con esto en mente, a simple vista parece que en las horas relativas 0, 6 y 14 las medianas de 
                        los montos de las transacciones fraudulentas son muy elevadas, y presentan una alta variabilidad, con picos pronunciados, lo que implica que estos 
                        no siguen un patrón uniforme y pueden concentrarse en intervalos específicos con valores elevados. En contraste, el monto en las transacciones no 
                        fraudulentas presenta un comportamiento relativamente estable a lo largo del tiempo. No obstante, en el futuro se realizarán pruebas estadísticas 
                        para verificar si las diferencias son a causa de un patrón significativo o se atribuyen a la variabilidad aleatoria derivada del tamaño muestral 
                        reducido en la clase minoritaria.",
                        style = "margin-top: 10px; font-size: 14px; color: #6c757d;"
                      )
                    )
                  )
                  
                  
        ),
        
        nav_panel("Estructura de variables",
                  br(),
                  
                  div(
                    style = "margin-top: 10px; font-size: 14px; color: black; font-weight: bold; border-left: 4px solid #2e86c1; padding-left: 12px; font-size: 15px;",
                    p("Correlación")
                  ),
                  
                  selectizeInput(
                    ns("var_correlacion"), 
                    "Selecciona una vista:",
                    choices = c("General", "Por clase (Fraude vs No fraude)"), 
                    selected = "V1",
                    options = list(
                      placeholder = "Busca una variable...",
                      maxOptions = 1000
                    )
                  ),
                  
                  content_card(
                    title    = "Matriz de correlación Spearman",
                    full_screen = TRUE,
                    plotlyOutput(ns("plot_corr"), height = "500px")
                  ),
                  
                  div(
                    style = "margin-top: 10px; font-size: 14px; color: #6c757d;",
                    textOutput(ns("descripcion_correlacion"))
                  ),
                  
                  br(),
                  
                  div(
                    style = "margin-top: 10px; font-size: 14px; color: black; font-weight: bold; border-left: 4px solid #2e86c1; padding-left: 12px; font-size: 15px;",
                    p("Factor de Inflación de la Varianza (VIF)")
                  ),
                  
                  div(
                    style = "margin-top: 10px; font-size: 14px; color: #6c757d;",
                    p("El Factor de Inflación de la Varianza (VIF) mide la multicolinealidad entre las variables explicativas. Un VIF ≥ 5 indica multicolinealidad moderada 
                      y un VIF ≥ 10 indica multicolinealidad severa. En este dataset, solo Amount tiene un VIF mayor a 10 (VIF = 12.30), mientras que el resto de variables 
                      tienen valores bajos, lo que sugiere que no hay multicolinealidad problemática.")
                  ),
              
                  
                  content_card(
                    title    = "VIF por variable",
                    full_screen = TRUE,
                    plotlyOutput(ns("vif_corr"), height = "500px")
                  ),
                  
                  div(
                    style = "margin-top: 10px; font-size: 14px; color: black; font-weight: bold; border-left: 4px solid #2e86c1; padding-left: 12px; font-size: 15px;",
                    p("Capacidad discriminativa (RBC)")
                  ),
                  
                  div(
                    style = "margin-top: 10px; font-size: 14px; color: #6c757d;",
                    p("El coeficiente RBC (Rank Biserial Correlation) mide qué tan bien separa cada variable las transacciones fraudulentas de las no fraudulentas. 
                      Las líneas verdes marcan el umbral |RBC| > 0.5, que indica alta capacidad discriminativa. Las 5 variables con mayor capacidad discriminativa son: 
                      V14, V4, V12, V11 y V10")
                  ),
                  
                  
                  
                  content_card(
                    title    = "RBC por variable",
                    full_screen = TRUE,
                    plotlyOutput(ns("rbc_corr"), height = "500px")
                  )
                  
                  
        )
      )
  )
}

resultadosServer <- function(id, df) {
  moduleServer(id, function(input, output, session) {
    
    # título dinámico
    output$titulo_variable <- renderText({
      req(input$var_todas)
      
      paste(input$var_todas)
    })
    
    # descripción dinámica
    output$descripcion_variable <- renderText({
      req(input$var_todas)
      var <- input$var_todas
      
      if (var == "Amount"){
        "El monto promedio transferido fue de 88.47 euros (DE = 250.39), con un rango de 0 a 25,691.16. El 50% de las transacciones estuvo por debajo de 22 
        euros (IQR = 71.91). Se evidencia esta gran asimetría positiva que se concentra en montos bajos y tiene una cola larga a valores altos. Con el fin de tener 
        una mejor visualización, se puede usar Log Amount."
      } else if (var == "Time"){
        "La variable Time tiene un promedio de 94,811.08 s (DE = 47,481.05 s), con una mediana de 84,692.50 s e IQR de 85,093.25 s. El rango va de 0 a 172,792 s, 
        correspondiente exactamente a los dos días de observación. En el gráfico se ve una concentración en las transacciones al inicio y al final del intervalo 
        temporal, con una menor densidad en la parte intermedia, que puede ser el final del primer día. Se observa una distribución más plana con colas más ligeras 
        que una normal, por lo que los tiempos se distribuyen de manera relativamente homogénea a lo largo de los dos días."
      } else if (var == "Class"){
        "Se observa un desbalance extremo en la variable respuesta Class, pues con un total de 283.726 transacciones, 283.253 (99.83%) corresponden a transacciones 
        no fraudulentas (Clase 0) y 473 (0.17%) corresponden a transacciones fraudulentas (Clase 1)."
      } else if (var == "Log Amount"){
        "Con la transformación logarítmica, se puede ver claramente la distribución de los datos. No obstante, todavía hay valores atípicos; sin embargo, la media y 
        mediana son similares, lo que dice que los valores extremos no están influyendo de manera tan significativa en la tendencia central de la distribución."
      } else {
        "En los boxplots de las variables V1-V28 se nota un patrón que es consistente con la naturaleza de este tipo de variables (PCA). Las primeras componentes 
        (V1,V2,V3) son las que tienen la mayor dispersión, valores extremos y alta asimetría, mientras que las siguientes tienen distribuciones relativamente más 
        centradas en cero. Las variables que tienen kurtosisi alta (V1, V2, V5, V7, V8, V20, V21, V23, V28) tienen colas muy pesadas y un número mucho mayor de valores 
        extremos, por otro lado, variables como V11, V13, V15, V18 y V19 tienen distribuciones más simétricas y mesocúrticas."
      }
    })
    
    # Gráficos según variable seleccionada
    output$plot_de_variables <- renderPlotly({ #Define un output interactivo
      req(input$var_todas) #No hace nada hasta que el usuario no haya seleccionada nada
      var <- input$var_todas #Guardamos la variable que el usuario selecciono
      
      
      if(var %in% c(paste0("V", 1:28), "Amount")){
        plot_ly() %>% add_boxplot(
          data = df,
          y = as.formula(paste0("~", var)),
          name = ".",
          marker = list(color = "#2e86c1")
        ) %>% layout(
          title = list(
            text = paste("Distribución de", var),
            x = 0.05,            # mueve el título a la derecha
            xanchor = "left" # lo alinea correctamente al borde derecho
          )
        )
      } else if (var == "Time"){
        density <- density(df$Time)
        plot_ly(x = ~density$x, y = ~density$y, type = 'scatter', mode = 'lines', fill = 'tozeroy') %>% 
          layout(title = paste("Distribución de", var),
                 
                 xaxis = list(title = paste(var)),
                 
                 yaxis = list(title = 'Densidad', tickformat = ".2e"))
      } else if (var == "Class"){
        
        tabla_y <- df %>% mutate(Class = ifelse(Class == 1, "Fraude", "No Fraude"), Class = factor(Class, levels = c("No Fraude", "Fraude"))) %>% 
          count(Class, name = "Transacciones") %>% mutate( Porcentaje = (Transacciones / sum(Transacciones)) * 100, Porcentaje_red = round(Porcentaje, 2), 
                                                           Etiqueta = paste0( Transacciones, " (", Porcentaje_red, "%)" ) )
        
        plot_ly(
          tabla_y, 
          x = ~Class, 
          y = ~Transacciones, 
          type = 'bar', 
          text = ~Etiqueta,
          hovertemplate = paste(
            "Clase: %{x}<br>",
            "Transacciones: %{y}<br>",
            "Porcentaje: %{customdata:.2f}%<extra></extra>"
          ),
          customdata = ~Porcentaje,
          marker = list(
            color = '#2e86c1',
            line = list(color = 'rgb(8,48,107)',
                        width = 1.5)
          )) %>% 
          layout(title = paste("Distribución de", var),
                 xaxis = list(title = "Tipo de transacción"),
                 yaxis = list(title = "Frecuencia"))
        
      } else if (var == "Log Amount"){
        plot_ly() %>% add_boxplot(
          data = df,
          y = ~log(Amount),
          name = ".",
          marker = list(color = "#2e86c1")
        ) %>% layout(
          title = paste("Distribución de", var),
          xaxis = list(showticklabels = FALSE),
          yaxis = list(title = paste(var))
        )
      }
      
    })
    
    # asimetria y curtosis
    
    # dependiendo de la variable desplegar asimetria o no fraude, curtosis o fraude.
    output$asimetria_nofraude <- renderText({
      req(input$var_todas)
      
      if (input$var_todas != "Class"){
        paste0("ASIMETRÍA")
      } else {
        paste0("NO FRAUDE")
      }
    })
    
    output$asimetria_fraude <- renderText({
      req(input$var_todas)
      
      if (input$var_todas != "Class"){
        paste0("CURTOSIS")
      } else {
        paste0("FRAUDE")
      }
    })
    
    
    
    output$asimetria_val <- renderText({
      req(input$var_todas)
      
      var <- input$var_todas
      
      if (var != "Log Amount" & var != "Class"){
        valor <- df[[var]]
        
        round(e1071::skewness(valor, na.rm = TRUE), 2)
      } else if (var == "Class"){
        
        no_fraude <- df_clean %>%
          mutate(Class = ifelse(Class == 1, "Fraude", "No Fraude")) %>%
          count(Class) %>%
          mutate(Porcentaje = 100 * n / sum(n)) %>% 
          filter(Class == "No Fraude") %>% 
          pull(Porcentaje)
        
        paste0(round(no_fraude, 2), "%")
      }
      
    })
    
    output$curtosis_val <- renderText({
      req(input$var_todas)
      
      var <- input$var_todas
      
      if (var != "Log Amount" & var != "Class"){
        valor <- df[[var]]
        
        round(e1071::kurtosis(valor), 2)
      } else if (var == "Class"){
        
        fraude <- df_clean %>%
          mutate(Class = ifelse(Class == 1, "Fraude", "No Fraude")) %>%
          count(Class) %>%
          mutate(Porcentaje = 100 * n / sum(n)) %>% 
          filter(Class == "Fraude") %>% 
          pull(Porcentaje)
        
        paste0(round(fraude, 2), "%")
      }
      
    })
    
    
    # ──────────────────────────────────────────────────────────────────────── BIVARIADO ────────────────────────────────────────────────────────────────────────
    
    # Nombre dinámico bivariado
    
    output$titulo_class_variable <- renderText({
      req(input$var_todas_bivariado)
      var <- input$var_todas_bivariado
      
      paste0(var, " vs Class")
    })
    
    
    # ──────────────── Violin PCA por clase ────────────────
    
    output$plot_pca_violin <- renderPlotly({
      req(input$var_todas_bivariado)
      var <- input$var_todas_bivariado
      
      if (var != "Log Amount" & var != "Time") {
        df_plot <- df %>%
          mutate(Class_label = factor(ifelse(Class == 1, "Fraude", "No Fraude"), levels = c("No Fraude", "Fraude")),
                 valor = .data[[var]])
        
        plot_ly(
          df_plot,
          x      = ~Class_label,
          y      = ~valor,
          type   = "violin",
          color  = ~Class_label,
          colors = c("No Fraude" = color_no_fraude, "Fraude" = color_fraude),
          box    = list(visible = TRUE),
          meanline = list(visible = TRUE)
        ) %>%
          layout(
            title = list(text = paste("Distribución de", var, "por clase"), x = 0.05, xanchor = "left"),
            xaxis = list(title = "Clase"),
            yaxis = list(title = var),
            showlegend = FALSE
          )
      } else if (var == "Log Amount"){
        df_plot <- df %>%
          mutate(Class_label = ifelse(Class == 1, "Fraude", "No Fraude"),
                 valor = log(Amount))
        
        plot_ly(
          df_plot,
          x      = ~Class_label,
          y      = ~valor,
          type   = "violin",
          color  = ~Class_label,
          colors = c("No Fraude" = color_no_fraude, "Fraude" = color_fraude),
          box    = list(visible = TRUE),
          meanline = list(visible = TRUE)
        ) %>%
          layout(
            title = list(text = paste("Distribución de", var, "por clase"), x = 0.05, xanchor = "left"),
            xaxis = list(title = "Clase"),
            yaxis = list(title = var),
            showlegend = FALSE
          )  
        
      } else {
        plot_ly(x = ~densidad1$x, y = ~densidad1$y, type = 'scatter', mode = 'lines', name = 'No Fraude', fill = 'tozeroy', fillcolor = "rgba(31, 119, 180, 0.5)", 
                line = list(color = "#1f77b4")) %>% 
          add_trace(x = ~densidad2$x, y = ~densidad2$y, name = 'Fraude', fill = 'tozeroy', fillcolor = "rgba(214, 39, 40, 0.5)", line = list(color = "#d62728")) %>% 
          layout(title = paste("Distribución de", var, "por clase"),
                 
                 xaxis = list(title = "Tiempo (segundos)"),
                 
                 yaxis = list(title = 'Densidad', tickformat = ".2e"))
      }
      
    })
    
    # Descripciones
    
    output$descripcion_bivariado <- renderText({
      req(input$var_todas_bivariado)
      var <- input$var_todas_bivariado
      
      if (var == "Amount"){
        "La mediana en transacciones fraudulentas es de 9.82 euros frente a 22 euros en no fraudulentas, lo que sugiere que el fraude típico no ocurre en transacciones 
        de alto valor. La media en fraude (123.87, DE = 260.21) es superior a la de no fraude (88.41, DE = 250.38), diferencia influenciada por valores extremos. 
        El IQR en fraude (1–105.89) presenta solapamiento considerable con el de no fraude (5.67–77.46), confirmando baja capacidad discriminativa. Aunque la diferencia 
        es estadísticamente significativa (U = 59,517,129.5, p ≈ 0.003), el RBC = -0.112 indica que los grupos están muy solapados."
      } else if (var == "Time"){
        "Las transacciones fraudulentas (n = 473) tienen un tiempo promedio de 80,450.51 s (DE = 48,636.18 s), con mediana de 73,408 s (IQR = 87,892 s). Las no fraudulentas 
        (n = 283,253) presentan un tiempo promedio mayor (94,835.06 s, DE = 47,475.55 s) con mediana de 84,711 s. Ambas distribuciones tienen gran dispersión y solapamiento 
        en prácticamente todo el intervalo temporal. Aunque la diferencia es estadísticamente significativa (p < 0.05), el RBC = -0.169 indica un efecto de magnitud pequeña: 
        el momento de la transacción no distingue de manera marcada entre fraude y no fraude."
      }  else if (var == "Log Amount"){
        "Debido a la alta asimetría de la variable Amount, se aplicó una transformación logarítmica para visualizar de manera más clara la distribución de los datos. 
        En este caso, se sigue evidenciando que la mediana en las transacciones no fraudulentas es mayor que en la de transacciones fraudulentas. A simple vista, 
        se observa un considerable solapamiento entre ambas cajas, lo que reafirma más que Amount no separa fuertemente entre clases. Por otro lado, la clase Fraude 
        parece más disperso hacia valores bajos, mientras que No fraude parece que tiene valores intermedios."
      } else {
        "Los violin plots confirman visualmente la separación entre clases. En las componentes con alto poder discriminante no hay solapamiento entre las distribuciones 
        de Fraude y No Fraude. La mediana en No Fraude (clase 0) es aproximadamente 0 en todas las componentes, mientras que en Fraude (clase 1) toma valores positivos o 
        negativos según la componente. Las cajas del grupo Fraude son notablemente más amplias, lo que indica mayor variabilidad en las transacciones fraudulentas. 
        En ambos grupos se evidencia una gran cantidad de valores atípicos, especialmente en No Fraude, lo cual es esperable dado el fuerte desbalance de clases."
      }
    })
    
    
    
    # ──────────────── Pruebas, estadisticos, clasificaciones ────────────────
    
    #Estadístico U
    output$estadistico <- renderText({
      req(input$var_todas_bivariado)
      
      var <- input$var_todas_bivariado
      
      fraude <- df[df$Class == 1, ][[var]]
      no_fraude <- df[df$Class == 0, ][[var]]
      total <- df[[var]]
      
      # Mann-Whitney
      test <- wilcox.test(fraude, no_fraude, alternative = "two.sided", exact = FALSE)
      
      u_stat <- as.numeric(test$statistic)
      
      U <- format(round(u_stat, 0), big.mark = ",", scientific = FALSE)
      
      paste0(U)
      
      
    })
    
    #P-VALOR
    output$pvalor <- renderText({
      req(input$var_todas_bivariado)
      
      var <- input$var_todas_bivariado
      
      fraude <- df[df$Class == 1, ][[var]]
      no_fraude <- df[df$Class == 0, ][[var]]
      total <- df[[var]]
      
      # Mann-Whitney
      test <- wilcox.test(fraude, no_fraude, alternative = "two.sided", exact = FALSE)
      
      pvalue <- test$p.value
      
      p = c(format(pvalue, scientific = TRUE, digits = 3), "", "")
      
      paste0(p)
      
      
    })
    
    #RBC
    output$rbc <- renderText({
      req(input$var_todas_bivariado)
      
      var <- input$var_todas_bivariado
      
      fraude <- df[df$Class == 1, ][[var]]
      no_fraude <- df[df$Class == 0, ][[var]]
      total <- df[[var]]
      
      # Mann-Whitney
      test <- wilcox.test(fraude, no_fraude, alternative = "two.sided", exact = FALSE)
      
      u_stat <- as.numeric(test$statistic)
      
      n1 <- length(fraude)
      n2 <- length(no_fraude)
      
      rbc_val <- - (1 - (2 * u_stat) / (n1 * n2))
      
      rbc = c(sprintf("%.3f", rbc_val), "", "")
      
      paste0(rbc)
      
      
    })
    
    #poder discriminante
    
    # Output del card completo con badge
    ALTO = c("V2", "V3", "V4", "V7", "V9", "V10", "V11", "V12", "V14", "V16", "V17")
    MODERADO = c("V1", "V5", "V6", "V8", "V18", "V19", "V20", "V21", "V27")
    BAJO = c("V13", "V15", "V22", "V23", "V24", "V25", "V26", "V28", "Amount", "Time")
    
    output$poderdiscriminante <- renderUI({
      req(input$var_todas_bivariado)
      
      var <- input$var_todas_bivariado
      
      if (var == "Log Amount") var <- "Amount"
      
      if (var %in% ALTO) {
        color  <- "#27ae60"
        etiq   <- "Alto poder discriminante"
      } else if (var %in% MODERADO) {
        color  <- "#f39c12"
        etiq   <- "Moderado poder discriminante"
      } else {
        color  <- "#c0392b"
        etiq   <- "Bajo poder discriminante"
      }
      
      div(
        style = "display: flex; flex-direction: column; align-items: center; justify-content: center; height: 100%;",
        span(
          etiq,
          style = paste0(
            "background:", color, ";",
            "color: white;",
            "padding: 5px 16px;",
            "border-radius: 20px;",
            "font-size: 0.85rem;",
            "font-weight: 600;"
          )
        )
      )
    })
    
    # ──────────────────────────────────────────────────────────────────────── TEMPORAL ────────────────────────────────────────────────────────────────────────
    
    output$plot_hora_fraude <- renderPlotly({
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
          "<b>Hora:</b> %{x}h<br>",
          "<b>Mediana Amount:</b> $%{y:.2f}<br>",
          "<b>Tipo:</b> %{customdata}",
          "<extra></extra>"
        )
      ) %>%
        layout(
          xaxis  = list(title = "Hora relativa al inicio del registro"),
          yaxis  = list(title = "Mediana del monto de la transacción"),
          legend = list(title = list(text = "Tipo de transacción"))
        )
    })
    
    
    # ──────────────────────────────────────────────────────────────────────── CORRELACIÓN ────────────────────────────────────────────────────────────────────────
    
    output$plot_corr <- renderPlotly({
      req(input$var_correlacion)
      var <- input$var_correlacion
      
      if (var == "General") {
        build_corr_heatmap(df)
      } else {
        fig1 <- build_corr_heatmap(df_fraud)
        fig2 <- build_corr_heatmap(df_no_fraud)
        
        subplot(fig2, fig1, nrows = 1, shareY = FALSE, titleX = TRUE) %>%
          layout(
            annotations = list(
              list(x = 0.2, y = 1.05, text = "Transacciones NO fraudalentas",    showarrow = FALSE, xref = "paper", yref = "paper"),
              list(x = 0.8, y = 1.05, text = "Transacciones fraudalentas", showarrow = FALSE, xref = "paper", yref = "paper")
            )
          )
      }
    })
    
    output$vif_corr <- renderPlotly({
      build_vif_plot(vif_data)
    })
    
    output$rbc_corr <- renderPlotly({
      build_rbc_plot(rbc_data)
    })
    
    output$descripcion_correlacion <- renderText({
      req(input$var_correlacion)
      var <- input$var_correlacion
      
      if (var == "General"){
        "En este análisis de correlación inicial usando Spearman, muchas de las variables V1-V28 muestran correlaciones bajas entre sí y con las variables Amount y Time, 
        es decir no hay relaciones monótónicas fuertes. No obstante, hay correlaciones visibles como: V21 y V22 tienen una correlación positiva moderada (r = 0.68), 
        mientras que V2 con Amount muestra una correlación negativa moderada (r = -0.50). De todas formas, no se observan patrones de correlación generalizados marcados. 
        Cabe resaltar que la correlación de Pearson es aproximadamente 0 entre las variables V1 hasta V28, debido a la ortogonalidad del proceso PCA."
      } else {
        "En la vista por clases se observa un contraste claro: en las transacciones no fraudulentas las correlaciones son en su mayoría cercanas a 0, sin patrones 
        consistentes entre variables, lo cual es esperable dado que dominan el dataset y determinan el comportamiento global. En cambio, en las transacciones fraudulentas 
        emergen correlaciones moderadas a fuertes entre las primeras componentes principales (V1–V18), destacando V18–V17, V17–V16 y V18–V16 (r ≈ 0.94–0.96), pues estas
        capturan mayor parte de la variabilidad de los datos y permiten evidenciar patrones internos consistentes en esta clase que no son visibles en el análisis general."
      }
      
    })
    
    
    
  })
}