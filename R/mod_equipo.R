# R/mod_equipo.R

EquipoUI <- function(id) {
  ns <- NS(id)
  
  div(class = "page-fade-in",
      
      div(
        style = "margin-top: 10px; color: black; font-weight: bold; border-left: 4px solid #2e86c1; padding-left: 12px; font-size: 17px;",
        p("Equipo")
      ),
      
      br(),
      
      layout_columns(
        col_widths = c(6, 6),
        
        # ── PERSONA 1 ──
        div(
          class = "team-card",
          
          div(class = "team-name", "Alejandra Meneses Gómez"),
          div(class = "team-info", "Universidad del Norte"),
          div(class = "team-info", "Ciencia de datos"),
          
          div(class = "team-icons",
              tags$a(href = "https://github.com/alemengo76", target = "_blank",
                     tags$i(class = "fab fa-github")),
              tags$a(href = "https://www.linkedin.com/in/alejandra-meneses-g%C3%B3mez-aaa97b3b7/", target = "_blank",
                     tags$i(class = "fab fa-linkedin"))
          )
        ),
        
        # ── PERSONA 2 ──
        div(
          class = "team-card",
          
          div(class = "team-name", "Mariangel Yepes Negrete"),
          div(class = "team-info", "Universidad del Norte"),
          div(class = "team-info", "Ciencia de datos"),
          
          div(class = "team-icons",
              tags$a(href = "https://github.com/Mary-Yepes", target = "_blank",
                     tags$i(class = "fab fa-github"))
          )
        )
      )
  )
}

EquipoServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    # Contenido estático
  })
}