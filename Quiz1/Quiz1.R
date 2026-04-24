library(shiny);

# ---------- Define the quiz data ----------
questions <- list(
  list(
    id = "q1", type = "single", text = "Given the equation below, what is the correct value of $x$?  
$x = 6.2 + 2.58 \\times 1.1$",
    options = c("9.88", "9.038", "9.658", "17.096", "17.5956"),
    correct = "9.038",
    explanations = c(
      "9.88" = "Incorrect. Here you added all of the values instead of multiplying, 6.2 + 2.58 + 1.1 = 9.88",
      "9.038" = "Correct!",
      "9.658" = "Incorrect. Here you got the order of operations incorrect because you added the 6.2 and 2.58 before multiplying, (6.2 + 2.58) * 1.1.",
      "17.096" = "Incorrect. Here you multiplied 6.2 and 2.58, then added 1.1, (6.2 * 2.58) + 1.1 = 17.096",
      "17.5956" = "Incorrect. Here you multiplied all of the values together, 6.2 * 2.58 * 1.1 = 17.5956"
    )
  ),
  list(
    id = "q2", type = "single", text = "Given the equation below, what is the correct value of $x$?  
$x = \\frac{5^2 + \\left(3 - 7\\right)^3}{3 + 3} - 2\\sqrt{9}$",
    options = c("-25.5", "-58.5", "1537.5", "-10.74264", "-12.5"),
    correct = "-12.5",
    explanations = c(
      "-25.5" = "Incorrect. You got the order of operations incorrect. You calculated: $\\frac{\\left(5^{2} + 3 \\right) - 7^{3}}{3+3} - 2 \\sqrt{9} = -58.5$",
      "-58.5" = "Incorrect. Here you got the order of operations incorrect. You calculated: $\\frac{\\left(5^{2} + 3 \\right) - 7^{3}}{3+3} - 2 \\sqrt{9} = -58.5$",
      "1537.5" = "Incorrect. You got the order of operations incorrect. You calculated: $\\frac{\\left(\\left(5^{2} +  3 - 7\\right)^{3}\\right)}{3+3} - 2\\sqrt{9} = 1537.5$",
      "-10.74264" = "Incorrect. Here you got the order of operations incorrect. You calculated: $\\frac{5^{2} + \\left( 3 - 7 \\right)^{2}}{3+3} - \\sqrt{2 \\times 9} = -10.74264$",
      "-12.5" = "Correct!"
    )
  ),
  list(
    id = "q3", type = "single", text = "Given the equation below, what is the correct value of $x$?  
$x = \\log_{10}(100000)$",
    options = c("5", "6", "10000", "11.51293", "2.71828"),
    correct = "5",
    explanations = c(
      "5" = "Correct!",
      "6" = "Incorrect. You typed in 1 too many zeroes. Note that, $\\log_{10}(1000000) = 6$",
      "10000" = "Incorrect. It looks like you might have divided, $100000/10 = 10000$, instead of taking the log.",
      "11.51293" = "Incorrect. It looks like you might have taken the natural logarithm of 100000 (i.e., base e) instead of using base 10. That is, $\\log_{e}(100000) = \\ln(100000) = 11.51293$.",
      "2.71828" = "Incorrect. You have just reported Euler's number, $e \\approx 2.718282$."
    )
  ),
  list(
    id = "q4", type = "single", text = "Given the equation below, what is the correct value of $x$?  
$x = 12^{-3}$",
    options = c("1/12", "-1/12", "-1728", "1/1728", "-1/1728"),
    correct = "1/1728",
    explanations = c(
      "1/12" = "Incorrect. Here you have taken the inverse of 12, but you also needed to consider the 3 (i.e., take the inverse of 12 to the 3rd power).",
      "-1/12" = "Incorrect. Here you have taken the negative of the inverse of 12, but you needed to consider the 3 (i.e., take the inverse of 12 to the 3rd power). Also, there should not be a negative in the result; the negative in the exponent does not make the entire value negative.",
      "-1728" = "Incorrect. This is on the right track, but note that this is the answer if you raised 12 to the 3rd power, then set the value to negative (i.e., multiplied by -1). The negative in the exponent tells you that you need to take the inverse of 12^3, not turn the whole number negative.",
      "1/1728" = "Correct!",
      "-1/1728" = "Incorrect. This is on the right track, but note that you only need to take the inverse of 12^3, not turn the whole number negative."
    )
  ),
  list(
    id = "q5", type = "multiple", text = "Which of the inequalities below is true? Check all that apply.",
    options = c("$12 > 4$", "$-14 > -5$", "$1/2 \\leq 0.5$", "$4 > 2^2$", "$4 \\leq 16^{1/2}$", "$20 \\geq 20.1$", "$100 > 1000$", "$2 > e^{1}$"),
    correct = c("$12 > 4$", "$1/2 \\leq 0.5$", "$4 > 2^2$", "$4 \\leq 16^{1/2}$"),
    explanations = c(
      "$12 > 4$" = "Correct! 12 is greater than 4, so this is true",
      "$-14 > -5$" = "Incorrect. Negative 14 is less than negative 5 (the magnitude of 14 is, of course, greater than 5, but since these are negative numbers, bigger numbers are lower in value).",
      "$1/2 \\leq 0.5$" = "Correct! 1/2 is equal to 0.5, so 1/2 is less than or equal to 0.5 is also true.",
      "$4 > 2^2$" = "Correct! 4 is equal to two squared, so 4 is greater than 2 squared is also true",
      "$4 \\leq 16^{1/2}$" = "Correct! 4 is equal to 16 raised to the 1/2, so 4 is less than or equal to 16 raised to the 1/2 is also true",
      "$20 \\geq 20.1$" = "Incorrect. The value 20 is not greater than or equal to 20.1. The value 20 is less than 20.1. That is, 20 < 20.1, so this option is false.",
      "$100 > 1000$" = "Incorrect. 100 is less than 1000, so this option is false. Instead, 100 < 1000",
      "$2 > e^{1}$" = "Incorrect. Euler's number is approximately equal to 2.718282, so it is greater than 2. That is, $2 < e^1$."
    )
  ),
  list(
    id = "q6", type = "numeric", text = "Put the Quiz 1 dataset into a tidy format. After you have done this, how many rows of data do you have? Do not include the header (column names in the first row) in the rows of data. Write your answer as a natural number with no decimals.",
    correct = 28, explanation = "After tidying, the dataset should have 28 rows (one for each city–day combination)."
  ),
  list(
    id = "q7", type = "numeric", text = "After putting the Quiz 1 dataset into a tidy format, how many columns does it have? Write your answer as a natural number with no decimals.",
    correct = 3, explanation = "Tidy data has three columns: City, Day, and Temperature."
  ),
  list(
    id = "q8", type = "multiple", text = "Which of the following in the Quiz 1 dataset is a variable? Check all that apply.",
    options = c("Edinburgh", "City", "Day", "11", "2023_JAN_26", "Temperature"),
    correct = c("City", "Day", "Temperature"),
    explanations = c(
      "Edinburgh" = "Incorrect.",
      "City" = "Correct!",
      "Day" = "Correct!",
      "11" = "Incorrect.",
      "2023_JAN_26" = "Incorrect.",
      "Temperature" = "Correct!"
    )
  ),
  list(
    id = "q9", type = "single", text = "Based on the Quiz 1 dataset, on what date was the lowest temperature recorded?",
    options = c("2023 JAN 21", "2023 JAN 22", "2023 JAN 23", "2023 JAN 24", "2023 JAN 25", "2023 JAN 26", "2023 JAN 27"),
    correct = "2023 JAN 22", explanation = "The lowest temperature was recorded on January 22."
  ),
  list(
    id = "q10", type = "numeric", text = "In the Quiz 1 dataset, how many missing data values are there? Write your answer as a natural number with no decimals.",
    correct = 0, explanation = "The dataset has no missing values."
  )
)

