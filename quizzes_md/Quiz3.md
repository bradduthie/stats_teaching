Quiz 3
=========================

This is the practice quiz for [Chapter 9](https://bradduthie.github.io/stats/Chapter_9.html), [Chapter 10](https://bradduthie.github.io/stats/Chapter_10.html), [Chapter 11](https://bradduthie.github.io/stats/Chapter_11.html), and [Chapter 12](https://bradduthie.github.io/stats/Chapter_12.html). To answer the questions in this quiz, you will need to use the [student_data.csv](http://bradduthie.github.io/stats_teaching/Quiz3/student_data.csv) dataset. This dataset includes variables measured from a set of students.


Question 1
---------------------------

What is the median age (column 'Age') of all individuals? Write your answer to 1 decimal place, and do not include units in your answer.

Answer 1
--------------------------

22.0

[Correct answer: 22.0]


Question 2
---------------------------

What is the variance of the age (column 'Age') of all individuals? Write your answer to 1 decimal place, and do not include units in your answer.


Answer 2
--------------------------

22.2

[Correct answer: 22.2]




Question 3
---------------------------

What is the lower quartile of hours of sleep per night (column 'Sleep'), as calculated in jamovi? Write your answer to 1 decimal place, and do not include units in your answer.

Answer 3
--------------------------

6.7

[Correct answer: 6.7 -- If incorrect, write: To calculate this, you needed to open the dataset in jamovi, then navigate to the 'Analyses' tab and choose 'Exploration', then 'Descriptives' from the pulldown menu. Place 'Sleep' in the Variables box. Next, go to the 'Statistics' pulldown below and make sure that 'Percentiles' is checked. You should see a 25th percentile value in the Descriptives table of 6.74, which should be rounded to 1 decimal place, 6.7.]



Question 4
---------------------------

What is the inter-quartile range of hours of sleep per night (column 'Sleep') in the students dataset, as calculated in jamovi? Write your answer to 1 decimal place, and do not include units in your answer.

Answer 4
---------------------------

0.5

[Correct answer: 0.5 -- If incorrect, write: To calculate this, you needed to open the dataset in Jamovi, then navigate to the 'Analyses' tab and choose 'Exploration', then 'Descriptives' from the pulldown menu. Place 'Sleep' in the Variables box. Next, go to the 'Statistics' pulldown below and make sure that 'Percentiles' is checked. You should see a 25th percentile value in the Descriptives table of 6.74, which should be rounded to 1 decimal place, 6.7.]


Question 5
---------------------------

What would be an appropriate type of plot to use to display the data in the sixth column of the data set that you received? Check all that apply.


Answer 5
--------------------------

- [ ] Histogram [Incorrect.]
- [ ] Box-whisker plot [Incorrect.]
- [ ] Bar chart [Correct!]
- [ ] Scatter plot [Incorrect.]
- [ ] Pie chart [Correct!]
- [ ] No type of plot is appropriate for these data [Incorrect.]

[If incorrect, write: Column 6 shows each students favourite subject. These data are categorical, meaning that we can visualise them using a bar chart or pie chart, potentially. Histograms, box-whisker plots, and scatter plots are all useful for continuous, not categorical data. See Chapter 10 of the textbook for more details.]



Question 6
---------------------------

Consider the different favourite subjects of students. Which group of students has the highest standard deviation of study hours, based on their favourite subject?

In other words, which of the below has the highest standard deviation in hours studied per week?



Answer 6
--------------------------

- Biology [Incorrect. To find the answer, you needed to open the dataset in jamovi, then navigate to the 'Analyses' tab and choose 'Exploration', then 'Descriptives' from the pulldown menu. Place 'Studying_per_week' in the Variables box, then 'Favourite_subject' in the Splity by box. Next, go to the 'Statistics' pulldown below and make sure that 'Standard deviation' is checked. You should see a Descriptives table of standard deviations broken down by favourite subject.]
- Chemistry [Incorrect. To find the answer, you needed to open the dataset in jamovi, then navigate to the 'Analyses' tab and choose 'Exploration', then 'Descriptives' from the pulldown menu. Place 'Studying_per_week' in the Variables box, then 'Favourite_subject' in the Splity by box. Next, go to the 'Statistics' pulldown below and make sure that 'Standard deviation' is checked. You should see a Descriptives table of standard deviations broken down by favourite subject.]
- Maths [Incorrect. To find the answer, you needed to open the dataset in jamovi, then navigate to the 'Analyses' tab and choose 'Exploration', then 'Descriptives' from the pulldown menu. Place 'Studying_per_week' in the Variables box, then 'Favourite_subject' in the Splity by box. Next, go to the 'Statistics' pulldown below and make sure that 'Standard deviation' is checked. You should see a Descriptives table of standard deviations broken down by favourite subject.]
- Music [Incorrect. To find the answer, you needed to open the dataset in jamovi, then navigate to the 'Analyses' tab and choose 'Exploration', then 'Descriptives' from the pulldown menu. Place 'Studying_per_week' in the Variables box, then 'Favourite_subject' in the Splity by box. Next, go to the 'Statistics' pulldown below and make sure that 'Standard deviation' is checked. You should see a Descriptives table of standard deviations broken down by favourite subject.] 
- Psychology [Correct!]





Question 7
---------------------------

In a new column of data, calculate the natural log (i.e., 'ln') of distance walked per day (column 'Distance_walked'). What is the mean of this logged dataset? Write your answer to 2 significant figures, and do not include units in your answer.

Answer 7
--------------------------

-0.19

[Correct answer: -0.19 -- If incorrect, write: To answer this question, you needed to go to the Data tab in Jamovi and Compute a new variable. Choose LN from the function box ($f_{x}$), then put 'Distance_walked' within the parentheses, so the formula reads "=LN(Distance_walked)". Once this new column is created, you then need to go to Exploration and Descriptives, and put the newly created logged Distance walked in the 'Variables' box.  You will see that the mean of the logged dataset is -0.188, which to 2 significant figures is -0.19.]

Question 8
---------------------------

What is the coefficient of variation of distance walked per day (column 'Distance_walked')? Write your answer as a percentage (not a proportion) to 1 decimal place, but **do not** include the percentage symbol (%) in your answer (hint: do not round until the last step of your calculations).



Answer 8
--------------------------

92.8 

[Correct answer: 92.8  -- If incorrect, write: To calculate this, you needed to open the dataset in Jamovi, then navigate to the 'Analyses' tab and choose 'Exploration', then 'Descriptives' from the pulldown menu. Place 'Distance_walked' in the Variables box. Next, go to the 'Statistics' pulldown below and make sure that 'Mean' and 'Standard deviation' are checked. The Descriptives table will show that the Mean is 1.22793 and the Standard deviation is 1.13912 km, respectively. To get the coefficient of deviation, we need to divide, 1.13912/1.22793 = 0.927675. If we express this as a percentage, then the value is 92.68293. Rounded to 1 decimal place, we get our answer of 92.8.]

Question 9
---------------------------

What is the standard error of the mean of distance walked for students who do not have a driving licence? Report the answer to 4 significant figures.

Answer 9
--------------------------

0.1800 

[Correct answer: 0.1800 -- If incorrect, write: To calculate this, you needed to open the dataset in jamovi, then navigate to the 'Analyses' tab and choose 'Exploration', then 'Descriptives' from the pulldown menu. Place 'Distance_walked' in the Variables box, and 'Driving_license' in the Split by box. Next, go to the 'Statistics' pulldown below and make sure that 'Std. error of Mean' is checked. The Descriptives table will show that the standard error is 0.180 for students without a driving licence and 0.125 for students with a driving licence. The correct value is therefore 0.180, but this is only expressed in 3 significant figures. We therefore need to add another zero to get 0.1800, which gives 4 significant figures.]

Question 10
---------------------------

Which of the following variables has the highest standard deviation?

Answer 10
--------------------------

- Age [Incorrect. To calculate this, you needed to open the dataset in Jamovi, then navigate to the 'Analyses' tab and choose 'Exploration', then 'Descriptives' from the pulldown menu. Place 'Age', 'Sleep', 'Distance_walked', and 'Lung_capacity' in the Variables box. Make sure that Std deviation is checked in the Statistics options below. A table will be made showing statistics for each of the 4 variables. The variable with the largest standard deviation is Lung Capacity, which has a standard deviation of 9.50.]
- Sleep [Incorrect. To calculate this, you needed to open the dataset in Jamovi, then navigate to the 'Analyses' tab and choose 'Exploration', then 'Descriptives' from the pulldown menu. Place 'Age', 'Sleep', 'Distance_walked', and 'Lung_capacity' in the Variables box. Make sure that Std deviation is checked in the Statistics options below. A table will be made showing statistics for each of the 4 variables. The variable with the largest standard deviation is Lung Capacity, which has a standard deviation of 9.50.]
- Distance walked [Incorrect. To calculate this, you needed to open the dataset in Jamovi, then navigate to the 'Analyses' tab and choose 'Exploration', then 'Descriptives' from the pulldown menu. Place 'Age', 'Sleep', 'Distance_walked', and 'Lung_capacity' in the Variables box. Make sure that Std deviation is checked in the Statistics options below. A table will be made showing statistics for each of the 4 variables. The variable with the largest standard deviation is Lung Capacity, which has a standard deviation of 9.50.]
- Lung capacity [Correct!]








