Quiz 1
=========================

This quiz will test your understanding of the concepts in [Chapter 1](https://bradduthie.github.io/stats/Chapter_1.html) and [Chapter 2](https://bradduthie.github.io/stats/Chapter_2.html) of the textbook.


Question 1
---------------------------

Given the equation below, what is the correct value of $x$? 

$x = 6.2 + 2.58 \times 1.1$


Answer 1
--------------------------

- 9.88 [Incorrect. Here you added all of the values instead of multiplying, 6.2 + 2.58 + 1.1 = 9.88]
- 9.038 [Correct!]
- 9.658 [Incorrect. Here you got the order of operations incorrect because you added the 6.2 and 2.58 before multiplying, (6.2 + 2.58) * 1.1.]
- 17.096 [Incorrect. Here you multiplied 6.2 and 2.58, then added 1.1, (6.2 * 2.58) + 1.1 = 17.096]
- 17.5956 [Incorrect. Here you multiplied all of the values together, 6.2 * 2.58 * 1.1 = 17.5956]

Question 2
-----------------------------

Given the equation below, what is the correct value of $x$?

$x = \frac{5^2 + \left(3 - 7\right)^3}{3 + 3} - 2\sqrt{9}$


Answer 2
--------------------------

- -25.5 [Incorrect. You got the order of operations incorrect. You calculated: $\frac{\left(5^{2} + 3 \right) - 7^{3}}{3+3} - 2 \sqrt{9} = -58.5$]
- -58.5 [Incorrect. Here you got the order of operations incorrect. You calculated: $\frac{\left(5^{2} + 3 \right) - 7^{3}}{3+3} - 2 \sqrt{9} = -58.5$]
- 1537.5 [Incorrect. You got the order of operations incorrect. You calculated: $\frac{\left(\left(5^{2} +  3 - 7\right)^{3}\right)}{3+3} - 2\sqrt{9} = 1537.5$]
- -10.74264 [Incorrect. Here you got the order of operations incorrect. You calculated: $\frac{5^{2} + \left( 3 - 7 \right)^{2}}{3+3} - \sqrt{2 \times 9} = -10.74264$]
- -12.5 [Correct!]



Question 3
-----------------------------

Given the equation below, what is the correct value of $x$?

$x = log_{10}(100000)$


Answer 3
--------------------------

- 5 [Correct!]
- 6 [Incorrect. You typed in 1 too many zeroes. Note that, $log_{10}(1000000) = 6$]
- 10000 [Incorrect. It looks like you might have divided,  $100000/10 = 10000$, instead of taking the log.]
- [Incorrect. It looks like you might have taken the natural logarithm of 100000 (i.e., base e) instead of using base 10. That is, $log_{e}(100000) = \ln(100000) = 11.51293$.]
- 2.71828 [Incorrect. You have just reported Euler's number, $e \approx 2.718282$].


Question 4
-----------------------------

Given the equation below, what is the correct value of $x$?

$x = 12^{-3}$


Answer 4
-----------------------------------

- 1/12 [Incorrect. Here you have taken the inverse of 12, but you also needed to consider the 3 (i.e., take the inverse of 12 to the 3rd power).]
- -1/12 [Incorrect. Here you have taken the negative of the inverse of 12, but you needed to consider the 3 (i.e., take the inverse of 12 to the 3rd power). Also, there should not be a negative in the result; the negative in the exponent does not make the entire value negative.]
- -1728 [Incorrect. This is on the right track, but note that this is the answer if you raised 12 to the 3rd power, then set the value to negative (i.e., multiplied by -1). The negative in the exponent tells you that you need to take the inverse of 12^3, not turn the whole number negative.]
- 1/1728 [Correct!]
- -1/1728 [Incorrect. This is on the right track, but note that you only need to take the inverse of 12^3, not turn the whole number negative.]

Question 5
---------------------

Which of the inequalities below is true? Check all that apply.


Answer 5
----------------------

- [ ] $12 > 4$ [Correct! 12 is greater than 4, so this is true]
- [ ] $-14 > -5$ [Incorrect. Negative 14 is less than negative 5 (the magnitude of 14 is, of course, greater than 5, but since these are negative numbers, bigger numbers are lower in value).]
- [ ] $1/2 \leq 0.5$ [Correct! 1/2 is equal to 0.5, so 1/2 is less than or equal to 0.5 is also true.]
- [ ] $4 > 2^2$ [Correct! 4 is equal to two squared, so 4 is greater than 2 squared is also true]
- [ ] $4 \leq 16^{1/2}$ [Correct! 4 is equal to 16 raised to the 1/2, so 4 is less than or equal to 16 raised to the 1/2 is also true]
- [ ] $20 \geq 20.1$ [Incorrect. The value 20 is not greater than or equal to 20.1. The value 20 is less than 20.1. That is, 20 < 20.1, so this option is false.]
- [ ] $100 > 1000$ [Incorrect. 100 is less than 1000, so this option is false. Instead, 100 < 1000]
- [ ] $2 > e^{1}$ [Incorrect. Euler's number is approximately equal to 2.718282, so it is greater than 2. That is, $2 < e^1$.]


For the next 5 questions, you need to download the [Quiz 1 dataset](http://bradduthie.github.io/stats_teaching/quiz1_data.xlsx). This dataset is given to you in a format that is not tidy, so you will need to make the dataset tidy before answering Questions 6-10. 
---------------------------------------------------------------------


Question 6
-----------------------------------------

Put the Quiz 1 dataset into a tidy format. After you have done this, how many rows of data do you have? Do not include the header (column names in the first row) in the rows of data. Write your answer as a natural number with no decimals.

Answer 6
------------------------------------------

28 {Fill in the blank numeric input with no margin for error allowed}


Question 7
------------------------------------------

After putting the Quiz 1 dataset into a tidy format, how many columns does it have? Write your answer as a natural number with no decimals.


Answer 7
--------------------------------------------

3 {Fill in the blank numeric input with no margin for error allowed}


Question 8
----------------------------------------------

Which of the following the Quiz 1 dataset is a variable? Check all that apply.


Answer 8
-----------------------------------------------

- [ ] Edinburgh [Incorrect.]
- [ ] City [Correct!]
- [ ] Day [Correct!]
- [ ] 11 [Incorrect.]
- [ ] 2023_JAN_26 [Incorrect.]
- [ ] Temperature [Correct!]


Question 9
-----------------------------------------------

Based on the Quiz 1 dataset, on what date was the lowest temperature recorded?


Answer 9
-----------------------------------------------

- 2023 JAN 21 [Incorrect.]
- 2023 JAN 22 [Correct!]
- 2023 JAN 23 [Incorrect.]
- 2023 JAN 24 [Incorrect.]
- 2023 JAN 25 [Incorrect.]
- 2023 JAN 26 [Incorrect.]
- 2023 JAN 27 [Incorrect.]


Question 10
-------------------------------------------------

In the Quiz 1 dataset, how many missing data values are there? Write your answer as a natural number with no decimals.

0 {Fill in the blank numeric input with no margin for error allowed}


Tidy data
------------------------------------------------

Note, to see what your tidy dataset should look like, [see here](http://bradduthie.github.io/stats_teaching/quiz1_data.csv)





