# ---------- UI ----------
ui <- fluidPage(
  withMathJax(),
  titlePanel("Statistics Quiz 1 (Chapters 1 & 2)"),
  
  tags$div(
    style = "margin-bottom: 20px;",
    tags$p("This quiz covers material from ",
           tags$a(href = "https://bradduthie.github.io/stats/Chapter_1.html", "Chapter 1"),
           " and ",
           tags$a(href = "https://bradduthie.github.io/stats/Chapter_2.html", "Chapter 2"),
           ". For Questions 6–10, you need the dataset below.")
  ),
  
  fluidRow(
    column(12,
           wellPanel(
             tags$b("Dataset for Questions 6–10:"),
             tags$ul(
               tags$li(tags$a(href = "http://bradduthie.github.io/stats_teaching/quiz1_data.xlsx", "Original Excel file (untidy)")),
               tags$li(tags$a(href = "http://bradduthie.github.io/stats_teaching/quiz1_data.csv", "Pre‑tidy CSV (to check your work)"))
             ),
             tags$p("Download the Excel file, tidy it yourself, then answer Questions 6–10.")
           )
    )
  ),
  
  # Render each question dynamically
  uiOutput("quiz_ui"),
  
  br(),
  actionButton("submit", "Submit Answers", class = "btn-primary btn-lg"),
  br(), br(),
  
  uiOutput("results")
)

