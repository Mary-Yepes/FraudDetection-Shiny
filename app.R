# app.R
# Aplicación principal - EDA Fraude Financiero
# Autoras: Alejandra Meneses & Mariangel Yepes

library(shiny)
library(bslib)
library(dplyr)
library(ggplot2)
library(plotly)
library(DT)
library(scales)
library(corrplot)
library(car)

# Cargar utilidades y preparación de datos
source("R/utils.R")
source("data_prep.R")

# Cargar módulos
source("R/mod_introduccion.R")
source("R/mod_contexto.R")
source("R/mod_problema.R")
source("R/mod_objetivos.R")
source("R/mod_marco_teorico.R")
source("R/mod_metodologia.R")
source("R/mod_resultados.R")
source("R/mod_limitaciones.R")
source("R/mod_conclusiones.R")
source("R/mod_dataset.R")
source("R/mod_equipo.R")


# ── VISTA INICIO ──────────────────────────────────────────────────────────────
vistaInicio <- function() {
  div(class = "page-fade-in",
      # Header hero
      div(class = "hero-header",
          div(class = "hero-header-left",
              div(class = "top-header-title", "Detección de Fraude Financiero"),
              div(class = "top-header-subtitle",
                  "Credit Card Fraud Detection · ULB Dataset · Regresión Logística")
          ),
          div(class = "hero-header-right",
              actionButton("ir_inicio",    "Inicio",    class = "hero-nav-btn active"),
              actionButton("ir_dashboard", "Dashboard", class = "hero-nav-btn"),
              actionButton("ir_equipo",    "Equipo",    class = "hero-nav-btn")
          )
      ),
      
      # ── HERO BODY NUEVO ──────────────────────────────────────────────────────
      div(class = "hero-body-new",
          
          # Fondo con partículas decorativas SVG
          tags$div(class = "hero-bg-deco",
                   tags$svg(
                     class = "hero-deco-svg",
                     viewBox = "0 0 1400 700",
                     xmlns = "http://www.w3.org/2000/svg",
                     preserveAspectRatio = "xMidYMid slice",
                     # Círculos de fondo decorativos
                     tags$circle(cx="1100", cy="120", r="280", fill="rgba(74,111,165,0.12)"),
                     tags$circle(cx="1300", cy="500", r="180", fill="rgba(46,134,193,0.08)"),
                     tags$circle(cx="200",  cy="600", r="220", fill="rgba(30,52,96,0.3)"),
                     tags$circle(cx="50",   cy="100", r="120", fill="rgba(74,111,165,0.07)"),
                     # Líneas de grilla decorativas
                     tags$line(x1="0", y1="350", x2="1400", y2="350",
                               stroke="rgba(74,111,165,0.08)", `stroke-width`="1"),
                     tags$line(x1="700", y1="0", x2="700", y2="700",
                               stroke="rgba(74,111,165,0.08)", `stroke-width`="1")
                   )
          ),
          
          # ── COLUMNA IZQUIERDA: TEXTO PRINCIPAL ────────────────────────────────
          div(class = "hero-left-col",
              
              # Eyebrow tag
              div(class = "hero-eyebrow",
                  tags$i(class = "fas fa-shield-alt"), " Análisis de Fraude · ULB Dataset"
              ),
              
              # Título grande
              tags$h1(class = "hero-big-title",
                      "Detección de", tags$br(),
                      tags$span(class = "hero-title-accent", "Fraude"), " con", tags$br(),
                      "Tarjeta de Crédito"
              ),
              
              # Descripción corta
              p(class = "hero-short-desc",
                "284K transacciones reales · Regresión Logística · EDA completo"
              ),
              
              # Botones de acción
              div(class = "hero-actions",
                  div(class = "hero-action-btn hero-action-primary",
                      onclick = "Shiny.setInputValue('hero_dashboard', Math.random())",
                      tags$i(class = "fas fa-th-large"), " Ver Dashboard"
                  ),
                  tags$a(
                    href = "https://github.com/Mary-Yepes/FraudDetection-Shiny",
                    target = "_blank",
                    class = "hero-action-btn hero-action-secondary",
                    tags$i(class = "fab fa-github"), " GitHub"
                  )
              )
          ),
          
          # ── COLUMNA DERECHA: CARDS FLOTANTES ──────────────────────────────────
          div(class = "hero-right-col",
              
              # Card 1 — Total transacciones
              div(class = "float-card float-card-1",
                  div(class = "float-card-icon-wrap fc-blue",
                      tags$i(class = "fas fa-exchange-alt")
                  ),
                  div(class = "float-card-content",
                      div(class = "float-card-value", "284,807"),
                      div(class = "float-card-label", "Transacciones totales")
                  )
              ),
              
              # Card 2 — Fraudes detectados
              div(class = "float-card float-card-2",
                  div(class = "float-card-icon-wrap fc-red",
                      tags$i(class = "fas fa-exclamation-triangle")
                  ),
                  div(class = "float-card-content",
                      div(class = "float-card-value", "492"),
                      div(class = "float-card-label", "Fraudes detectados")
                  )
              ),
              
              # Card 3 — Tasa de fraude
              div(class = "float-card float-card-3",
                  div(class = "float-card-icon-wrap fc-amber",
                      tags$i(class = "fas fa-percentage")
                  ),
                  div(class = "float-card-content",
                      div(class = "float-card-value", "0.172%"),
                      div(class = "float-card-label", "Tasa de fraude")
                  )
              ),
              
              # Card 4 — Variables PCA
              div(class = "float-card float-card-4",
                  div(class = "float-card-icon-wrap fc-green",
                      tags$i(class = "fas fa-project-diagram")
                  ),
                  div(class = "float-card-content",
                      div(class = "float-card-value", "28 PCA"),
                      div(class = "float-card-label", "Variables anónimas")
                  )
              ),
              
              # Card 5 — Modelo
              div(class = "float-card float-card-5",
                  div(class = "float-card-icon-wrap fc-purple",
                      tags$i(class = "fas fa-brain")
                  ),
                  div(class = "float-card-content",
                      div(class = "float-card-value", "AUC 0.97"),
                      div(class = "float-card-label", "Regresión Logística")
                  )
              ),
              
              # Mini gráfico decorativo de barras
              div(class = "float-mini-chart",
                  div(class = "mini-chart-label", "Distribución de clases"),
                  div(class = "mini-bars",
                      div(class = "mini-bar-wrap",
                          div(class = "mini-bar mini-bar-legit", style="height:55px"),
                          div(class = "mini-bar-txt", "99.8%"),
                          div(class = "mini-bar-sub", "Legítimas")
                      ),
                      div(class = "mini-bar-wrap",
                          div(class = "mini-bar mini-bar-fraud", style="height:6.5px"),
                          div(class = "mini-bar-txt", "0.17%"),
                          div(class = "mini-bar-sub", "Fraudes")
                      )
                  )
              ),
              
              # Links extra — Kaggle y Equipo
              div(class = "float-links",
                  tags$a(
                    href = "https://www.kaggle.com/datasets/mlg-ulb/creditcardfraud",
                    target = "_blank",
                    class = "float-link-pill",
                    tags$i(class = "fas fa-database"), " Kaggle"
                  ),
                  div(class = "float-link-pill",
                      onclick = "Shiny.setInputValue('hero_equipo', Math.random())",
                      tags$i(class = "fas fa-users"), " Equipo"
                  )
              )
          )
      ),
      
      # Footer
      div(class = "hero-footer",
          "Proyecto de análisis de fraude financiero · R · Shiny · Regresión Logística"
      )
  )
}

