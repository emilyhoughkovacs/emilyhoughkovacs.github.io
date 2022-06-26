---
layout: post
title: "Hypothesis Testing: Testing Proportions and Types of Errors"
date: 2022-06-26 15:40:00
---

<sub>This post is part of a series on <a href="http://emily-hk.com/welcome-back/">Prepping for the Google Product Analyst Interview.</a>
This post is the first of a four-part series on Hypothesis Testing. Part 2, part 3, and part 4 are forthcoming.</sub>

Welcome back to my journey through prepping for the Google Product Analyst interview! Today we are going through an introduction to hypothesis testing with an example use case of comparing a proportion to a hypothesized value. We will go over calculating the z-score, p-value, and evaluating whether the test was a success or not. We will also cover Type I and Type II errors.

Again, this blog post is a review of a DataCamp course taught by James Chapman. Today's course is <a href="https://campus.datacamp.com/courses/hypothesis-testing-in-python">Hypothesis Testing in Python</a>, but you don't need to have access to DataCamp in order to follow along.

Before we start, let's go over some definitions. First, what is a hypothesis? A hypothesis is a _statement about an unknown population parameter_. For example, you might have a sample of data that shows the percent of data scientists who started programming before age 14, according to a study. This doesn't tell us anything about the _population parameter_, since it's just a sample of data scientists, not all data scientists in the world. We can then make a hypothesis that the percent of data scientists who started programming before age 14 is a certain percent, let's say 35%. Our hypothesis test will help us analyze whether this is reasonable or not.

A hypothesis test compares two competing _hypotheses_. Either one or the other can be true, but not both. The two hypothesis are traditionally known as the _null hypothesis_, denoted $H_0$, and the _alternative hypothesis_, denoted $H_A$. The assumption is always that the null hypothesis is true, and it is our job to disprove that or accept that null hypothesis. This is called _rejecting the null_ or _failing to reject the null_. In this way, a hypothesis test is similar to a criminal trial. In a criminal trial there can be (essentially) two verdicts: guilty or not guilty. Additionally, for simplicity's sake, let's say a defendant can either have committed the crime, or not committed the crime. Finally, the defendant is assumed to be not guilty, unless proven otherwise "beyond a reasonable doubt".

In hypothesis testing, "reasonable doubt" is known as the _significance level_. This is a cutoff parameter that you choose yourself based on industry experience, best practices, and the tradeoff you are willing to make between false positive and false negative errors (more on that later). Traditionally a common cutoff for the significance level (also known as _alpha_) is set at 0.05.

So how do you check if a calculated sample statistic statistically significantly different from a chosen value? Here are the steps:

1. Calculate your sample statistic (or point estimate) from your sample dataset.
2. Choose your expected (hypothesized) value and your $\alpha$.
3. Calculate the standard error from bootstrapping. As a reminder, this is done by calling $np.std(\text{bootstrap_dist, ddof=}1)$
4. Standardize your value by calculating the z-score, which is a measure of how many standard deviations above or below the mean a value is. This is calculated as follows:
$$ \frac{\text{sample stat - hypothesized parameter value}}{\text{standard error}} $$
5. Calculate the p-value by passing the z-score to `norm.cdf()`. For a left-tailed test you will use $\text{norm.cdf(z-score)}$ and for a right-tailed test you will use $\text{1-norm.cdf(z-score)}$.

But wait, what is a p-value? The p-value is the probability of obtaining a result, assuming $H_0$ is true. Essentially, it measures the support for $H_0$. If the p-value is large -- larger than our chosen significance level, then you fail to reject the null hypothesis. If it's smaller, then you reject the null hypothesis in favor of the alternative hypothesis. Because of this, it's important to always choose your $\alpha$ before caclulating the p-value. This way you won't be a victim of what's known as "p-hacking", or choosing a significance level that gives you the hypothesis that you prefer.

You may have also noticed that in step 5 I referenced something called a left-tailed test or a right-tailed test. This is in reference to the null distribution. Hypothesis tests check if the sample statistic lies within the tails of the null distribution. If a test is checking for whether a value is _less than_ the hypothesized value, it's a left-tailed test. If it's checking if it's _greater than_ the hypothesized value, it's a right-tailed test. You can also simply check if the value is equal to the hypothesized value or not, making it a two-tailed test, but I'll go into this in greater detail in another blog post.

Finally, you will choose a confidence interval. This will give you a range of plausible values for your population parameter. For an alpha of 0.05, you would choose a 95% confidence interval. To calculate it, you would do as follows:
$$ \text{lower = np.quantile(boot_distn, 0.025)}
\text{upper = np.quantile(boot_distn, 0.975)} $$

The last topic in this chapter on hypothesis testing covered types of errors. They are summarized in the table below:

|             | actual $H_0$   | actual $H_A$    |
|-------------|----------------|-----------------|
| chose $H_0$ | correct        | false negative  |
| chose $H_A$ | false positive | correct         |
|             | *Type I error* | *Type II error* |

That's all for now. Join me back here next time for part 2 on t-tests, ANOVA, and pairwise t-tests.

--Em