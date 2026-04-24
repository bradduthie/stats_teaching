Quiz 2
=========================

This quiz will test your understanding of the concepts in [Chapter 4](https://bradduthie.github.io/stats/Chapter_4.html), [Chapter 5](https://bradduthie.github.io/stats/Chapter_5.html), [Chapter 6](https://bradduthie.github.io/stats/Chapter_6.html), and [Chapter 7](https://bradduthie.github.io/stats/Chapter_7.html) of the textbook. This content includes background statistical concepts such as populations and samples, variable types, units of measurement, and the propogation of errors.

There are two related datasets that you will need to answer the questions in this quiz. The first dataset [Quiz_2_subject_data.xlsx](http://bradduthie.github.io/stats_teaching/Quiz2/Quiz_2_subject_data.xlsx) is a spreadsheet with observations of the number of hours of recorded sleep in a night for students studying 5 different subjects. 

The second dataset [Quiz_2_student_data.csv](http://bradduthie.github.io/stats_teaching/Quiz2/Quiz_2_student_data.csv) focuses on the same students, but includes more measurements. These measurements include the student ID, hours of sleep per night, distance walked per day in miles, error of distance walked per day in miles, favourite subject, hours studying per week, whether the student has a driving license, and the number of miles driven per day.

Use these two datasets to answer the questions below. The first dataset will be used in Questions 1 and 2. The second dataset will be used in Questions 3-9. For all numeric answers, do not include units.


Question 1
---------------------------

First, put this dataset into a tidy format. What is the sample size of this dataset? Write your answer as an integer with no decimals.

Answer 1
--------------------------

45 {Fill in the blank numeric input with no margin for error allowed}

[Correct answer: 45]

Question 2
---------------------------

What is the mean number of hours sleep for Chemistry students? Report your answer to 3 decimals and do not include units in your answer.

Answer 2
--------------------------

6.500 {Fill in the blank numeric input with no margin for error allowed}

[Correct answer: 6.500 -- If incorrect, write: Incorrect. Note that this should just be the number of values that you see in the spreadsheet. In a tidy dataset, it will be the number of rows (not counting the header row).]





To answer questions 3-9, use the dataset [Quiz_2_student_data.csv](http://bradduthie.github.io/stats_teaching/Quiz2/Quiz_2_student_data.csv). This dataset is a CSV in a tidy format, in which several observations are made for a sample of students.
=====================================================================================




Question 3
---------------------------

What is the maximum number of hours studying per week done by a student? Report your answer to 3 significant digits. Do not include units in your answer.

Answer 3
--------------------------

19.0 {Fill in the blank numeric input with no margin for error allowed}

[Correct answer: 19.0 -- If incorrect, write: Incorrect. Remember that there are 3 significant digits needed. The maximum number of hours studying per week was 19, but this is only 2 significant digits, so a 3rd is needed.]



Question 4
---------------------------

In the student dataset, which of the columns is a categorical variable? Note that columns are read left to right (for example, column 1 is ID, column 2 is Sleep, and so forth). Check all that apply.

Answer 4
---------------------------
- [ ] Column 2 [Incorrect. Recall from Chapter 5 of the textbook the definition of a categorical variable: Categorical variables take on a fixed number of discrete values. In other words, the measurement that we record will assign our data to a specific category. Examples of categorical variables include species (e.g., “Robin”, “Nightingale”, “Wren”) or life history stage (e.g., “egg”, “juvenile”, “adult”).]
- [ ] Column 3 [Incorrect. Recall from Chapter 5 of the textbook the definition of a categorical variable: Categorical variables take on a fixed number of discrete values. In other words, the measurement that we record will assign our data to a specific category. Examples of categorical variables include species (e.g., “Robin”, “Nightingale”, “Wren”) or life history stage (e.g., “egg”, “juvenile”, “adult”).]
- [ ] Column 4 [Incorrect. Recall from Chapter 5 of the textbook the definition of a categorical variable: Categorical variables take on a fixed number of discrete values. In other words, the measurement that we record will assign our data to a specific category. Examples of categorical variables include species (e.g., “Robin”, “Nightingale”, “Wren”) or life history stage (e.g., “egg”, “juvenile”, “adult”).]
- [ ] Column 5 [Correct!]
- [ ] Column 6 [Incorrect. Recall from Chapter 5 of the textbook the definition of a categorical variable: Categorical variables take on a fixed number of discrete values. In other words, the measurement that we record will assign our data to a specific category. Examples of categorical variables include species (e.g., “Robin”, “Nightingale”, “Wren”) or life history stage (e.g., “egg”, “juvenile”, “adult”).]
- [ ] No Answer [Incorrect. Recall from Chapter 5 of the textbook the definition of a categorical variable: Categorical variables take on a fixed number of discrete values. In other words, the measurement that we record will assign our data to a specific category. Examples of categorical variables include species (e.g., “Robin”, “Nightingale”, “Wren”) or life history stage (e.g., “egg”, “juvenile”, “adult”).]


Question 5
---------------------------

For students who have a driving license, what is the mean number of daily kilometers driven? Note that the dataset reports driving in miles, not km. Assume that 1 mile equals 1.6 km for doing the conversion. Report your answer to 2 decimal places, and do not include units in your answer.

Answer 5
--------------------------

31.64 {Fill in the blank numeric input with no margin for error allowed}

[Correct answer: 31.64 -- If incorrect, write: Incorrect. In jamovi, you need to choose 'Daily_miles_driven' as a variable, then split it by 'Driving_license' (see Chapter 8 of the textbook for examples). This gives you a mean value of 19.7727 miles driven. To convert using the assumption that 1 mile equals 1.6 km, we just need to multiply 1.97727 by 1.6, $19.7727\times1.6=31.64$.]


Question 6
---------------------------

What is the mean distance walked, in miles for students without a driving licence? Note that the 'Distance_walked' column is reported in miles, so no conversion is necessary. Report your answer to 2 significant figures and do not include units in your answer.

Answer 6
--------------------------

2.7 {Fill in the blank numeric input with no margin for error allowed}
[Correct answer: 2.7 -- If incorrect, write: In jamovi, you need to calculate descriptive statistics with the variable 'Distance_walked' split by 'Driving_licence'.  See Chapter 8 of the textbook for an explanation of how to do this. Also remember to correctly calculate significant figures. In this case, you therefore need to report to 1 decimal.]

Question 7
---------------------------

Calculate the mean distance walked for students with a driving licence and students without a driving license. On average, how many more km do students without a driving license walk? Note that the 'Distance_walked' column is reported in miles, so you will need to convert to km. Assume that 1 mile equals 1.6 km for doing the conversion. Report your answer to 3 significant figures and do not include units in your answer.

Answer 7
--------------------------

2.70 {Fill in the blank numeric input with no margin for error allowed}
[Correct answer: 2.70 -- If incorrect, write: To get the correct answer, you should see that students without a driving licence walk 2.69 miles on average, and students with a driving licence walk 1.00 miles on average.  Students without a driving licence therefore walk 1.69 miles more, on average. To turn this into km, we just need to multiply 1.69 times 1.6, 1.69 \times 1.6 = 2.704. Note that there are 4 significant figures in 2.704, so we need to remove one significant figure to get our final answer of 2.70.]

Question 8
---------------------------

What is the lowest error estimate for total distance walked (column 'Distance_walked_error') by a student per day? Write your answer to 1 decimal place, and do not include units in your answer.

Answer 8
--------------------------

0.2 {Fill in the blank numeric input with no margin for error allowed}
[Correct answer: 0.2 -- If incorrect, write: You can find this answer in Jamovi by going to 'Exploration' and selecting 'Descriptives', then putting 'Distance_walked_error' in the variables columns. Make sure that the check box 'Minimum' is ticked under Statistics, and you will see a minimum of 0.200 in the output. Answering to 1 decimal place then gives 0.2.]

Question 9
---------------------------

Find the students with ID = 1 and ID = 2 (these will be the first two rows, unless you have resorted the data). Consider the total distance walked per day (column 'Distance_walked'), and the error associated with this distance ('Distance_walked_error'), for both students (i.e., ID = 1 and ID = 2). What is the error estimate of their combined distance walked? Write your answer to 3 decimal places, and do not include units in your answer.

Answer 9
--------------------------

1.072 {Fill in the blank numeric input with no margin for error allowed}
[Correct answer: 1.072 -- If incorrect, write: To answer this question, we need to apply the formula used in the textbook Chapter 7 on adding and subtracting errors (note that we are adding errors to get the combined error in distance walked), \n\n $Error=\sqrt{0.26^{2} + 1.04^{2}}.$ \n\n  First we need to calculate the exponents, \n\n $Error = \sqrt{0.0676 + 1.0816}.$ \n\n Next, we need to add the numbers under the radical (remember from Chapter 1 of the textbook that brackets are implied for anything under the radical). \n\n $Error = \sqrt{1.1492}$. \n\n We then need to calculate the square root, \n\n $Error = 1.072007$. Lastly, we need to report the above to 3 decimal places, 1.072. Note that an easy way to get this one wrong, aside from applying the order of operations incorrectly, is to try to take part of the calculation (e.g., the 1.1492) to 3 decimal places. You only want to round to 3 decimal places at the end of the answer.]

Question 10
---------------------------

Imagine that you need to paint a rectangular wall in a room. You measure the width of the wall to be 3.5 m with an error of 0.2 m. You measure the height of the wall to be 2.5 m with an error of 0.15 m. What is the error of the total area of the wall? Write your answer to 2 decimal places, and do not include units in your answer.

Answer 10
--------------------------

0.73 {Fill in the blank numeric input with no margin for error allowed}
[Correct answer: 0.73 -- If incorrect, write: For this question, you needed to use the formula for multiplying or dividing errors from the workbook Chapter 7, \n\n $E_{Z} = Z \sqrt{ \left(\frac{E_{X}}{X} \right)^{2} + \left(\frac{E_{Y}}{Y} \right)^{2} }.$ \n\n Note that the total area of the wall (Z) will be 3.5 * 2.5 = 8.75. We can then fill in the remaining numbers in the above equation, \n\n $E_{Z} = 8.75 \sqrt{ \left( \frac{0.2}{3.5} \right)^{2} + \left( \frac{0.15}{2.5} \right)^{2} }$. \n\n First, we need to do the calculations in brackets, $E_{Z} = 8.75 \sqrt{ \left( 0.05714286 \right)^{2} + \left( 0.06 \right)^{2} }.$ \n\n Next, we need to apply the exponents under the radical, \n\n  $E_{Z} = 8.75 \sqrt{  0.003265306 + 0.0036 }$. \n\n Because of the implied parentheses under the radical, we now need to calculate the sum of 0.003265306 and 0.0036. \n\n $E_{Z} = 8.75 \sqrt{  0.006865306 }$. \n\n Next, we calculate the square-root, \n\n $E_{Z} = 8.75 \left(0.08285714 \right).$ Next, we need to multiply the two numbers together, \n\n $E_{Z} = 8.75 \times 0.08285714 = 0.725.$ Lastly, we need to write 0.725 to 2 decimal places. We therefore round up to get 0.73 as a final answer.]









