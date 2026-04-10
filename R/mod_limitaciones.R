limitacionesUI <- function(id) {
  ns <- NS(id)
  
  div(class = "page-fade-in",
      
      div(
        style = "margin-top: 10px; color: black; font-weight: bold; border-left: 4px solid #2e86c1; padding-left: 12px; font-size: 17px;",
        p("Limitaciones")
      ),
      
      div(
        style = "margin-top: 10px; font-size: 15px; color: #6c757d;",
        p("Todo análisis exploratorio está sujeto a restricciones que se derivan de los datos, la metodología y el contexto. 
        A continuación se detallan las principales limitaciones identificadas en este proyecto.")
      ),
      
      br(),
      
      layout_columns(
        col_widths = c(4, 4, 4),
        fill = FALSE,
        
        card(
          fill = FALSE, class = "eda-card",
          card_header(class = "eda-card-header",
                      style = "background: linear-gradient(135deg, #0d2137 0%, #123354 100%) !important;
                   border-top: 2px solid #1a5276 !important; border-bottom: 2px solid #1a5276 !important;",
                      h5("Desbalance extremo de clases", class = "card-title-text", style = "margin:0;")
          ),
          card_body(class = "eda-card-body",
                    p("La clase fraude representa solo el 0.17% del total (473 de 283.726 transacciones). Esto afecta directamente el análisis exploratorio, pues 
            las correlaciones globales las domina la clase mayoritaria, los estadísticos descriptivos generales no reflejan el comportamiento real de las transacciones 
            fraudulentas y las pruebas estadísticas pueden detectar diferencias significativas que en la práctica tienen un efecto muy pequeño.")
          )
        ),
        
        card(
          fill = FALSE, class = "eda-card",
          card_header(class = "eda-card-header",
                      style = "background: linear-gradient(135deg, #0a2744 0%, #0f3d6b 100%) !important;
                   border-top: 2px solid #2471a3 !important; border-bottom: 2px solid #2471a3 !important;",
                      h5("Dependencia de la transformación PCA", class = "card-title-text", style = "margin:0;")
          ),
          card_body(class = "eda-card-body",
                    p("Las variables V1–V28 son componentes principales que anonimizan las variables originales del dataset y limita la interpretabilidad del análisis, porque no se puede conocer qué características reales del comportamiento del usuario corresponden a cada componente, lo que dificulta sacar conclusiones de negocio directamente a partir de los hallazgos del EDA.")
          )
        ),
        
        card(
          fill = FALSE, class = "eda-card",
          card_header(class = "eda-card-header",
                      style = "background: linear-gradient(135deg, #0d3052 0%, #144a7a 100%) !important;
                   border-top: 2px solid #2980b9 !important; border-bottom: 2px solid #2980b9 !important;",
                      h5("Datos de un único período", class = "card-title-text", style = "margin:0;")
          ),
          card_body(class = "eda-card-body",
                    p("El dataset contiene transacciones de dos días de septiembre de 2013 únicamente, y realmente los patrones de fraude pueden variar estacionalmente y con el tiempo, por lo que los hallazgos del análisis exploratorio podrían no generalizarse a períodos diferentes o a contextos geográficos distintos al europeo.")
          )
        )
      ),
      
      br(),
      
      layout_columns(
        col_widths = c(4, 4, 4),
        fill = FALSE,
        
        card(
          fill = FALSE, class = "eda-card",
          card_header(class = "eda-card-header",
                      style = "background: linear-gradient(135deg, #103a5e 0%, #1a5585 100%) !important;
                   border-top: 2px solid #3498db !important; border-bottom: 2px solid #3498db !important;",
                      h5("Ausencia de contexto externo", class = "card-title-text", style = "margin:0;")
          ),
          card_body(class = "eda-card-body",
                    p("El análisis solo puede trabajar con las variables disponibles en el dataset. Variables que podrían enriquecer el EDA y mejorar la comprensión del fraude, como el historial de los titulares de tarjetas de crédito, la geolocalización de la transacción, el tipo de comercio o el canal de pago, lamentablemente no están disponibles debido a restricciones de privacidad y limitan las inferencias útiles para detectar fraude.")
          )
        ),
        
        card(
          fill = FALSE, class = "eda-card",
          card_header(class = "eda-card-header",
                      style = "background: linear-gradient(135deg, #154468 0%, #1e6090 100%) !important;
                   border-top: 2px solid #5dade2 !important; border-bottom: 2px solid #5dade2 !important;",
                      h5("Sesgo de supervivencia", class = "card-title-text", style = "margin:0;")
          ),
          card_body(class = "eda-card-body",
                    p("El dataset solo contiene transacciones que fueron procesadas y registradas. Las transacciones que son bloqueadas preventivamente por sistemas de seguridad existentes no se incluyen, lo que podría sesgar los patrones identificados hacia fraudes que lograron evadir controles previos. Con esto en mente, se podría estar subestimando el fraude real y aprender patrones de fraudes exitosos y no de todos los intentos.")
          )
        ),
        
        card(
          fill = FALSE, class = "eda-card",
          card_header(class = "eda-card-header",
                      style = "background: linear-gradient(135deg, #1a4f72 0%, #236b9a 100%) !important;
                   border-top: 2px solid #85c1e9 !important; border-bottom: 2px solid #85c1e9 !important;",
                      h5("Inferencia limitada por tamaño muestral en fraude", class = "card-title-text", style = "margin:0;")
          ),
          card_body(class = "eda-card-body",
                    p("Con solo 473 transacciones fraudulentas, los estadísticos calculados para esta clase (medianas, correlaciones, distribuciones) tienen mucha variabilidad muestral. Puesto que, pequeñas diferencias entre observaciones individuales pueden generar correlaciones o patrones fuertes que no necesariamente reflejan la realidad, como se ve en el análisis temporal por hora.")
          )
        )
      )
  )
}

limitacionesServer <- function(id) {
  moduleServer(id, function(input, output, session) {})
}