# ── VISTA DASHBOARD ───────────────────────────────────────────────────────────
vistaDashboard <- function(current_page) {
  div(
    tags$div(style = "margin:0; padding:0; width:100%;",
             tags$div(class = "top-header",
                      style = "display:flex; justify-content:space-between; align-items:center;",
                      tags$div(
                        tags$div(class = "top-header-title", "Detección de Fraude Financiero"),
                        tags$div(class = "top-header-subtitle",
                                 "Credit Card Fraud Detection · ULB Dataset · EDA")
                      ),
                      div(class = "hero-header-right",
                          actionButton("ir_inicio",    "Inicio",    class = "hero-nav-btn"),
                          actionButton("ir_dashboard", "Dashboard", class = "hero-nav-btn active"),
                          actionButton("ir_equipo",    "Equipo",    class = "hero-nav-btn")
                      )
             ),
             tags$div(class = "top-navbar",
                      tags$div(class = "top-navbar-inner",
                               tags$button("Introducción",  class = "top-nav-btn",
                                           onclick = "Shiny.setInputValue('nav_click','nav_intro',{priority:'event'})"),
                               tags$button("Contexto",      class = "top-nav-btn",
                                           onclick = "Shiny.setInputValue('nav_click','nav_contexto',{priority:'event'})"),
                               tags$button("Problema",      class = "top-nav-btn",
                                           onclick = "Shiny.setInputValue('nav_click','nav_problema',{priority:'event'})"),
                               tags$button("Objetivos",     class = "top-nav-btn",
                                           onclick = "Shiny.setInputValue('nav_click','nav_objetivos',{priority:'event'})"),
                               tags$button("Marco teórico", class = "top-nav-btn",
                                           onclick = "Shiny.setInputValue('nav_click','nav_marco',{priority:'event'})"),
                               tags$button("Metodología",   class = "top-nav-btn",
                                           onclick = "Shiny.setInputValue('nav_click','nav_metodologia',{priority:'event'})"),
                               tags$button("Dataset",   class = "top-nav-btn",
                                           onclick = "Shiny.setInputValue('nav_click','nav_dataset',{priority:'event'})"),
                               tags$button("Resultados",    class = "top-nav-btn",
                                           onclick = "Shiny.setInputValue('nav_click','nav_resultados',{priority:'event'})"),
                               tags$button("Limitaciones",  class = "top-nav-btn",
                                           onclick = "Shiny.setInputValue('nav_click','nav_limitaciones',{priority:'event'})"),
                               tags$button("Conclusiones",  class = "top-nav-btn",
                                           onclick = "Shiny.setInputValue('nav_click','nav_conclusiones',{priority:'event'})")
                      )
             )
    ),
    div(class = "main-content",
        uiOutput("page_content")
    )
  )
}

