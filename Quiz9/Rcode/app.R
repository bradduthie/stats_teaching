library(shiny)

# ---------- Precision helpers (correct for sig figs) ----------

# Count significant figures from a string (e.g., "2.70" -> 3, "2.7" -> 2, "19.0" -> 3, "0.0003" -> 1)
count_sigfigs <- function(s) {
  s <- sub("^-", "", s)
  if (grepl("\\.", s)) {
    s_no_dec <- gsub("\\.", "", s)
    s_trim <- sub("^0+", "", s_no_dec)
    return(nchar(s_trim))
  } else {
    s_trim <- sub("^0+", "", s)
    return(nchar(s_trim))
  }
}

# Format a numeric value to a string with exactly `sigfigs` significant figures
format_sigfig <- function(x, sigfigs) {
  if (is.na(x) || sigfigs < 1) return(as.character(x))
  rounded <- signif(x, sigfigs)
  str <- format(rounded, scientific = FALSE, trim = TRUE)
  current_sig <- count_sigfigs(str)
  if (current_sig >= sigfigs) return(str)
  if (grepl("\\.", str)) {
    zeros_needed <- sigfigs - current_sig
    return(paste0(str, paste0(rep("0", zeros_needed), collapse = "")))
  } else {
    zeros_needed <- sigfigs - current_sig
    return(paste0(str, ".", paste0(rep("0", zeros_needed), collapse = "")))
  }
}

# Format with decimal places
format_decimal <- function(x, decimals) {
  sprintf(paste0("%.", decimals, "f"), x)
}

# Main formatting dispatcher
format_correct <- function(val, decimals = NULL, sigfigs = NULL) {
  if (!is.null(decimals)) return(format_decimal(val, decimals))
  if (!is.null(sigfigs)) return(format_sigfig(val, sigfigs))
  return(as.character(val))
}

# Count decimal places
count_decimals <- function(s) {
  if (!grepl("\\.", s)) return(0)
  nchar(sub("^.*\\.", "", s))
}

# Main numeric check: value within 2% tolerance (not disclosed), and precision matches
check_numeric <- function(user_str, correct_val, integer = FALSE, decimals = NULL, sigfigs = NULL) {
  if (is.null(user_str) || user_str == "") {
    return(list(correct = FALSE, explanation = "No answer provided.", close = FALSE))
  }
  user_num <- suppressWarnings(as.numeric(user_str))
  if (is.na(user_num)) {
    return(list(correct = FALSE, explanation = "Not a valid number.", close = FALSE))
  }
  
  if (integer) {
    if (grepl("\\.", user_str)) {
      return(list(correct = FALSE, explanation = "Please report as an integer (no decimal places).", close = FALSE))
    }
    if (abs(user_num - correct_val) < 1e-6) {
      return(list(correct = TRUE, explanation = NULL, close = FALSE))
    } else {
      return(list(correct = FALSE, explanation = NULL, close = FALSE))
    }
  }
  
  # Relative tolerance 2% (internal only)
  rel_err <- abs(user_num - correct_val) / max(abs(correct_val), 1e-9)
  within_tol <- (rel_err <= 0.02)
  
  # Precision check
  prec_ok <- FALSE
  if (!is.null(decimals)) {
    user_dec <- count_decimals(user_str)
    prec_ok <- (user_dec == decimals)
  } else if (!is.null(sigfigs)) {
    user_sig <- count_sigfigs(user_str)
    prec_ok <- (user_sig == sigfigs)
  } else {
    prec_ok <- TRUE
  }
  
  correct_display <- format_correct(correct_val, decimals, sigfigs)
  
  # Rounded numeric match
  if (!is.null(decimals)) {
    user_rounded <- round(user_num, decimals)
    correct_rounded <- round(correct_val, decimals)
    rounded_match <- (abs(user_rounded - correct_rounded) < 1e-9)
  } else if (!is.null(sigfigs)) {
    user_rounded <- signif(user_num, sigfigs)
    correct_rounded <- signif(correct_val, sigfigs)
    rounded_match <- (abs(user_rounded - correct_rounded) < 1e-9)
  } else {
    rounded_match <- TRUE
  }
  
  if (within_tol && prec_ok && rounded_match) {
    return(list(correct = TRUE, explanation = NULL, close = FALSE))
  } else if (within_tol && !rounded_match) {
    msg <- paste0("Your answer is close, but the exact value should be ", correct_display,
                  if (!is.null(decimals)) paste0(" (to ", decimals, " decimal places).") else paste0(" (to ", sigfigs, " significant figures)."))
    return(list(correct = FALSE, explanation = msg, close = TRUE))
  } else if (within_tol && !prec_ok) {
    msg <- paste0("Your numerical value is correct, but it must be reported to ",
                  if (!is.null(decimals)) paste0(decimals, " decimal places.") else paste0(sigfigs, " significant figures."),
                  " The correct answer is ", correct_display, ".")
    return(list(correct = FALSE, explanation = msg, close = TRUE))
  } else {
    return(list(correct = FALSE, explanation = NULL, close = FALSE))
  }
}

