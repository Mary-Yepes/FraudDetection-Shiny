# R/mod_conclusiones.R

conclusionesUI <- function(id) {
  ns <- NS(id)
  
  div(class = "page-fade-in",
      
      div(
        style = "margin-top: 10px; color: black; font-weight: bold; border-left: 4px solid #2e86c1; padding-left: 12px; font-size: 20px;",
        p("Síntesis y Conclusiones")
      ),
      
      div(
        style = "margin-top: 10px; font-size: 15px; color: #6c757d;",
        p("Principales hallazgos del análisis exploratorio del dataset de fraude en transacciones con tarjeta de crédito.")
      ),
      
      br(),
      
      layout_columns(
        col_widths = c(3, 3, 3, 3),
        
        value_card("283,726", "TRANSACCIONES ANALIZADAS", bg_color = "white", extra_class = "asikurto-card"),
        value_card("31",      "VARIABLES ANALIZADAS",     bg_color = "white", extra_class = "asikurto-card"),
        value_card("0.17%",   "PREVALENCIA DE FRAUDE",    bg_color = "white", extra_class = "asikurto-card"),
        value_card("V14",     "MAYOR PODER DISCRIMINANTE",bg_color = "white", extra_class = "asikurto-card")
      ),
      
      br(),
      
      div(
        style = "margin-top: 10px; color: black; font-weight: bold; border-left: 4px solid #2e86c1; padding-left: 12px; font-size: 20px;",
        p("Hallazgos clave")
      ),
      
      div(
        style = "margin-top: 10px; font-size: 15px; color: #6c757d;",
        p("Los principales patrones identificados en el análisis exploratorio.")
      ),
      
      br(),
      
      
      layout_columns(
        col_widths = c(12),
        
        div(
          content_card(
            title = "",
            
            div(class = "concl-item",
                span(class = "concl-number", "01"),
                div(
                  h6("Desbalance de clases extremo", class = "fw-bold"),
                  p("Solo 473 transacciones (0.17%) son fraudulentas frente a 283.253 no fraudulentas. Este desbalance es el principal desafío y exige estrategias 
                    como SMOTE o ajuste de pesos de clase.",
                    class = "text-muted small")
                )
            ),
            
            div(class = "concl-item mt-3",
                span(class = "concl-number", "02"),
                div(
                  h6("Variables PCA con alto poder discriminativo", class = "fw-bold"),
                  p("V2, V3, V4, V7, V9, V10, V11, V12, V14, V16 y V17 presentan rangos intercuartílicos separados entre clases y RBC > 0.5, siendo las más útiles 
                    para detectar fraude. V14 lidera con RBC = −0.894.",
                    class = "text-muted small")
                )
            ),
            
            div(class = "concl-item mt-3",
                span(class = "concl-number", "03"),
                div(
                  h6("Time y Amount: significativas pero poco discriminativas", class = "fw-bold"),
                  p("Aunque presentan diferencias estadísticamente significativas (p < 0.05), tienen RBC bajo (−0.169 y −0.112) que 
                    indican poco poder discriminativo. Como están, no aportan mucho al modelo."),
                    class = "text-muted small")
                ),
            
            div(class = "concl-item mt-3",
                span(class = "concl-number", "04"),
                div(
                  h6("Patrones internos en transacciones fraudulentas", class = "fw-bold"),
                  p("Las correlaciones entre V1–V18 son moderadas a fuertes en el grupo fraude (hasta r ≈ 0.96), mientras que en no fraude son cercanas a 0, 
                    revelando estructura interna consistente en las transacciones fraudulentas.",
                    class = "text-muted small")
                )
            ),
            
            div(class = "concl-item mt-3",
                span(class = "concl-number", "05"),
                div(
                  h6("Baja multicolinealidad en variables PCA", class = "fw-bold"),
                  p("Las componentes V1–V28 presentan VIF bajos, lo que confirma la ortogonalidad del PCA. Solo Amount muestra multicolinealidad severa (VIF = 12.30), 
                    por lo que podría generar redundancia al incluirse junto al resto.",
                    class = "text-muted small")
                )
            ),
            
            div(class = "concl-item mt-3",
                span(class = "concl-number", "06"),
                div(
                  h6("Fraude en transacciones de monto bajo", class = "fw-bold"),
                  p("La mediana del monto en fraude (9.82 €) es menor que en no fraude (22 €), esto sugiere que el fraude típico no ocurre en transacciones de alto valor. 
                    También, la distribución de Amount es muy asimétrica en ambas clases.",
                    class = "text-muted small")
                )
            )
            
          ),
            

            
        )
      ),
      
      br(),
      
      div(
        style = "margin-top: 10px; color: black; font-weight: bold; border-left: 4px solid #2e86c1; padding-left: 12px; font-size: 20px;",
        p("Conclusión")
      ),
      
      content_card(
        title = "Conclusión general",
        p("El EDA del dataset de fraude en transacciones con tarjeta de crédito permitió identificar patrones que diferencian las transacciones fraudulentas de las no 
          fraudulentas. A lo largo de este se aplicaron técnicas descriptivas univariadas y bivariadas, pruebas no paramétricas (U de Mann-Whitney), medidas de tamaño de 
          efecto (RBC), análisis de correlación de Spearman y cálculo de VIF, que nos permiten entender las variables."),
        
        p("Las variables con mayor capacidad discriminativa son las componentes PCA V14, V12, V4, V11 y V10, todas con RBC > 0.8 en valor absoluto y rangos intercuartílicos 
          sin solapamiento entre clases. En contraste, a pesar de que Time y Amount son estadísticamente significativas, tienen un tamaño de efecto pequeño y mucho solapamiento, 
          es decir no discriminan de forma efectiva solas. Algo importante es que las transacciones fraudulentas muestran patrones de correlación interna más fuertes entre 
          V1–V18 que las no fraudulentas, esto muestra una estructura consistente en la clase minoritaria."),
        
        p("El fuerte desbalance de clases (99.83% vs 0.17%) es el principal desafío para el futuro modelo. También, la multicolinealidad de Amount (VIF = 12.30) dice 
          que hay que tener cuidado al incluirla junto con el resto de variables en el modelo. En general, el EDA muestra que las componentes PCA con alto poder 
          discriminativo van a ser las variables más valiosas para el modelado, mientras que Time y Amount necesitan transformaciones o combinación con otras variables 
          para mejorar su aporte al modelo.")
      ),
      
      br(),
      
      div(
        style = "margin-top: 10px; color: black; font-weight: bold; border-left: 4px solid #2e86c1; padding-left: 12px; font-size: 20px;",
        p("Pasos futuros")
      ),
      
      div(
        style = "margin-top: 10px; font-size: 15px; color: #6c757d;",
        p("Principales hallazgos del análisis exploratorio del dataset de fraude en transacciones con tarjeta de crédito.")
      ),
      
      br(),
      
      layout_columns(
        col_widths = c(6, 6),
        
        objetivo_card(1, "Modelado predictivo base",
                      p("Implementar un modelo de regresión logística como modelo base de clasificación binaria, para aprovechar las componentes PCA con alto poder 
                        discriminativo que se identificaron.")
        ),
        
        objetivo_card(2, "Técnicas de balanceo de clases",
                      p("Aplicar SMOTE o undersampling por el desbalance (0.17% fraude) y así, mejorar la capacidad del modelo para aprender patrones de la clase fraude.")
        ),
        
        objetivo_card(3, "Métricas ajustadas al desbalance",
                      p("Se debe evaluar el modelo con métricas como F1-score, AUC-ROC y Recall, pues si se usa accuracy, se pueden tener scores altos a pesar del bajo 
                        desempeño en la detección del fraude.")
        ),
        
        objetivo_card(4, "Comparación entre clases",
                      p("Usar modelos más complejos como Random Forest o XGBoost después de la regresión logística base, para evaluar relaciones no lineales entre 
                        las variables predictoras y la objetivo (Class).")
        ),
        
      ),
      
      br(),
      
      div(
        style = "margin-top: 10px; color: black; font-weight: bold; border-left: 4px solid #2e86c1; padding-left: 12px; font-size: 20px;",
        p("Referencias")
      ),
      
      content_card(
        title = "Referencias",
        p("Microblink. (s.f.). Fraude con tarjetas de crédito. https://microblink.com/es/resources/glossary/credit-card-fraud/"),
        
        p("Buonaguidi, B. (2017). Cómo se producen los fraudes con tarjeta de crédito. Euromonitor International."),
        
        p("Bolton, R. J., & Hand, D. J. (2002). Statistical Fraud Detection: A Review. Statistical Science, 17(3), 235–255."),
        
        p("Tarazona Nieto et al. (2022). Detección de fraude financiero mediante técnicas de machine learning. Revisión sistemática de literatura."),
        
        p("Dal Pozzolo, A. et al. (2015). Calibrating probability with undersampling for unbalanced classification. IEEE SSCI."),
        
        p("Hosmer, D. W., Lemeshow, S., & Sturdivant, R. X. (2013). Applied Logistic Regression (3rd ed.). Wiley.")
      )
      
      
      
      
      
      
      
      
        

    )
}

conclusionesServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    # Contenido estático
  })
}