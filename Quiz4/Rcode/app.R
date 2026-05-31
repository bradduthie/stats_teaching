library(shiny)

# ---------- Precision helpers (unchanged) ----------
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

format_decimal <- function(x, decimals) {
  sprintf(paste0("%.", decimals, "f"), x)
}

format_correct <- function(val, decimals = NULL, sigfigs = NULL) {
  if (!is.null(decimals)) return(format_decimal(val, decimals))
  if (!is.null(sigfigs)) return(format_sigfig(val, sigfigs))
  return(as.character(val))
}

count_decimals <- function(s) {
  if (!grepl("\\.", s)) return(0)
  nchar(sub("^.*\\.", "", s))
}

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
  
  rel_err <- abs(user_num - correct_val) / max(abs(correct_val), 1e-9)
  within_tol <- (rel_err <= 0.02)
  
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

# ---------- Quiz data with FULL explanations ----------
questions <- list(
  # Q1
  list(id = "q1", type = "numeric", decimals = 2,
       text = "Assuming the sampled walls are a random sample of all walls in Scotland, what is the probability that any given Scottish wall shows evidence of pollution? Report your answer to <strong>2 decimal places</strong>.",
       correct = 0.15,
       explanation = "Incorrect. To get our best estimate of the probability that any given Scottish wall will show evidence of pollution, we need to find the proportion of walls that show evidence of pollution in the sample. In jamovi, we can find this out by opening the dataset and navigating to Exploration, then Descriptives. We can put 'pollution' in the Variables box and check the 'Frequency tables' box (just below the 'Split by' box). A box of frequencies will then open in the results panel, which shows that there are 35 polluted walls and 205 non-polluted walls. Hence, there are 35 + 205 = 240 walls in total sampled, and the proportion of walls that are observed to be polluted is 35/240 = 0.1458333. To report to 2 decimal places, we need to round this to 0.15."
  ),
  # Q2
  list(id = "q2", type = "numeric", decimals = 2,
       text = "Based on the lichens dataset, if you randomly select 3 walls <strong>with replacement</strong>, what is the probability that all 3 walls show <strong>no</strong> evidence of pollution? Report your answer to <strong>2 decimal places</strong> (do not round until the last step).",
       correct = 0.62,
       explanation = "Incorrect. To answer this question, you needed to first recognise that the probability of a wall not being polluted is 205 / 240 = 0.8541667. This is the probability of sampling 1 wall that is not polluted. To sample three walls in a row that are not polluted, we need to multiply $0.8541667 \\times 0.8541667 \\times 0.8541667 = 0.8541667^3 = 0.6232006$. If we round this answer to 2 decimals, we get our final answer of 0.62."
  ),
  # Q3
  list(id = "q3", type = "numeric", decimals = 2,
       text = "Assume that total_area is normally distributed. Use the sample mean and standard deviation (rounded to <strong>3 significant figures</strong>) to find the probability that a wall has <strong>over 50%</strong> of its area covered. Report your answer to 2 decimal places.",
       correct = 0.14,
       explanation = "Incorrect. First you needed to find the mean and standard deviation of the total_area variable in jamovi. To do this, navigate to Exploration and Descriptives, then put 'total_area' in the Variables box. Make sure that 'Mean' and 'Std. deviation' are selected in the statistics boxes below. You will find that the mean is 0.393 and the standard deviation is 0.0993. Both of these are already taken to 3 significant figures. Next, go to the distrACTION module and select 'Normal Distribution'. Set the mean to 0.393 and the SD to 0.0993. Choose the function 'Compute probability' and set x1 = 0.5. Since you want to know the probability of a value being greater than 0.5, you need to check the second radio button where $P(X \\geq x1)$. The answer will appear in the panel to the right. The probability is 0.141, which is 0.14 rounded to 2 decimals."
  ),
  # Q4
  list(id = "q4", type = "numeric", decimals = 2,
       text = "Using the same normal assumption, what is the probability that a wall has <strong>between 25% and 50%</strong> of its area covered? Report your answer to 2 decimal places.",
       correct = 0.78,
       explanation = "Incorrect. First you needed to find the mean and standard deviation of the total_area variable in jamovi. To do this, navigate to Exploration and Descriptives, then put 'total_area' in the Variables box. Make sure that 'Mean' and 'Std. deviation' are selected in the statistics boxes below. You will find that the mean is 0.393 and the standard deviation is 0.0993. Both of these are already taken to 3 significant figures. Next, go to the distrACTION module and select 'Normal Distribution'. Set the mean to 0.393 and the SD to 0.0993. Choose the function 'Compute probability' and set x1 = 0.25. Since you want to know the probability of a value being within an interval, you need to check the 3rd radio button where $P(x1 \\leq X \\leq x2)$. The answer will appear in the panel to the right. Lastly, we need to set x2 = 0.5. The probability is 0.784, which is 0.78 when rounded to 2 decimal places."
  ),
  # Q5 - matching
  list(id = "q5", type = "matching",
       text = "Match each of the following four variables with the distribution that <strong>best</strong> describes them. (Hint: try histograms for wall_latitude, species_count, total_area – a histogram will not work for pollution.)",
       variables = c("wall_latitude", "pollution", "species_count", "total_area"),
       distributions = c("Normal", "Uniform", "Binomial", "Poisson"),
       correct_matches = c("Uniform", "Binomial", "Poisson", "Normal"),
       explanation = "Incorrect. Wall latitude is mostly, albeit not perfectly, uniform. Of the available options, this is the best choice. Pollution is a yes/no variable, described best by a binomial distribution. Species count would describe a count of colonising species arriving on the wall, and the histogram for it is consistent with a Poisson distribution. Total area is a continuous variable that appears, from the histogram, to be reasonably normally distributed."
  ),
  # Q6 - multiple answer
  list(id = "q6", type = "multiple",
       text = "For which of the following variables will the <strong>sample means</strong> be expected to be <strong>normally distributed</strong> around the true mean μ? (Check all that apply.)",
       options = c("wall_latitude", "nearest_road", "total_area", "species_count", "none of the above", "it is impossible to determine"),
       correct = c("wall_latitude", "nearest_road", "total_area", "species_count"),
       explanations = c(
         "wall_latitude" = "Correct. By the Central Limit Theorem, sample means of any variable become normal as sample size increases.",
         "nearest_road" = "Correct.",
         "total_area" = "Correct.",
         "species_count" = "Correct.",
         "none of the above" = "Incorrect. As a consequence of the central limit theorem, the sample means of all of the above variables should be normally distributed around the true mean.",
         "it is impossible to determine" = "Incorrect. The CLT tells us it is possible to determine."
       )
  ),
  # Q7 - single choice
  list(id = "q7", type = "single",
       text = "The standard deviation of sample means is also known as which of the following?",
       options = c("The standard deviation of the population", "The standard error", "The mean of the sample means", "The coefficient of variation", "The Shapiro‑Wilk test"),
       correct = "The standard error",
       explanations = c(
         "The standard deviation of the population" = "Incorrect. The standard deviation of sample means is the standard error, not the population SD.",
         "The standard error" = "Correct! The standard error of the mean of a sample of data points, SE, is the sample standard deviation divided by the square root of the total number of data points in the sample. In other words, for a sample dataset with 'n' observations and a sample standard deviation of 's', then $SE = s/\\sqrt{n}$. The standard error defines a confidence interval around our estimate of the sample mean compared with the true population mean. Conceptually, the standard error is also the standard deviation of sample means; i.e., if you were to repeatedly sample n data points from a population and calculate the mean of the n data points sampled each time, then the distribution of those sample means would have its own standard deviation (which is the standard error).",
         "The mean of the sample means" = "Incorrect.",
         "The coefficient of variation" = "Incorrect.",
         "The Shapiro‑Wilk test" = "Incorrect."
       )
  ),
  # Q8 - numeric, 3 sig figs
  list(id = "q8", type = "numeric", sigfigs = 3,
       text = "If a marble is randomly selected from your bag (regardless of size), what is the probability of selecting a <strong>red</strong> marble? Give your answer as a probability with <strong>three significant figures</strong>.",
       correct = 0.600,
       explanation = "Incorrect. The correct answer to this question was 0.600, and you can calculate it by dividing the number of red marbles in the bag (60) by the total number of marbles in the bag (100). Hence, the answer is 60/100 = 3/5 = 0.600 (note the three significant figures in the final answer)."
  ),
  # Q9 - numeric, 3 sig figs
  list(id = "q9", type = "numeric", sigfigs = 3,
       text = "If a marble is selected entirely at random from the bag, what is the probability of selecting a <strong>small blue</strong> marble? Give your answer with <strong>three significant figures</strong>.",
       correct = 0.246,
       explanation = "Incorrect. To answer this question, we first need to recognise from the paragraph above question 23 that the probability of selecting a blue marble is 0.4 (40 red marbles divided by 100 total marbles). Next, because there are 8 small blue marble for every 5 large blue marbles, the probability that a blue marble is small is 8/(5 + 8) = 8/13 = 0.6153846. To calculate the probability that we pull a small blue marble from the bag, we now need to find the probability that a marble is blue (0.4) and if so, that it is small (0.6153846). To do this, we multiply the probabilities, $Pr(Small,Blue) = \\frac{40}{100} \\times \\frac{8}{13} = 0.4 \\times 0.6153846 = 0.2461538$. After rounding this answer to three significant figures, we get 0.246."
  ),
  # Q10 - numeric, 3 sig figs
  list(id = "q10", type = "numeric", sigfigs = 3,
       text = "If you pull <strong>two different marbles</strong> out of the bag entirely at random (sampling <strong>without replacement</strong>), what is the combined probability of first selecting a <strong>large red</strong> marble, then a <strong>small blue</strong> marble? Give your answer with <strong>three significant figures</strong>.",
       correct = 0.0373,
       explanation = "Incorrect. To answer this question, we first must note that the probability of selecting a red marble is 0.6 (60 red marbles divided by 100 total marbles). There is 1 large red marble for every 3 small red marbles, so the probability that a red marble is large is 1/(1 + 3) = 1/4 = 0.25 (i.e., for every four red marbles, one is expected to be large and three are expected to be small, so one in four red marbles is large). Hence, to get the probability that we first pull a large red marble from the bag, we need the probability that the marble will be red (0.6) and the probability that the red marble will be large (0.25). With these two probabilities, we multiply to get the probability that the first marble is large and red, $Pr(Large,Red) = \\frac{6}{10} \\times \\frac{1}{4} = \\frac{6}{40} = \\frac{3}{20} = 0.15$. Now we can consider the second marble. Note that after pulling the first marble out of the bag, we have 99 marbles left. We are therefore sampling without replacement (i.e., sampling without putting the first marble back in the bag, so it cannot be sampled again). If we were to put the first marble back into the bag, then we would be sampling with replacement (i.e., replacing after sampling the first). Now having selected one large red marble, there are still 40 blue marbles left in the bag out of our total 99. The probability of selecting a blue marble is therefore 40/99 = 0.4040404. Using the same logic as with the red marble in our first selection, we know that the ratio of blue marbles is 8 small to 5 large, so the probability that any blue marble selected is also small is 8/(8 + 5) = 8/13 = 0.6153846. We again need the probability that a marble is blue and that it is small, so we multiply, $Pr(Small,Blue) = \\frac{40}{99} \\times \\frac{8}{13} = 0.2486402$. Now, to get the probability that the first marble we pull from the bag is large and red, and the second marble is small and blue, we need to multiply our probabilities Pr(Large, Red) and Pr(Small, Blue) together, $0.15 \\times 0.2486402 = 0.03729603$. After rounding this answer to three significant figures, we get 0.0373."
  )
)

