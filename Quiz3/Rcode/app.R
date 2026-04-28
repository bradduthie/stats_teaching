library(shiny)

# ---------- Precision helpers (reused from Quiz 2) ----------

# Count significant figures from a string
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

# Format number to a given number of significant figures (as string)
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

# Main numeric check: value within 2% tolerance (internal), precision matches
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

# ---------- Quiz data ----------
questions <- list(
  # Q1 - numeric, 1 decimal
  list(id = "q1", type = "numeric", decimals = 1,
       text = "What is the median age (column 'Age') of all individuals? Write your answer to 1 decimal place, and do not include units in your answer.",
       correct = 22.0,
       explanation = "Incorrect. The median age is 22.0."
  ),
  # Q2 - numeric, 1 decimal
  list(id = "q2", type = "numeric", decimals = 1,
       text = "What is the variance of the age (column 'Age') of all individuals? Write your answer to 1 decimal place, and do not include units in your answer.",
       correct = 22.2,
       explanation = "Incorrect. The variance of age is 22.2."
  ),
  # Q3 - numeric, 1 decimal
  list(id = "q3", type = "numeric", decimals = 1,
       text = "What is the lower quartile of hours of sleep per night (column 'Sleep'), as calculated in jamovi? Write your answer to 1 decimal place, and do not include units in your answer.",
       correct = 6.7,
       explanation = "Incorrect. To calculate this, you needed to open the dataset in jamovi, then navigate to the 'Analyses' tab and choose 'Exploration', then 'Descriptives' from the pulldown menu. Place 'Sleep' in the Variables box. Next, go to the 'Statistics' pulldown below and make sure that 'Percentiles' is checked. You should see a 25th percentile value in the Descriptives table of 6.74, which should be rounded to 1 decimal place, 6.7."
  ),
  # Q4 - numeric, 1 decimal
  list(id = "q4", type = "numeric", decimals = 1,
       text = "What is the inter-quartile range of hours of sleep per night (column 'Sleep') in the students dataset, as calculated in jamovi? Write your answer to 1 decimal place, and do not include units in your answer.",
       correct = 0.5,
       explanation = "Incorrect. To calculate this, you needed to open the dataset in Jamovi, then navigate to the 'Analyses' tab and choose 'Exploration', then 'Descriptives' from the pulldown menu. Place 'Sleep' in the Variables box. Next, go to the 'Statistics' pulldown below and make sure that 'Percentiles' is checked. The IQR is the difference between Q3 (7.2) and Q1 (6.7), which equals 0.5."
  ),
  # Q5 - multiple answer (bar chart, pie chart)
  list(id = "q5", type = "multiple",
       text = "What would be an appropriate type of plot to use to display the data in the sixth column of the data set that you received? Check all that apply.",
       options = c("Histogram", "Box-whisker plot", "Bar chart", "Scatter plot", "Pie chart", "No type of plot is appropriate for these data"),
       correct = c("Bar chart", "Pie chart"),
       explanations = c(
         "Histogram" = "Incorrect. Column 6 shows favourite subject – categorical data. Histograms are for continuous data.",
         "Box-whisker plot" = "Incorrect. Box‑whisker plots are for continuous distributions.",
         "Bar chart" = "Correct!",
         "Scatter plot" = "Incorrect. Scatter plots are for two continuous variables.",
         "Pie chart" = "Correct!",
         "No type of plot is appropriate for these data" = "Incorrect. Bar charts and pie charts are appropriate for categorical data."
       )
  ),
  # Q6 - single choice (radio)
  list(id = "q6", type = "single",
       text = "Consider the different favourite subjects of students. Which group of students has the highest standard deviation of study hours, based on their favourite subject?",
       options = c("Biology", "Chemistry", "Maths", "Music", "Psychology"),
       correct = "Psychology",
       explanations = c(
         "Biology" = "Incorrect. To find the answer, open the dataset in jamovi, then go to 'Analyses' > 'Exploration' > 'Descriptives'. Place 'Studying_per_week' in the Variables box, and 'Favourite_subject' in the 'Split by' box. Under 'Statistics', check 'Standard deviation'. The standard deviations are: Biology 8.16, Chemistry 9.89, Maths 8.99, Music 9.16, Psychology 10.24. Psychology has the highest standard deviation.",
         "Chemistry" = "Incorrect. The standard deviations are: Biology 8.16, Chemistry 9.89, Maths 8.99, Music 9.16, Psychology 10.24. Psychology has the highest standard deviation.",
         "Maths" = "Incorrect. The standard deviations are: Biology 8.16, Chemistry 9.89, Maths 8.99, Music 9.16, Psychology 10.24. Psychology has the highest standard deviation.",
         "Music" = "Incorrect. The standard deviations are: Biology 8.16, Chemistry 9.89, Maths 8.99, Music 9.16, Psychology 10.24. Psychology has the highest standard deviation.",
         "Psychology" = "Correct!"
       )
  ),
  # Q7 - numeric, 2 significant figures
  list(id = "q7", type = "numeric", sigfigs = 2,
       text = "In a new column of data, calculate the natural log (i.e., 'ln') of distance walked per day (column 'Distance_walked'). What is the mean of this logged dataset? Write your answer to 2 significant figures, and do not include units in your answer.",
       correct = -0.19,
       explanation = "Incorrect. To answer this question, you needed to go to the Data tab in Jamovi and Compute a new variable. Choose LN from the function box ($f_{x}$), then put 'Distance_walked' within the parentheses, so the formula reads '=LN(Distance_walked)'. Once this new column is created, you then need to go to Exploration and Descriptives, and put the newly created logged Distance walked in the 'Variables' box.  You will see that the mean of the logged dataset is -0.188, which to 2 significant figures is -0.19."
  ),
  # Q8 - numeric, 1 decimal
  list(id = "q8", type = "numeric", decimals = 1,
       text = "What is the coefficient of variation of distance walked per day (column 'Distance_walked')? Write your answer as a percentage (not a proportion) to 1 decimal place, but **do not** include the percentage symbol (%) in your answer (hint: do not round until the last step of your calculations).",
       correct = 92.8,
       explanation = "Incorrect. To calculate this, you needed to open the dataset in Jamovi, then navigate to the 'Analyses' tab and choose 'Exploration', then 'Descriptives' from the pulldown menu. Place 'Distance_walked' in the Variables box. Next, go to the 'Statistics' pulldown below and make sure that 'Mean' and 'Standard deviation' are checked. The Descriptives table will show that the Mean is 1.22793 and the Standard deviation is 1.13912 km. To get the coefficient of variation, we need to divide: 1.13912/1.22793 = 0.927675. As a percentage this is 92.7675%, rounded to 1 decimal place gives 92.8."
  ),
  # Q9 - numeric, 4 significant figures
  list(id = "q9", type = "numeric", sigfigs = 4,
       text = "What is the standard error of the mean of distance walked for students who do not have a driving licence? Report the answer to 4 significant figures.",
       correct = 0.1800,
       explanation = "Incorrect. To calculate this, you needed to open the dataset in jamovi, then navigate to the 'Analyses' tab and choose 'Exploration', then 'Descriptives' from the pulldown menu. Place 'Distance_walked' in the Variables box, and 'Driving_license' in the Split by box. Next, go to the 'Statistics' pulldown below and make sure that 'Std. error of Mean' is checked. The Descriptives table will show that the standard error is 0.180 for students without a driving licence. This has only 3 significant figures, so we need to add a trailing zero to get 4 significant figures: 0.1800."
  ),
  # Q10 - single choice (radio)
  list(id = "q10", type = "single",
       text = "Which of the following variables has the highest standard deviation?",
       options = c("Age", "Sleep", "Distance walked", "Lung capacity"),
       correct = "Lung capacity",
       explanations = c(
         "Age" = "Incorrect. Open the dataset in jamovi, go to 'Analyses' > 'Exploration' > 'Descriptives'. Place 'Age', 'Sleep', 'Distance_walked', and 'Lung_capacity' in the Variables box. Check 'Standard deviation' under Statistics. The standard deviations are: Age 4.56, Sleep 0.87, Distance walked 1.14, Lung capacity 9.50. Lung capacity has the highest standard deviation.",
         "Sleep" = "Incorrect. The standard deviations are: Age 4.56, Sleep 0.87, Distance walked 1.14, Lung capacity 9.50. Lung capacity has the highest standard deviation.",
         "Distance walked" = "Incorrect. The standard deviations are: Age 4.56, Sleep 0.87, Distance walked 1.14, Lung capacity 9.50. Lung capacity has the highest standard deviation.",
         "Lung capacity" = "Correct!"
       )
  )
)

