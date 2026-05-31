Quiz 4 – Lichens and Marbles
=========================

This is the practice quiz for [Chapter 15](https://bradduthie.github.io/stats/Chapter_15.html) and [Chapter 16](https://bradduthie.github.io/stats/Chapter_16.html). To answer the questions in this quiz, you will need to use the [lichens.csv](http://bradduthie.github.io/stats_teaching/Quiz4/lichens.csv) dataset.  This dataset includes measurements of lichen colonies on walls in Scotland. Variables include the following: `wall_latitude`, `land_type`, `nearest_road` (km), `species_count`, `total_area` (proportion of wall covered), `pollution` (evidence of pollution or not).

Question 1
---------------------------
Assuming the sampled walls are a random sample of all walls in Scotland, what is the probability that any given Scottish wall shows evidence of pollution?  
Report your answer to **2 decimal places**.

Answer 1
--------------------------
{0.15, margin=0.01}  

[Correct answer: 0.15 -- if Incorrect: To get our best estimate of the probability that any given Scottish wall will show evidence of pollution, we need to find the proportion of walls that show evidence of pollution in the sample. In jamovi, we can find this out by opening the dataset and navigating to Exploration, then Descriptives. We can put 'pollution' in the Variables box and check the 'Frequency tables' box (just below the 'Split by' box). A box of frequencies will then open in the results panel, which shows that there are 35 polluted walls and 205 non-polluted walls. Hence, there are 35 + 205 = 240 walls in total sampled, and the proportion of walls that are observed to be polluted is 35/240  = 0.1458333. To report to 2 decimal places, we need to round this to 0.15.]


Question 2
---------------------------
Based on the lichens dataset, if you randomly select 3 walls **with replacement**, what is the probability that all 3 walls show **no** evidence of pollution?  
Report your answer to **2 decimal places** (do not round until the last step).

Answer 2
--------------------------
{0.62, margin=0.01}  
[Correct answer: 0.62 -- If incorrect: To answer this question, you needed to first recognise that the probability of a wall not being polluted is 205 / 240 = 0.8541667. This is the probability of sampling 1 wall that is not polluted. To sample three walls in a row that are not polluted, we need to multiply $0.8541667 \times 0.8541667 \times 0.8541667 = 8541667^3 = 0.6232006$. If we round this answer to 2 decimals, we get our final answer of 0.62.]

Question 3
---------------------------
Assume that the proportion of total area covered by lichens (`total_area`) is normally distributed. Use the **sample mean** and **sample standard deviation** (rounded to **3 significant figures**) to find the theoretical probability that a wall has **over 50%** of its area covered. Report your answer to **2 decimal places**.

Answer 3
--------------------------
{0.14, margin=0.005}  
[Correct answer: 0.14 -- If incorrect: First you needed to find the mean and standard deviation of the total_area variable in jamovi. To do this, navigate to Exploration and Descriptives, then put 'total_area' in the Variables box. Make sure that 'Mean' and 'Std. deviation' are selected in the statistics boxes below. You will find that the mean is 0.393 and the standard deviation is 0.0993. Both of these are already taken to 3 significant figures. Next, go to the distrACTION module and select 'Normal Distribution'. Set the mean to 0.393 and the SD to 0.0993. Choose the function 'Compute probability and set x1 = 0.5. Since you want to know the probability of a value being greater than 0.5, you need to check the second radio button where $P(X \geq x1)$. The answer will appear in the panel to the right. The probability is 0.141, which is 0.14 rounded to 2 decimals.]

Question 4
---------------------------
Using the same normal assumption, what is the theoretical probability that a wall has **between 25% and 50%** of its area covered? Report your answer to **2 decimal places**.

Answer 4
--------------------------
{0.78, margin=0.01}  
[Correct answer: 0.78 -- If incorrect: First you needed to find the mean and standard deviation of the total_area variable in Jamovi. To do this, navigate to Exploration and Descriptives, then put 'total_area' in the Variables box. Make sure that 'Mean' and 'Std. deviation' are selected in the statistics boxes below. You will find that the mean is 0.393 and the standard deviation is 0.0993. Both of these are already taken to 3 significant figures. Next, go to the distrACTION module and select 'Normal Distribution'. Set the mean to 0.393 and the SD to 0.0993. Choose the function 'Compute probability and set x1 = 0.25. Since you want to know the probability of a value being within an interval, you need to check the 3rd radio button where $P(x1 \leq X \leq x2) P ( x1 \leq X \leq x2 ) . The answer will appear in the panel to the right. Lastly, we need to set x2 = 0.5. The probability is 0.784, which is 0.78 when rounded to 2 decimal places.]

Question 5
---------------------------
Match each of the following four variables with the distribution that **best** describes them. (Hint: try histograms for `wall_latitude`, `species_count`, `total_area` – a histogram will not work for `pollution`.)

**5a. `wall_latitude`**  
Answer Match
--------------------------
- [ ] Normal  
- [X] Uniform  
- [ ] Binomial  
- [ ] Poisson  

[Correct answer: Uniform -- If incorrect: Wall latitude is mostly, albeit not perfectly, uniform. Of the available options, this is the best choice. Pollution is a yes/no variable, described best by a binomial distribution. Species count would describe a count of colonising species arriving on the wall, and the histogram for it is consistent with a Poisson distribution. Total area is a continuous variable that appears, from the histogram, to be reasonably normally distributed.]

**5b. `pollution`**  
Answer Match
--------------------------
- [ ] Normal  
- [ ] Uniform  
- [X] Binomial  
- [ ] Poisson  
 
[Correct answer: Binomial -- -- If incorrect: Wall latitude is mostly, albeit not perfectly, uniform. Of the available options, this is the best choice. Pollution is a yes/no variable, described best by a binomial distribution. Species count would describe a count of colonising species arriving on the wall, and the histogram for it is consistent with a Poisson distribution. Total area is a continuous variable that appears, from the histogram, to be reasonably normally distributed.]

**5c. `species_count`**  
Answer Match
--------------------------
- [ ] Normal  
- [ ] Uniform  
- [ ] Binomial  
- [X] Poisson   
[Correct answer: -- If incorrect: Wall latitude is mostly, albeit not perfectly, uniform. Of the available options, this is the best choice. Pollution is a yes/no variable, described best by a binomial distribution. Species count would describe a count of colonising species arriving on the wall, and the histogram for it is consistent with a Poisson distribution. Total area is a continuous variable that appears, from the histogram, to be reasonably normally distributed.]

**5d. `total_area`**  
Answer Match
--------------------------
- [X] Normal  
- [ ] Uniform  
- [ ] Binomial  
- [ ] Poisson   
[Correct answer: -- If incorrect: Wall latitude is mostly, albeit not perfectly, uniform. Of the available options, this is the best choice. Pollution is a yes/no variable, described best by a binomial distribution. Species count would describe a count of colonising species arriving on the wall, and the histogram for it is consistent with a Poisson distribution. Total area is a continuous variable that appears, from the histogram, to be reasonably normally distributed.]

Question 6
---------------------------
For which of the following variables will the **sample means** be expected to be **normally distributed** around the true mean $\mu$? (Check all that apply.)

Answer 6
--------------------------
- [X] `wall_latitude`  
- [X] `nearest_road`  
- [X] `total_area`  
- [X] `species_count`  
- [ ] none of the above  
- [ ] it is impossible to determine  

[All should be checked for a correct answer. -- If incorrect: As a consequence of the central limit theorem, the sample means of all of the above variables should be normally distributed around the true mean.]

Question 7
---------------------------
The standard deviation of sample means is also known as which of the following?

Answer 7
--------------------------
- [ ] The standard deviation of the population  
- [X] The standard error  
- [ ] The mean of the sample means  
- [ ] The coefficient of variation  
- [ ] The Shapiro‑Wilk test  

[Correct answer: The standard error -- If incorrect: The standard error of the mean of a sample of data points, SE, is the sample standard deviation divided by the square root of the total number of data points in the sample. In other words, for a sample dataset with 'n' observations and a sample standard deviation of 's', then $SE=s/\sqrt{n}$. The standard error defines a confidence interval around our estimate of the sample mean compared with the true population mean. Conceptually, the standard error is also the standard deviation of sample means; i.e., if you were to repeatedly sample n data points from a population and calculate the mean of the n data points sampled each time, then the distribution of those sample means would have its own standard deviation (which is the standard error).]

---

**For questions 8‑10, use the following scenario:**

Bags of marbles are sold with 100 marbles per bag.  
Marbles come in two colours: red and blue.  
They also come in two sizes: small and large.  
You buy a bag that contains:
- 60 red marbles, 40 blue marbles.
- Among red marbles: ratio of 3 small : 1 large.
- Among blue marbles: ratio of 8 small : 5 large.

Question 8
---------------------------
If a marble is randomly selected from your bag (regardless of size), what is the probability of selecting a **red** marble?  Give your answer as a probability with **three significant figures** (e.g., 0.213, not 21.3%).

Answer 8
--------------------------
{0.600, margin=0.001}  
[Correct answer: 0.600 -- If incorrect: The correct answer to this question was 0.600, and you can calculate it by dividing the number of red marbles in the bag (60) by the total number of marbles in the bag (100). Hence, the answer is 60/100 = 3/5 = 0.600 (note the three significant figures in the final answer).]

Question 9
---------------------------
If a marble is selected entirely at random from the bag, what is the probability of selecting a **small blue** marble?  
Give your answer with **three significant figures**.

Answer 9
--------------------------
{0.246, margin=0.001}  
[Correct answer: 0.246 -- If incorrect: To answer this question, we first need to recognise from the paragraph above question 23 that the probability of selecting a blue marble is 0.4 (40 red marbles divided by 100 total marbles). Next, because there are 8 small blue marble for every 5 large blue marbles, the probability that a blue marble is small is 8/(5 + 8) = 8/13 = 0.6153846. To calculate the probability that we pull a small blue marble from the bag, we now need to find the probability that a marble is blue (0.4) and if so, that it is small (0.6153846). To do this, we multiply the probabilities, $Pr(Small,Blue)=\frac{40}{100} \times \frac{8}{13} = 0.4 \times 0.6153846 = 0.2461538$. After rounding this answer to three significant figures, we get 0.246.]

Question 10
---------------------------
If you pull **two different marbles** out of the bag entirely at random (sampling **without replacement**), what is the combined probability of first selecting a **large red** marble, then a **small blue** marble?  
Give your answer with **three significant figures**.

Answer 10
--------------------------
{0.0373, margin=0.005}  
[Correct answer: 0.0373 -- If incorrect: To answer this question, we first must note that the probability of selecting a red marble is 0.6 (60 red marbles divided by 100 total marbles). There is 1 large red marble for every 3 small red marbles, so the probability that a red marble is large is 1/(1 + 3) = 1/4 = 0.25 (i.e., for every four red marbles, one is expected to be large and three are expected to be small, so one in four red marbles is large). Hence, to get the probability that we first pull a large red marble from the bag, we need the probability that the marble will be red (0.6) and the probability that the red marble will be large (0.25). With these two probabilities, we multiply to get the probability that the first marble is large and red, $Pr(Large,Red) = \frac{6}{10} \times \frac{1}{4} = \frac{6}{40} = \frac{3}{20} = 0.15$. Now we can consider the second marble. Note that after pulling the first marble out of the back, we have 99 marbles left. We are therefore sampling without replacement (i.e., sampling without putting the first marble back in the bag, so it cannot be sampled again). If we were to put the first marble back into the bag, then we would be sampling with replacement (i.e., replacing after sampling the first). Now having selected one large red marble, there are still 40 blue marbles left in the bag out of our total 99. The probability of selecting a blue marble is therefore 40/99 = 0.4040404. Using the same logic as with the red marble in our first selection, we know that the ratio of blue marbles is 8 small to 5 large, so the probability that any blue marble selected is also small is 8/(8 + 5) = 8/13 = 0.6153846. We again need the probability that a marble is blue and that it is small, so we multiply, $Pr(Small,Blue)=\frac{40}{99}\times{8}{13}=0.2486402$. Now, to get the probability that the first marble we pull from the bag is large and red, and the second marble is small and blue, we need to multiply our probabilities Pr(Large, Red) and Pr(Small, Blue) together, $0.15 \times 0.2486402 = 0.03729603$. After rounding this answer to three significant figures, we get 0.0370.]