# ---------- Quiz data (unchanged) ----------
questions <- list(
  list(id = "q1", type = "numeric", decimals = 2,
       text = "Run linear regression predicting Plant_height from Altitude. What percentage of variation is explained by the model? Report to 2 decimal places.",
       correct = 9.65,
       explanation = "R2 = 9.65%."
  ),
  list(id = "q2", type = "numeric", decimals = 4,
       text = "What is the slope of the regression line? Report to 3 or more decimal places.",
       correct = -0.0417,
       explanation = "Slope is -0.0417."
  ),
  list(id = "q3", type = "single",
       text = "What is the null hypothesis of the F-test in regression?",
       options = c("Slope equals 0", "Slope > 0", "Intercept equals 0", "R2 > 0"),
       correct = "Slope equals 0",
       explanations = c(
         "Slope equals 0" = "Correct!"
,
         "Slope > 0" = "Incorrect."
,
         "Intercept equals 0" = "Incorrect."
,
         "R2 > 0" = "Incorrect."
       )
  ),
  list(id = "q4", type = "single",
       text = "In regression, R2 represents:",
       options = c("Proportion of variance explained", "Correlation coefficient", "Slope", "Standard error"),
       correct = "Proportion of variance explained",
       explanations = c(
         "Proportion of variance explained" = "Correct!"
,
         "Correlation coefficient" = "Incorrect."
,
         "Slope" = "Incorrect."
,
         "Standard error" = "Incorrect."
       )
  ),
  list(id = "q5", type = "single",
       text = "Which variable is the predictor (independent) in this model?",
       options = c("Altitude", "Plant_height", "Species", "Habitat"),
       correct = "Altitude",
       explanations = c(
         "Altitude" = "Correct!"
,
         "Plant_height" = "Incorrect (dependent)."
,
         "Species" = "Incorrect."
,
         "Habitat" = "Incorrect."
       )
  ),
  list(id = "q6", type = "single",
       text = "Which is the response (dependent) variable?",
       options = c("Plant_height", "Altitude", "Latitude", "Leaf_Area"),
       correct = "Plant_height",
       explanations = c(
         "Plant_height" = "Correct!"
,
         "Altitude" = "Incorrect."
,
         "Latitude" = "Incorrect."
,
         "Leaf_Area" = "Incorrect."
       )
  ),
  list(id = "q7", type = "numeric", decimals = 3,
       text = "What is the p-value for the regression slope? Report to 3 decimal places.",
       correct = 0.0,
       explanation = "p-value is very small."
  ),
  list(id = "q8", type = "single",
       text = "If the slope is negative, this means:",
       options = c("As Altitude increases, Plant_height decreases", "As Altitude increases, Plant_height increases", "No relationship", "Altitude causes increase"),
       correct = "As Altitude increases, Plant_height decreases",
       explanations = c(
         "As Altitude increases, Plant_height decreases" = "Correct!"
,
         "As Altitude increases, Plant_height increases" = "Incorrect."
,
         "No relationship" = "Incorrect."
,
         "Altitude causes increase" = "Incorrect."
       )
  ),
  list(id = "q9", type = "single",
       text = "Linear regression assumes:",
       options = c("Linearity, independence, homoscedasticity, normality of residuals", "Only normality", "Only linearity", "No assumptions"),
       correct = "Linearity, independence, homoscedasticity, normality of residuals",
       explanations = c(
         "Linearity, independence, homoscedasticity, normality of residuals" = "Correct!"
,
         "Only normality" = "Incorrect."
,
         "Only linearity" = "Incorrect."
,
         "No assumptions" = "Incorrect."
       )
  ),
  list(id = "q10", type = "numeric", decimals = 2,
       text = "What is the intercept of the regression model? Report to 2 decimal places.",
       correct = 10.13,
       explanation = "Intercept is ~10.13."
  )
)

