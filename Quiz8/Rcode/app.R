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
  list(id = "q1", type = "numeric", integer = TRUE,
       text = "If pinnipeds are equally likely to dive day/night, what is the expected count of day dives? Write answer as integer.",
       correct = 61,
       explanation = "122/2 = 61."
  ),
  list(id = "q2", type = "single",
       text = "Test null that observed vs expected day/night counts equal. What should you conclude?",
       options = c("Reject null because Chi-square statistic > 0.05", "Do not reject null because p-value > 0.05", "Reject null because p-value > 0.05", "Do not reject null because Chi-square > p-value"),
       correct = "Do not reject null because p-value > 0.05",
       explanations = c(
         "Reject null because Chi-square statistic > 0.05" = "Incorrect."
,
         "Do not reject null because p-value > 0.05" = "Correct!"
,
         "Reject null because p-value > 0.05" = "Incorrect."
,
         "Do not reject null because Chi-square > p-value" = "Incorrect."
       )
  ),
  list(id = "q3", type = "numeric", decimals = 2,
       text = "Test if observations are equally frequent for all 3 species. What is the p-value? Report to 2 decimal places.",
       correct = 0.0,
       explanation = "p-value is very small."
  ),
  list(id = "q4", type = "single",
       text = "Based on the 3-species chi-square test, what do you conclude?",
       options = c("Do not reject null of equal frequencies", "Reject null of equal frequencies", "Frequencies are identical", "Cannot tell"),
       correct = "Reject null of equal frequencies",
       explanations = c(
         "Do not reject null of equal frequencies" = "Incorrect."
,
         "Reject null of equal frequencies" = "Correct!"
,
         "Frequencies are identical" = "Incorrect."
,
         "Cannot tell" = "Incorrect."
       )
  ),
  list(id = "q5", type = "single",
       text = "For a chi-square test of independence, what are degrees of freedom?",
       options = c("n-1", "(r-1)(c-1)", "r+c", "n"),
       correct = "(r-1)(c-1)",
       explanations = c(
         "n-1" = "Incorrect."
,
         "(r-1)(c-1)" = "Correct!"
,
         "r+c" = "Incorrect."
,
         "n" = "Incorrect."
       )
  ),
  list(id = "q6", type = "single",
       text = "What type of data is suitable for chi-square tests?",
       options = c("Continuous", "Categorical/count data", "Ratio only", "Interval only"),
       correct = "Categorical/count data",
       explanations = c(
         "Continuous" = "Incorrect."
,
         "Categorical/count data" = "Correct!"
,
         "Ratio only" = "Incorrect."
,
         "Interval only" = "Incorrect."
       )
  ),
  list(id = "q7", type = "single",
       text = "Using Angola_soils data, test if Nitrogen differs between sites. Which test is appropriate if assumptions met?",
       options = c("Independent samples t-test", "Paired t-test", "One-sample t-test", "Linear regression"),
       correct = "Independent samples t-test",
       explanations = c(
         "Independent samples t-test" = "Correct!"
,
         "Paired t-test" = "Incorrect."
,
         "One-sample t-test" = "Incorrect."
,
         "Linear regression" = "Incorrect."
       )
  ),
  list(id = "q8", type = "numeric", decimals = 3,
       text = "For Nitrogen comparison between sites, what is the p-value? Report to 3 decimal places.",
       correct = 0.024,
       explanation = "p-value ~ 0.024."
  ),
  list(id = "q9", type = "single",
       text = "Based on site comparison for Nitrogen (p<0.05), what do you conclude?",
       options = c("No difference between sites", "Significant difference in Nitrogen between sites", "Means identical", "Inconclusive"),
       correct = "Significant difference in Nitrogen between sites",
       explanations = c(
         "No difference between sites" = "Incorrect."
,
         "Significant difference in Nitrogen between sites" = "Correct!"
,
         "Means identical" = "Incorrect."
,
         "Inconclusive" = "Incorrect."
       )
  ),
  list(id = "q10", type = "single",
       text = "Chi-square goodness of fit tests which null hypothesis?",
       options = c("Observed = expected frequencies", "Variables are independent", "Means are equal", "Variances equal"),
       correct = "Observed = expected frequencies",
       explanations = c(
         "Observed = expected frequencies" = "Correct!"
,
         "Variables are independent" = "Incorrect."
,
         "Means are equal" = "Incorrect."
,
         "Variances equal" = "Incorrect."
       )
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
      titlePanel("Statistics Quiz 8 (Week 9)"),
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