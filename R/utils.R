# R/utils.R
# Funciones auxiliares y helpers de UI reutilizables

library(bslib)
library(shiny)
library(plotly)

# ── TEMA DE LA APLICACIÓN ─────────────────────────────────────────────────────
app_theme <- function() {
  bs_theme(
    version      = 5,
    base_font    = font_google("Inter"),
    heading_font = font_google("Inter"),
    code_font    = font_google("JetBrains Mono"),
    bg           = "#f7f8fc",
    fg           = "#1a1f2e",
    primary      = "#4a6fa5",
    secondary    = "#6c757d",
    success      = "#2e8b57",
    danger       = "#c0392b",
    `enable-rounded` = TRUE
  )
}

# ── CARD ESTÁNDAR ─────────────────────────────────────────────────────────────
# Wrapper de card con estilo consistente
content_card <- function(..., title = NULL, subtitle = NULL, 
                         full_screen = FALSE, class = "") {
  card(
    full_screen = full_screen,
    class       = paste("eda-card", class),
    if (!is.null(title)) {
      card_header(
        class = "eda-card-header",
        div(class = "card-title-block",
            h5(title, class = "card-title-text"),
            if (!is.null(subtitle)) p(subtitle, class = "card-subtitle-text")
        )
      )
    },
    card_body(
      class = "eda-card-body",
      ...
    )
  )
}


objetivo_card <- function(numero, title, ...) {
  card(
    class = "eda-card",
    fill  = FALSE,
    card_header(
      class = "eda-card-header",
      style = "display: flex; align-items: center; gap: 10px;",
      div(
        style = "min-width: 28px; height: 28px; border-radius: 50%; 
                 background: #2e86c1; color: white; font-size: 13px; 
                 font-weight: 700; display: flex; align-items: center; 
                 justify-content: center;",
        numero
      ),
      h5(title, class = "card-title-text", style = "margin: 0;")
    ),
    card_body(class = "eda-card-body", ...)
  )
}

# ── VALUE BOX PERSONALIZADO ───────────────────────────────────────────────────
value_card <- function(value, label, icon_name = NULL, 
                       bg_color = "
#4a6fa5", text_color = "
#ffffff",
                       extra_class = "") {
  
  if (extra_class == "asikurto-card") {
    return(
      div(
        class = paste("value-card", extra_class),
        style = sprintf(
          "background: %s; color: %s; display: flex; flex-direction: column;
           align-items: center; justify-content: center; text-align: center;
           border-top: 2px solid rgb(26, 37, 64); border-bottom: 2px solid rgb(26, 37, 64);
           min-height: 120px; gap: 0; transition: transform 0.7s ease;
           will-change: transform; position: relative; z-index: 10;
           box-shadow: 0 -3px 8px rgba(74,111,165,0.8), 0 3px 8px rgba(74,111,165,0.8);",
          bg_color, text_color
        ),
        div(style = "font-size: 32px; font-weight: bold; line-height: 1; color: black", value),
        div(style = "font-size: 0.6rem; opacity: 0.8; margin-top: 6px; color: darkgray", label)
      )
    )
  }
  
  div(
    class = paste("value-card", extra_class),
    style = sprintf("background: %s; color: %s;", bg_color, text_color),
    
    if (!is.null(icon_name)) {
      div(class = "value-card-icon",
          tags$i(class = paste("fas fa-", icon_name, sep = ""))
      )
    },
    
    div(class = "value-card-content",
        div(class = "value-card-value", value),
        div(class = "value-card-label", label)
    )
  )
}

# ── FILA DE VALUE CARDS ───────────────────────────────────────────────────────
value_cards_row <- function(...) {
  div(class = "value-cards-row", ...)
}

# ── SECCIÓN CON TÍTULO ────────────────────────────────────────────────────────
section_title <- function(title, subtitle = NULL, icon_name = NULL) {
  div(
    class = "section-header",
    div(class = "section-title-block",
        if (!is.null(icon_name)) {
          tags$i(class = paste("fas fa-", icon_name, " section-icon", sep = ""))
        },
        h3(title, class = "section-title")
    ),
    if (!is.null(subtitle)) p(subtitle, class = "section-subtitle")
  )
}

# ── BADGE DE CLASE ────────────────────────────────────────────────────────────
class_badge <- function(label, color = "primary") {
  span(class = paste("badge rounded-pill bg-", color, sep = ""), label)
}