# ---------- Server ----------
server <- function(input, output, session) {
  
  # Dynamically create UI for each question
  output$quiz_ui <- renderUI({
    question_list <- lapply(seq_along(questions), function(i) {
      q <- questions[[i]]
      wellPanel(
        h4(paste0("Question ", i, ":")),
        p(HTML(q$text)),
        if (q$type == "single") {
          radioButtons(paste0("q", i), label = NULL, 
                       choices = setNames(q$options, q$options),
                       selected = character(0))
        } else if (q$type == "multiple") {
          checkboxGroupInput(paste0("q", i), label = NULL,
                             choices = setNames(q$options, q$options),
                             selected = NULL)
        } else if (q$type == "numeric") {
          numericInput(paste0("q", i), label = NULL, value = NA, step = 1)
        }
      )
    })
    do.call(tagList, question_list)
  })
  
  # Store results after submission
  results <- reactiveVal(NULL)
  
  observeEvent(input$submit, {
    user_answers <- list()
    total_correct <- 0
    feedback <- list()
    
    for (i in seq_along(questions)) {
      q <- questions[[i]]
      ans_id <- paste0("q", i)
      user_ans <- input[[ans_id]]
      
      if (is.null(user_ans) || (q$type == "numeric" && is.na(user_ans))) {
        user_ans <- NA
        is_correct <- FALSE
        explanation <- "No answer provided."
      } else {
        if (q$type == "single") {
          is_correct <- (user_ans == q$correct)
          explanation <- if (is_correct) q$explanations[[user_ans]] else q$explanations[[user_ans]]
        } else if (q$type == "multiple") {
          # Compare sets (order doesn't matter)
          correct_set <- q$correct
          is_correct <- setequal(user_ans, correct_set)
          if (is_correct) {
            explanation <- "All correct choices selected."
          } else {
            # Build explanation: show which were selected vs correct
            selected_correct <- intersect(user_ans, correct_set)
            selected_wrong <- setdiff(user_ans, correct_set)
            missing_correct <- setdiff(correct_set, user_ans)
            expl <- character()
            if (length(selected_wrong) > 0) 
              expl <- c(expl, paste("Incorrect selections:", paste(selected_wrong, collapse = ", ")))
            if (length(missing_correct) > 0)
              expl <- c(expl, paste("Missing correct answers:", paste(missing_correct, collapse = ", ")))
            explanation <- paste(expl, collapse = "; ")
            # Append individual option explanations (for each wrong selected)
            extra <- sapply(selected_wrong, function(opt) {
              if (opt %in% names(q$explanations)) q$explanations[[opt]] else ""
            })
            if (length(extra) > 0) explanation <- paste(explanation, paste(extra, collapse = "; "), sep = "; ")
          }
        } else if (q$type == "numeric") {
          # exact integer comparison
          user_num <- as.numeric(user_ans)
          is_correct <- (!is.na(user_num) && user_num == q$correct)
          explanation <- if (is_correct) "Correct!" else q$explanation
        }
      }
      
      if (!is.na(is_correct) && is_correct) total_correct <- total_correct + 1
      feedback[[i]] <- list(question = q$text, user = user_ans, correct = is_correct, explanation = explanation)
    }
    
    results(list(total = total_correct, out_of = length(questions), feedback = feedback))
  })
  
  output$results <- renderUI({
    res <- results()
    if (is.null(res)) return(NULL)
    
    score_html <- h3(paste("Your score:", res$total, "out of", res$out_of))
    
    feedback_panels <- lapply(seq_along(res$feedback), function(i) {
      fb <- res$feedback[[i]]
      status <- if (fb$correct) "Correct" else "Incorrect"
      status_color <- if (fb$correct) "green" else "red"
      wellPanel(
        h4(paste("Question", i, "-", status), style = paste("color:", status_color)),
        p(HTML(fb$question)),
        p(strong("Your answer:"), if (is.null(fb$user) || all(is.na(fb$user))) "Not answered" else paste(fb$user, collapse = ", ")),
        p(strong("Explanation:"), HTML(fb$explanation))
      )
    })
    
    do.call(tagList, c(list(score_html), feedback_panels))
  })
}

shinyApp(ui, server);