# Helper for displaying correct answer
get_correct_display <- function(q) {
  if (q$type == "numeric") {
    return(format_correct(q$correct, q$decimals, q$sigfigs))
  } else if (q$type == "multiple") {
    return(paste(q$correct, collapse = ", "))
  } else if (q$type == "single") {
    return(q$correct)
  } else if (q$type == "matching") {
    matches <- paste(q$variables, "→", q$correct_matches, collapse = "; ")
    return(matches)
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
      .matching-table td, .matching-table th {
        padding: 12px;
        text-align: left;
        vertical-align: middle;
      }
      .matching-table th {
        background-color: #4a4a4a;
        color: #ffffff;
      }
      .matching-table td:first-child {
        font-weight: bold;
        background-color: #3c3c3c;
      }
    ")),
    tags$script(HTML("
      function renderMath() { if (window.MathJax) MathJax.typesetPromise(); }
      $(document).on('shiny:value', function() { setTimeout(renderMath, 100); });
      $(document).ready(function() { setTimeout(renderMath, 500); });
    "))
  ),
  div(id = "quiz-container",
      titlePanel("Quiz 4 – Lichens and Marbles (Chapters 15‑16)"),
      div(style = "margin-bottom: 20px;",
          tags$p("This is the practice quiz for ",
                 tags$a(href = "https://bradduthie.github.io/stats/Chapter_15.html", "Chapter 15"),
                 " and ",
                 tags$a(href = "https://bradduthie.github.io/stats/Chapter_16.html", "Chapter 16"),
                 ". Use the ",
                 tags$a(href = "http://bradduthie.github.io/stats_teaching/Quiz4/lichens.csv", "lichens.csv"),
                 " dataset for questions 1‑6. For questions 8‑10, use the marble scenario described in the quiz.")
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
      if (q$type == "matching") {
        # Build matching table: one row per variable, with radio buttons inline
        table_rows <- lapply(seq_along(q$variables), function(j) {
          var_name <- q$variables[j]
          radio_id <- paste0("q5_", var_name)
          radio_buttons <- radioButtons(radio_id, label = NULL,
                                        choices = setNames(q$distributions, q$distributions),
                                        selected = character(0),
                                        inline = TRUE)
          tags$tr(
            tags$td(var_name, style = "width: 30%;"),
            tags$td(radio_buttons, style = "width: 70%;")
          )
        })
        matching_table <- tags$table(class = "matching-table", style = "width: 100%; border-collapse: collapse; margin-top: 15px;",
                                     tags$thead(
                                       tags$tr(
                                         tags$th("Variable", style = "width: 30%;"),
                                         tags$th("Select Distribution", style = "width: 70%;")
                                       )
                                     ),
                                     tags$tbody(table_rows)
        )
        wellPanel(
          h4(paste0("Question ", i, ":")),
          div(style = "margin-bottom: 40px;", p(HTML(q$text))),
          matching_table
        )
      } else if (q$type == "multiple") {
        wellPanel(
          h4(paste0("Question ", i, ":")),
          div(style = "margin-bottom: 40px;", p(HTML(q$text))),
          checkboxGroupInput(paste0("q", i), NULL,
                             choices = setNames(q$options, q$options),
                             selected = NULL)
        )
      } else if (q$type == "single") {
        wellPanel(
          h4(paste0("Question ", i, ":")),
          div(style = "margin-bottom: 40px;", p(HTML(q$text))),
          radioButtons(paste0("q", i), NULL,
                       choices = setNames(q$options, q$options),
                       selected = character(0))
        )
      } else if (q$type == "numeric") {
        wellPanel(
          h4(paste0("Question ", i, ":")),
          div(style = "margin-bottom: 40px;", p(HTML(q$text))),
          textInput(paste0("q", i), NULL, value = "", placeholder = "Enter number")
        )
      }
    }) |> tagList()
  })
  
  results <- reactiveVal(NULL)
  
  observeEvent(input$submit, {
    total_correct <- 0
    feedback <- list()
    
    for (i in seq_along(questions)) {
      q <- questions[[i]]
      if (q$type == "matching") {
        # Collect user matches
        user_matches <- character(length(q$variables))
        all_selected <- TRUE
        for (j in seq_along(q$variables)) {
          var_name <- q$variables[j]
          input_id <- paste0("q5_", var_name)
          selected <- input[[input_id]]
          if (is.null(selected) || selected == "") {
            all_selected <- FALSE
            user_matches[j] <- NA
          } else {
            user_matches[j] <- selected
          }
        }
        if (!all_selected || any(is.na(user_matches))) {
          correct <- FALSE
          explanation <- q$explanation
          user_display <- "Incomplete selection"
        } else {
          correct <- all(user_matches == q$correct_matches)
          if (correct) {
            explanation <- NULL
          } else {
            explanation <- q$explanation
          }
          user_display <- paste(
            sapply(seq_along(q$variables), function(j) 
              paste0(q$variables[j], ": ", user_matches[j])),
            collapse = "; "
          )
        }
        feedback[[i]] <- list(question = q$text, user = user_display, correct = correct, explanation = explanation, close = FALSE)
        if (correct) total_correct <- total_correct + 1
        
      } else if (q$type == "multiple") {
        ans_id <- paste0("q", i)
        user_val <- input[[ans_id]]
        if (is.null(user_val) || length(user_val) == 0) {
          correct <- FALSE
          explanation <- NULL
          user_display <- "Not answered"
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
        }
        feedback[[i]] <- list(question = q$text, user = user_display, correct = correct, explanation = explanation, close = FALSE)
        if (correct) total_correct <- total_correct + 1
        
      } else if (q$type == "single") {
        ans_id <- paste0("q", i)
        user_val <- input[[ans_id]]
        if (is.null(user_val) || user_val == "") {
          correct <- FALSE
          explanation <- NULL
          user_display <- "Not answered"
        } else {
          correct <- (user_val == q$correct)
          if (correct) {
            explanation <- NULL
          } else {
            explanation <- q$explanations[[user_val]]
            if (is.null(explanation)) explanation <- "Incorrect."
          }
          user_display <- user_val
        }
        feedback[[i]] <- list(question = q$text, user = user_display, correct = correct, explanation = explanation, close = FALSE)
        if (correct) total_correct <- total_correct + 1
        
      } else if (q$type == "numeric") {
        ans_id <- paste0("q", i)
        user_val <- input[[ans_id]]
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