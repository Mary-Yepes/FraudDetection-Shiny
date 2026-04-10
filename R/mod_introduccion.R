# R/mod_introduccion.R

introduccionUI <- function(id) {
  ns <- NS(id)
  
  div(class = "page-fade-in",
      layout_columns(
        col_widths = c(12),
        
        content_card(
          title = "Fraude en Transacciones con Tarjeta de Crédito",
          p("El fraude en transacciones con tarjeta de crédito de los principales peligros para las personas y entidades financieras a nivel mundial, entonces, poder 
            detectarlo a tiempo es importante para reducir las pérdidas económicas, proteger a los clientes y mantener la confianza en los sistemas de pago electrónico."),
        ),
        
      ),
      
      br(),
      
      layout_columns(
        col_widths = c(4, 4, 4),
        
        content_card(
          title    = "Origen del problema",
          p("El fraude con tarjeta de crédito apareció por primera vez en la década de los 80, cuando hubo un aumento significativo de los pagos electrónicos 
            (Buonaguidi, 2017). Debido a esto, las instituciones financieras desarrollaron sistemas manuales para detectar actividades sospechosas. 
            Luego empezaron a utilizar métodos estadísticos, y con el tiempo, se fueron incorporando técnicas de aprendizaje automático (Bolton & Hand, 2002; 
            Tarazona Nieto et al., 2022).")
        ),
        
        content_card(
          title    = "Desafío principal",
          p("Una de las principales características que dificultan la detección del las transacciones fraudulentas es que es poco frecuente en comparación con las 
            transacciones legítimas, por lo que hay un problema de desbalance de clases, lo que hace que la clase minoritaria esté subrepresentada y se afecte el 
            análisis exploratorio y el rendimiento de los modelos.")
        ),
        
        content_card(
          title    = "Dataset utilizado",
          p("El análisis se basa en el dataset Credit Card Fraud Detection (Kaggle / ULB Machine Learning Group), el cual tiene las transacciones reales realizadas por 
            titulares de tarjetas de crédito europeos durante dos días de septiembre de 2013. Las variables originales fueron anonimizadas por PCA, y se conservaron Time, 
            Amount y la variable objetivo Class.")
        )
      ),
      
      div(
        style = "margin-top: 10px; font-size: 14px; color: black; font-weight: bold; border-left: 4px solid #2e86c1; padding-left: 12px; font-size: 15px;",
        p("Impacto en el sistema financiero")
      ),
      
      HTML('
      
        <div style="padding: 0.5rem 0;">
          <p style="font-size: 14px; color: #6c757d; margin: 0 0 1rem;">
            El fraude financiero no se limita a una pérdida económica, sus efectos van más allá:
          </p>
          <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 12px;">
            
            <div style="background: white; border-radius: 10px; border: 0.5px solid #dee2e6; padding: 1rem 1.25rem;">
              <div style="width: 32px; height: 3px; background: #4a6fa5; border-radius: 2px; margin-bottom: 10px;"></div>
              <p style="font-size: 14px; font-weight: 500; margin: 0 0 6px;">Pérdidas directas</p>
              <p style="font-size: 13px; color: #6c757d; margin: 0; line-height: 1.5;">Cargos no autorizados que afectan al banco y al cliente.</p>
            </div>
        
            <div style="background: white; border-radius: 10px; border: 0.5px solid #dee2e6; padding: 1rem 1.25rem;">
              <div style="width: 32px; height: 3px; background: #4a6fa5; border-radius: 2px; margin-bottom: 10px;"></div>
              <p style="font-size: 14px; font-weight: 500; margin: 0 0 6px;">Costos operacionales</p>
              <p style="font-size: 13px; color: #6c757d; margin: 0; line-height: 1.5;">Investigación, reversión de transacciones y atención al cliente.</p>
            </div>
        
            <div style="background: white; border-radius: 10px; border: 0.5px solid #dee2e6; padding: 1rem 1.25rem;">
              <div style="width: 32px; height: 3px; background: #4a6fa5; border-radius: 2px; margin-bottom: 10px;"></div>
              <p style="font-size: 14px; font-weight: 500; margin: 0 0 6px;">Falsos positivos</p>
              <p style="font-size: 13px; color: #6c757d; margin: 0; line-height: 1.5;">Bloquear tarjetas legítimas genera molestias y pérdida de confianza.</p>
            </div>
        
            <div style="background: white; border-radius: 10px; border: 0.5px solid #dee2e6; padding: 1rem 1.25rem;">
              <div style="width: 32px; height: 3px; background: #4a6fa5; border-radius: 2px; margin-bottom: 10px;"></div>
              <p style="font-size: 14px; font-weight: 500; margin: 0 0 6px;">Daño reputacional</p>
              <p style="font-size: 13px; color: #6c757d; margin: 0; line-height: 1.5;">Incidentes recurrentes afectan la credibilidad de los bancos.</p>
            </div>
        
          </div>
        </div>
      '),
      
      br(),
      
      div(
        style = "margin-top: 10px; font-size: 14px; color: black; font-weight: bold; border-left: 4px solid #2e86c1; padding-left: 12px; font-size: 15px;",
        p("Sobre este dashboard")
      ),
      
      div(
        style = "margin-top: 10px; font-size: 14px; color: #6c757d;",
        p("Esta aplicación integra el análisis exploratorio, las pruebas estadísticas y en el futuro, el modelo predictivo. Lo que permite analizar patrones de 
          las variables, y en un futuro evaluar el modelo y hacer predicciones.")
      )
   
  )
}

introduccionServer <- function(id, df) {
  moduleServer(id, function(input, output, session) {
    # Sin outputs reactivos en esta pestaña; contenido estático
  })
}