# ── TABLA DT ESTÁNDAR ─────────────────────────────────────────────────────────
render_dt_standard <- function(data, caption = NULL) {
  DT::datatable(
    data,
    caption    = caption,
    extensions = "Buttons",
    options    = list(
      dom          = "Bfrtip",
      buttons      = c("copy", "csv"),
      pageLength   = 10,
      scrollX      = TRUE,
      autoWidth    = TRUE,
      language     = list(
        search      = "Buscar:",
        lengthMenu  = "Mostrar _MENU_ filas",
        info        = "Mostrando _START_ a _END_ de _TOTAL_ registros",
        paginate    = list(previous = "Anterior", `next` = "Siguiente")
      )
    ),
    rownames   = FALSE,
    class      = "table table-hover table-sm"
  )
}

# ── NAVEGACIÓN SIDEBAR ────────────────────────────────────────────────────────
nav_item_sidebar <- function(number, label, icon_name, id) {
  tags$button(
    class   = "sidebar-nav-btn",
    id      = paste0("btn_", id),
    onclick = sprintf(
      "Shiny.setInputValue('nav_click', '%s', {priority: 'event'})", id
    ),
    div(class = "nav-btn-inner",
        div(class = "nav-btn-left",
            span(class = "nav-btn-number", number),
            tags$i(class = paste("fas fa-", icon_name, " nav-btn-icon", sep = ""))
        ),
        span(class = "nav-btn-label", label)
    )
  )
}

build_amount_box <- function(df) {
  df_plot <- df %>%
    mutate(
      log_amount  = log1p(Amount),
      Class_label = factor(ifelse(Class == 1, "Fraude", "No Fraude"), 
                           levels = c("No Fraude", "Fraude"))
    )
  
  plot_ly(
    df_plot,
    x      = ~Class_label,
    y      = ~log_amount,
    color  = ~Class_label,
    colors = c("No Fraude" = "#4a6fa5", "Fraude" = "#c0392b"),
    type   = "box",
    hovertemplate = "<b>%{x}</b><br>log(Amount+1): %{y:.3f}<extra></extra>"
  ) %>%
    layout(
      title      = list(text = "Distribución del monto (escala logarítmica) por clase"),
      xaxis      = list(title = "Tipo"),
      yaxis      = list(title = "log(Amount + 1)", gridcolor = "#eeeeee"),
      showlegend = FALSE,
      plot_bgcolor  = "white",
      paper_bgcolor = "white",
      margin = list(t = 50, b = 40)
    )
}



build_corr_heatmap <- function(df, show_colorbar = TRUE) {
  vars_corr <- df %>%
    select(V1:V28, Amount, Time)
  
  corr_mat <- cor(vars_corr, method = "spearman", use = "complete.obs")
  
  plot_ly(
    z          = corr_mat,
    x          = colnames(corr_mat),
    y          = rownames(corr_mat),
    type       = "heatmap",
    colorscale = list(
      list(0,   "#c0392b"),
      list(0.5, "#f7f8fc"),
      list(1,   "#4a6fa5")
    ),
    zmin = -1, zmax = 1,
    showscale  = show_colorbar,                # ← oculta o muestra la barra
    colorbar   = list(
      len        = 1,                          # ← ocupa el 100% del alto
      lenmode    = "fraction",
      y          = 0.5,
      yanchor    = "middle"
    ),
    hovertemplate = "<b>X:</b> %{x}<br><b>Y:</b> %{y}<br><b>Corr:</b> %{z:.3f}<extra></extra>"
  ) %>%
    layout(
      yaxis = list(
        tickmode = "array",
        tickvals = rownames(corr_mat),
        ticktext = rownames(corr_mat)
      ),
      xaxis = list(tickangle = 45)
    )
}