# Helper to get formatted correct answer for display
get_correct_display <- function(q) {
  if (q$type == "numeric") {
    return(format_correct(q$correct, q$decimals, q$sigfigs))
  } else if (q$type == "multiple") {
    return(paste(q$correct, collapse = ", "))
  } else if (q$type == "single") {
    return(q$correct)
  }
  return("Unknown")
}

# ---------- UI ----------
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
      titlePanel("Quiz 3 (Chapters 9–12)"),
      div(style = "margin-bottom: 20px;",
          tags$p("This is the practice quiz for ",
                 tags$a(href = "https://bradduthie.github.io/stats/Chapter_9.html", "Chapter 9"), ", ",
                 tags$a(href = "https://bradduthie.github.io/stats/Chapter_10.html", "Chapter 10"), ", ",
                 tags$a(href = "https://bradduthie.github.io/stats/Chapter_11.html", "Chapter 11"), ", and ",
                 tags$a(href = "https://bradduthie.github.io/stats/Chapter_12.html", "Chapter 12"),
                 ". To answer the questions, use the ",
                 tags$a(href = "http://bradduthie.github.io/stats_teaching/Quiz3/student_data.csv", "student_data.csv"),
                 " dataset.")
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
        } else if (q$type == "single") {
          radioButtons(paste0("q", i), NULL,
                       choices = setNames(q$options, q$options),
                       selected = character(0))
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
        
      } else if (q$type == "single") {
        if (is.null(user_val) || user_val == "") {
          correct <- FALSE
          explanation <- NULL
          user_display <- "Not answered"
          close <- FALSE
        } else {
          correct <- (user_val == q$correct)
          if (correct) {
            explanation <- NULL
          } else {
            explanation <- q$explanations[[user_val]]
            if (is.null(explanation)) explanation <- "Incorrect."
          }
          user_display <- user_val
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
        col <- "#ffb74d"
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