# ── VISTA EQUIPO ──────────────────────────────────────────────────────────────
vistaEquipo <- function() {
  div(class = "page-fade-in",
      div(class = "hero-header",
          div(class = "hero-header-left",
              div(class = "top-header-title", "Detección de Fraude Financiero"),
              div(class = "top-header-subtitle",
                  "Credit Card Fraud Detection · ULB Dataset · Regresión Logística")
          ),
          div(class = "hero-header-right",
              actionButton("ir_inicio",    "Inicio",    class = "hero-nav-btn"),
              actionButton("ir_dashboard", "Dashboard", class = "hero-nav-btn"),
              actionButton("ir_equipo",    "Equipo",    class = "hero-nav-btn active")
          )
      ),
      
      # Body equipo con fondo degradado igual que hero
      div(class = "equipo-body-new",
          
          div(class = "equipo-hero-text",
              div(class = "hero-eyebrow",
                  tags$i(class = "fas fa-users"), " Nuestro Equipo"
              ),
              tags$h2(class = "equipo-big-title",
                      "Las personas detrás", tags$br(),
                      tags$span(class = "hero-title-accent", "del análisis")
              ),
              p(class = "hero-short-desc",
                "Estudiantes de Ciencia de Datos · Universidad del Norte · Barranquilla"
              )
          ),
          
          div(class = "equipo-cards-new",
              
              # Persona 1
              div(class = "equipo-card-new",
                  div(class = "equipo-card-accent"),
                  div(class = "equipo-card-body-new",
                      div(class = "equipo-avatar",
                          tags$i(class = "fas fa-user-circle")
                      ),
                      h4("Alejandra Meneses Gómez", class = "equipo-nombre-new"),
                      span("ESTUDIANTE · CIENCIA DE DATOS & MATEMÁTICAS", class = "equipo-badge-new"),
                      div(class = "equipo-info-row",
                          div(class = "equipo-info-item",
                              p(class = "equipo-info-label-new", "INSTITUCIÓN"),
                              p(class = "equipo-info-val-new",   "Universidad del Norte")
                          )
                      ),
                      div(class = "equipo-links-new",
                          tags$a(href = "https://github.com/alemengo76", target = "_blank",
                                 class = "equipo-pill",
                                 tags$i(class = "fab fa-github"), " GitHub"),
                          tags$a(href = "https://www.linkedin.com/in/alejandra-meneses-g%C3%B3mez-aaa97b3b7/",
                                 target = "_blank",
                                 class = "equipo-pill",
                                 tags$i(class = "fab fa-linkedin"), " LinkedIn")
                      )
                  )
              ),
              
              # Persona 2
              div(class = "equipo-card-new",
                  div(class = "equipo-card-accent"),
                  div(class = "equipo-card-body-new",
                      div(class = "equipo-avatar",
                          tags$i(class = "fas fa-user-circle")
                      ),
                      h4("Mariangel Yepes Negrete", class = "equipo-nombre-new"),
                      span("ESTUDIANTE · CIENCIA DE DATOS", class = "equipo-badge-new"),
                      div(class = "equipo-info-row",
                          div(class = "equipo-info-item",
                              p(class = "equipo-info-label-new", "INSTITUCIÓN"),
                              p(class = "equipo-info-val-new",   "Universidad del Norte")
                          )
                      ),
                      div(class = "equipo-links-new",
                          tags$a(href = "https://github.com/mary-yepes", target = "_blank",
                                 class = "equipo-pill",
                                 tags$i(class = "fab fa-github"), " GitHub")
                      )
                  )
              )
          ),
          
          div(class = "hero-footer",
              "Proyecto de análisis de fraude financiero · R · Shiny · Regresión Logística"
          )
      )
  )
}