build_vif_plot <- function(vif_data) {
  df_vif <- vif_data %>%
    arrange(.data$VIF)          # ← .data$ evita la ambigüedad
  
  colors <- ifelse(df_vif$VIF >= 10, "#e74c3c",
                   ifelse(df_vif$VIF >= 5,  "#f39c12", "#4a6fa5"))
  
  plot_ly(
    data         = df_vif,
    x            = ~VIF,
    y            = ~reorder(Variable, VIF),
    type         = "bar",
    orientation  = "h",
    marker       = list(color = colors),
    text         = ~round(VIF, 2),
    textposition = "outside",
    hovertemplate = "<b>%{y}</b><br>VIF: %{x:.2f}<extra></extra>"
  ) %>%
    layout(
      title  = "Factor de Inflación de la Varianza (VIF)",
      xaxis  = list(title = "VIF", range = c(0, 14), gridcolor = "#eee"),
      yaxis  = list(title = ""),
      height = 700,
      shapes = list(
        list(type = "line", x0 = 5,  x1 = 5,  y0 = 0, y1 = 1, yref = "paper",
             line = list(dash = "dash", color = "#f39c12", width = 1.5)),
        list(type = "line", x0 = 10, x1 = 10, y0 = 0, y1 = 1, yref = "paper",
             line = list(dash = "dash", color = "#e74c3c", width = 1.5))
      )
    )
}

build_rbc_plot <- function(rbc_data) {
  df_rbc <- as.data.frame(rbc_data) %>%
    arrange(RBC)
  
  colors <- ifelse(df_rbc$RBC < 0, "#e74c3c", "#4a6fa5")
  
  plot_ly(
    data        = df_rbc,
    x           = ~RBC,
    y           = ~reorder(Variable, RBC),
    type        = "bar",
    orientation = "h",
    marker      = list(color = colors),
    text        = ~round(RBC, 3),
    textposition = "outside",
    hovertemplate = "<b>%{y}</b><br>RBC: %{x:.3f}<extra></extra>"
  ) %>%
    layout(
      title  = "Coeficiente RBC por variable (capacidad discriminativa)",
      xaxis  = list(title = "RBC", range = c(-1.1, 1.1), gridcolor = "#eee"),
      yaxis  = list(title = ""),
      height = 700,
      shapes = list(
        list(type = "line", x0 =  0.5, x1 =  0.5, y0 = 0, y1 = 1, yref = "paper",
             line = list(dash = "dash", color = "#27ae60", width = 1.5)),
        list(type = "line", x0 = -0.5, x1 = -0.5, y0 = 0, y1 = 1, yref = "paper",
             line = list(dash = "dash", color = "#27ae60", width = 1.5))
      )
    )
}

obtener_vif <- function(var, datos) {
  otros   <- setdiff(colnames(datos), var)
  formula <- as.formula(paste(var, "~", paste(otros, collapse = "+")))
  modelo  <- lm(formula, data = datos)
  r2      <- summary(modelo)$r.squared
  return(1 / (1 - r2))
}

obtener_rbc <- function(var) {
  test <- wilcox.test(df_fraud[[var]], df_no_fraud[[var]], 
                      alternative = "two.sided", exact = FALSE)
  
  u_stat <- as.numeric(test$statistic)
  
  n1 <- length(df_fraud[[var]])   # ← largo del vector de la variable
  n2 <- length(df_no_fraud[[var]])
  
  rbc_val <- 1 - (2 * u_stat) / (n1 * n2)  # ← quitamos el - inicial
  return(rbc_val)
}



nav_menu_sidebar <- function(items) {
  div(class = "sidebar-nav", tagList(items))
}

# ── HELPER: COLORES POR CLASE ─────────────────────────────────────────────────
color_fraude    <- "#c0392b"
color_no_fraude <- "#4a6fa5"
color_accent    <- "#f39c12"

palette_clase <- c("No Fraude" = color_no_fraude, "Fraude" = color_fraude)

# ── HELPER: FORMATO NUMÉRICO ──────────────────────────────────────────────────
fmt_number <- function(x) formatC(x, format = "d", big.mark = ",")
fmt_pct    <- function(x) paste0(round(x, 2), "%")
fmt_euro   <- function(x) paste0("€", round(x, 2))

# ── PLOTLY LAYOUT ESTÁNDAR ────────────────────────────────────────────────────
plotly_layout <- function(fig, title = NULL, xlab = NULL, ylab = NULL) {
  fig %>% layout(
    title  = list(text = title, font = list(family = "Inter", size = 16, color = "#1a1f2e")),
    xaxis  = list(title = xlab, tickfont = list(family = "Inter"), gridcolor = "#e9ecef"),
    yaxis  = list(title = ylab, tickfont = list(family = "Inter"), gridcolor = "#e9ecef"),
    paper_bgcolor = "rgba(0,0,0,0)",
    plot_bgcolor  = "rgba(0,0,0,0)",
    font   = list(family = "Inter"),
    margin = list(t = 50, b = 50, l = 50, r = 30),
    legend = list(font = list(family = "Inter"))
  )
}