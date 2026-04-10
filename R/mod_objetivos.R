# R/mod_objetivos.R

objetivosUI <- function(id) {
  ns <- NS(id)
  
  div(class = "page-fade-in",
      
      content_card(
        title = "Objetivo General",
        p("Diseñar y desarrollar un dashboard interactivo que permita visualizar y analizar la interacción entre las variables de las transacciones con tarjeta de 
          crédito, con la implementación de un modelo de predicción que facilite la identificación de patrones asociados al fraude y contribuya a la detección 
          temprana de transacciones fraudulentas.")
      ),
      
      br(),
      
      div(
        style = "margin-top: 10px; font-size: 14px; color: black; font-weight: bold; border-left: 4px solid #2e86c1; padding-left: 12px; font-size: 20px;",
        p("Objetivos específicos")
      ),
      
      layout_columns(
        col_widths = c(3, 3, 3, 3),
        
        objetivo_card(1, "Descripción del dataset",
          p("Describir el dataset, su estructura general, los tipos de variables que se encuentran y realizar estadísticas descriptivas de estas.")
        ),
        
        objetivo_card(2, "Evaluación del desbalance",
          p("Analizar el desbalance de la variable respuesta (Class) y evaluar las posibles implicaciones en la detección de fraude.")
        ),
        
        objetivo_card(3, "Análisis distribucional",
          p("Estudiar la distribución de las variables, por medio de análisis univariado usando estadísticas descriptivas y visualizaciones interactivas.")
        ),
        
        objetivo_card(4, "Comparación entre clases",
          p("Comparar las características de las transacciones fraudulentas y no fraudulentas mediante análisis descriptivos.")
        ),
        
      ),  
      
      layout_columns(
        col_widths = c(3, 3, 3, 3),
        
        objetivo_card(5, "Identificación de patrones",
          p("Identificar posibles patrones asociados al fraude a partir del análisis bivariado y multivariado de las variables.")
        ),
        
        objetivo_card(6, "Análisis de correlación",
          p("Notar posibles relaciones entre variables mediante el coeficiente de correlación de Spearman y el cálculo del VIF.")
        ),
        
        objetivo_card(7, "Modelo predictivo",
          p("Entrenar y evaluar un modelo de regresión logística mediante GridSearchCV y validación estratificada.")
        ),
        
        objetivo_card(8, "Sistema de predicción",
          p("Crear un formulario que le permita al usuario ingresar características de una transacción y poder predecir si es fraudulenta.")
        )
      )
      
  )
}

objetivosServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    # Contenido estático
  })
}