ui <- fluidPage(
  tags$head(
    tags$script(src = "https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-chtml.js", async = NA),
    tags$script(HTML("window.MathJax = { tex: { inlineMath: [['$', '$']] }, startup: { pageReady: () => {} } };")),
    tags$style(HTML("
      body { font-family: Helvetica; font-size: 18pt; background-color: #282828; color: #d3d3d3; }
      h1,h2,h3,h4,h5,h6 { font-size: 24pt; color: #ffffff; }
      a { color: #6488EA; }
      .well { background-color: #3c3c3c; border: 1px solid #555; }
      .radio label, .checkbox label { color: #d3d3d3; }
      .btn-primary { background-color: #6488EA; border-color: #4a6cb3; }
      .btn-primary:hover { background-color: #4a6cb3; }
      .form-control {
        background-color: #555555;
        color: #d3d3d3;
        border-color: #777;
        font-size: 20pt;
        height: 60px;
        padding: 10px 15px;
      }
      .form-control:focus {
        background-color: #666666;
        color: #ffffff;
      }
    ")),
    tags$script(HTML("
      function renderMath() { if (window.MathJax) MathJax.typesetPromise(); }
      $(document).on('shiny:value', function() { setTimeout(renderMath, 100); });
      $(document).ready(function() { setTimeout(renderMath, 500); });
    "))
  ),
  div(id = "quiz-container",
      titlePanel("Quiz 2 (Chapters 4–7)"),
      div(style = "margin-bottom: 20px;",
          tags$p("This quiz uses two datasets: ",
                 tags$a(href = "http://bradduthie.github.io/stats_teaching/Quiz2/Quiz_2_subject_data.xlsx", "Quiz_2_subject_data.xlsx"),
                 " and ",
                 tags$a(href = "http://bradduthie.github.io/stats_teaching/Quiz2/Quiz_2_student_data.csv", "Quiz_2_student_data.csv"),
                 ". For all numeric answers, do not include units.")
      ),
      uiOutput("quiz_ui"),
      br(),
      actionButton("submit", "Submit Answers", class = "btn-primary btn-lg"),
      br(), br()
  ),
  div(id = "results-container", uiOutput("results"))
)

# ---------- Server ----------
server <- function(input, output, session) {
  
  output$quiz_ui <- renderUI({
    lapply(seq_along(questions), function(i) {
      q <- questions[[i]]
      wellPanel(
        h4(paste0("Question ", i, ":")),
        div(style = "margin-bottom: 40px;", p(HTML(q$text))),
        if (q$type == "multiple") {
          checkboxGroupInput(paste0("q", i), NULL,
                             choices = setNames(q$options, q$options),
                             selected = NULL)
        } else if (q$type == "numeric") {
          textInput(paste0("q", i), NULL, value = "", placeholder = "Enter number")
        }
      )
    }) |> tagList()
  })
  
  results <- reactiveVal(NULL)
  
  observeEvent(input$submit, {
    total_correct <- 0
    feedback <- list()
    
    for (i in seq_along(questions)) {
      q <- questions[[i]]
      ans_id <- paste0("q", i)
      user_val <- input[[ans_id]]
      
      if (q$type == "multiple") {
        if (is.null(user_val) || length(user_val) == 0) {
          correct <- FALSE
          explanation <- NULL
          user_display <- "Not answered"
          close <- FALSE
        } else {
          correct <- setequal(user_val, q$correct)
          if (correct) {
            explanation <- "All correct choices selected."
          } else {
            selected_wrong <- setdiff(user_val, q$correct)
            missing_correct <- setdiff(q$correct, user_val)
            expl <- character()
            if (length(selected_wrong) > 0) 
              expl <- c(expl, paste("Incorrect selections:", paste(selected_wrong, collapse = ", ")))
            if (length(missing_correct) > 0)
              expl <- c(expl, paste("Missing correct answers:", paste(missing_correct, collapse = ", ")))
            explanation <- paste(expl, collapse = "; ")
            extra <- sapply(selected_wrong, function(opt) {
              if (opt %in% names(q$explanations)) q$explanations[[opt]] else ""
            })
            if (length(extra) > 0) explanation <- paste(explanation, paste(extra, collapse = "; "), sep = "; ")
          }
          user_display <- paste(user_val, collapse = ", ")
          close <- FALSE
        }
        feedback[[i]] <- list(question = q$text, user = user_display, correct = correct, explanation = explanation, close = close)
        if (correct) total_correct <- total_correct + 1
        
      } else if (q$type == "numeric") {
        if (is.null(user_val) || user_val == "") {
          correct <- FALSE
          explanation <- NULL
          user_display <- "Not answered"
          close <- FALSE
        } else {
          check <- check_numeric(user_val, q$correct,
                                 integer = ifelse(is.null(q$integer), FALSE, q$integer),
                                 decimals = q$decimals,
                                 sigfigs = q$sigfigs)
          correct <- check$correct
          explanation <- if (!correct && !is.null(check$explanation)) check$explanation else if (!correct) q$explanation else NULL
          close <- if (!correct && !is.null(check$close)) check$close else FALSE
          user_display <- user_val
        }
        feedback[[i]] <- list(question = q$text, user = user_display, correct = correct, explanation = explanation, close = close)
        if (correct) total_correct <- total_correct + 1
      }
    }
    
    results(list(total = total_correct, out_of = length(questions), feedback = feedback))
  })
  
  output$results <- renderUI({
    req(results())
    res <- results()
    score_html <- h3(paste("Your score:", res$total, "out of", res$out_of))
    
    panels <- lapply(seq_along(res$feedback), function(i) {
      fb <- res$feedback[[i]]
      if (fb$correct) {
        status <- "Correct"
        col <- "#8bc34a"
      } else if (fb$close) {
        status <- "Close but not fully correct"
        col <- "#ffb74d"  # orange
      } else {
        status <- "Incorrect"
        col <- "#e57373"
      }
      
      expl_html <- NULL
      if (!fb$correct && !is.null(fb$explanation) && fb$explanation != "") {
        expl_html <- p(strong("Explanation:"), HTML(fb$explanation))
      } else if (fb$user == "Not answered") {
        correct_disp <- get_correct_display(questions[[i]])
        expl_html <- p(strong("Note:"), paste("No answer provided. The correct answer is:", correct_disp))
      }
      
      wellPanel(
        h4(paste("Question", i, "-", status), style = paste("color:", col)),
        p(HTML(fb$question)),
        p(strong("Your answer:"), fb$user),
        expl_html
      )
    })
    do.call(tagList, c(list(score_html), panels))
  })
}

shinyApp(ui, server)