# ── UI ────────────────────────────────────────────────────────────────────────
ui <- fluidPage(
  theme = app_theme(),
  style = "padding: 0 !important; margin: 0 !important; max-width: 100% !important;",
  
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css"),
    tags$link(rel = "stylesheet",
              href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"),
    tags$script(HTML("
      $(document).on('shiny:value', function(e) {
        $('.main-content').addClass('fade-in');
        setTimeout(function() { $('.main-content').removeClass('fade-in'); }, 600);
      });
      $(document).on('click', '.top-nav-btn', function() {
        $('.top-nav-btn').removeClass('active');
        $(this).addClass('active');
      });
      $(document).on('click', '.hero-nav-btn', function() {
        $('.hero-nav-btn').removeClass('active');
        $(this).addClass('active');
      });
      $(document).on('mouseenter', '.asikurto-card', function() {
        $(this).css('transform', 'translateY(-10px)');
      }).on('mouseleave', '.asikurto-card', function() {
        $(this).css('transform', 'translateY(0)');
      });
    "))
  ),
  
  uiOutput("vista_completa")
)

# ── SERVER ────────────────────────────────────────────────────────────────────
server <- function(input, output, session) {
  
  vista <- reactiveVal("inicio")
  current_page <- reactiveVal("nav_intro")
  
  observeEvent(input$ir_dashboard, { vista("dashboard") })
  observeEvent(input$ir_equipo,    { vista("equipo") })
  observeEvent(input$ir_inicio,    { vista("inicio") })
  observeEvent(input$hero_dashboard, { vista("dashboard") })
  observeEvent(input$hero_equipo,    { vista("equipo") })
  observeEvent(input$nav_click, { current_page(input$nav_click) })
  
  output$vista_completa <- renderUI({
    if (vista() == "inicio") {
      vistaInicio()
    } else if (vista() == "equipo") {
      vistaEquipo()
    } else {
      vistaDashboard(current_page())
    }
  })
  
  output$page_content <- renderUI({
    page <- current_page()
    switch(page,
           "nav_intro"        = introduccionUI("intro"),
           "nav_contexto"     = contextoUI("ctx"),
           "nav_problema"     = problemaUI("prob"),
           "nav_objetivos"    = objetivosUI("obj"),
           "nav_marco"        = marcoTeoricoUI("marco"),
           "nav_metodologia"  = metodologiaUI("meto"),
           "nav_dataset"      = datasetUI("data"),
           "nav_resultados"   = resultadosUI("res"),
           "nav_limitaciones" = limitacionesUI("lim"),
           "nav_conclusiones" = conclusionesUI("conc"),
           introduccionUI("intro")
    )
  })
  
  introduccionServer("intro", df = df_clean)
  contextoServer("ctx",       df = df_clean)
  problemaServer("prob",      df = df_clean)
  objetivosServer("obj")
  marcoTeoricoServer("marco")
  metodologiaServer("meto")
  datasetServer("data",       df = df_clean)
  resultadosServer("res",     df = df_clean)
  limitacionesServer("lim")
  conclusionesServer("conc")
}

shinyApp(ui, server)