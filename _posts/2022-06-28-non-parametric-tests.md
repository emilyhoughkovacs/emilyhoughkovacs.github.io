---
layout: post
title: "Hypothesis Testing: Assumptions and Non-Parametric Tests"
date: 2022-06-28 16:27:00
---

###### This post is part of a series on <a href="http://emily-hk.com/welcome-back/">Prepping for the Google Product Analyst Interview.</a>
###### This post is the fourth of a four-part series on Hypothesis Testing. <a href="http://emily-hk.com/testing-proportions/">Part 1 here</a>. <a href="http://emily-hk.com/t-tests-and-more/">Part 2 here.</a> <a href="http://emily-hk.com/chi-squared/">Part 3 here</a>.

Welcome back to my journey through prepping for the Google Product Analyst interview! Today we are going to go over some assumptions we've made so far which has allowed us to use the tests introduced in Parts 1, 2, and 3. Then, we'll go over what to do when those assumptions are not met and some alternative tests we can use.

As with the previous three parts, this blog post is a review of the DataCamp course <a href="https://campus.datacamp.com/courses/hypothesis-testing-in-python">Hypothesis Testing in Python</a> taught by James Chapman. However, you don't need to have DataCamp access in order to follow along with the concepts presented here.

## 1. Assumptions Made by Parametric Tests

### 1. Randomness

#### Assumption
The samples are random subsets of larger populations.

#### Consequence
If this is not true, the sample will not be representative of the larger population.

#### How to Check This
There are no statistical or coding tests to check this, as the greater population is unknown. The best thing you can do is check with those who collected their sample data for their methodology (this might be you as a data scientist) and evaluate whether there may have been bias introduced in the sampling method. For more on this, recall section 1 on Sampling Bias of my blog post on <a href="http://emily-hk.com/sampling/">Sampling and Bootstrapping</a>. You may also want to consult with a domain expert.

### 2. Independence of Observations

#### Assumption
Each observation (row) in the dataset is independent. Special cases like the paired t-test may break this rule but this changes our calculations.

#### Consequence
Failure to account for this can lead to increased chance of false negative or false positive errors.

#### How to Check This
Again, this is not something we can check for using statistics or Python. We would need to understand more about how the data was collected in order to determine independence across observations.

### 3. Large Enough Sample Size

#### Assumption
The sample is large enough that the Central Limit Theorem applies and the sample distribution can be assumed to be normally distributed. Recall from <a href="http://emily-hk.com/sampling/">Sampling and Bootstrapping</a> that the Central Limit Theorem states that if you take sufficiently large random samples from your dataset with replacement, then the distribution of the sample means will approximate a normal distribution. Furthermore, the mean of these sample means will approximate the mean of the population.

#### Consequence
If the sample is not sufficiently large enough, you will have wider confidence intervals and are at a higher risk for false positives and false negatives. Essentially, if the Central Limit Theorem does not apply, the calculations done on the sample and any conclusions drawn thereof could be meaningless.

#### How to Check This
This is the one assumption of the three that we can check systematically. There are heuristics based on each test that provide a guideline for what is "large enough".

##### T-Test

Essentially, in all T-tests the sample must have at least 30 observations in each group. Note that this means that you can't compensate for one minority group by making the majority group larger. The exact definitions are given below.

###### One-Sample
At least 30 observations in the sample.
$$n \geq 30$$

###### Two-Sample
At least 30 observations in both samples.
$$n_1 \geq 30$$
$$n_2 \geq 30$$

###### Paired
At least 30 paired observations.
$$n \geq 30$$

###### ANOVA
At least 30 observations in each group.
$$n_i \geq 30 \text{for each i, where i is the number of groups}$$

A good way to gut-check this is to plot the null distribution and if it appears normal, then the sample is large enough.

##### Proportion Tests

Proportion tests are a bit more forgiving. Generally you need 10 samples of each group, failures and successes. Where $n$ is the sample size for the group and $\hat{p}$ is the proportion of successes, this is given mathematically by the following:

###### One-Sample
At least 10 successes and at least 10 failures.
$$n * \hat{p} \geq 10$$
$$n * (1 - \hat{p}) \geq 10$$

###### Two-Sample
At least 10 successes and at least 10 failures in both samples.
$$n_1 * \hat{p}_ 1 \geq 10$$
$$n_1 * (1 - \hat{p}_ 1) \geq 10$$
$$n_2 * \hat{p}_ 2 \geq 10$$
$$n_2 * (1 - \hat{p}_ 2) \geq 10$$

##### Chi-Square Tests

Chi-square tests are the most forgiving, requiring only 5 successes and 5 failures per group.

$$n_i * \hat{p}_ i \geq 5, \text{for each i}$$
$$n_i * (1 - \hat{p}_ i) \geq 5, \text{for each i}$$

A final sanity check can be done by taking a bootstrap distribution of the sample. If the bootstrap distribution doesn't look normal, one or more of the three above assumptions likely aren't valid. You'll have to revisit the data to check for randomness, independence, and sample size.

## 2. Extending the Paired T-Test with the Wilcoxon-signed Rank Test

So what do you do if your assumptions are not met? So far, the tests we have gone over are all examples of _parametric tests_. The tests we are going to go into today are known as _non-parametric tests_, and can be used when the assumptions of normal distribution and large enough sample size are not met.

For our non-parametric tests, we are going to be considering _ranked_ data. A small example is here.

```
x = [1, 15, 3, 10, 6]

from scipy.stats import rankdata
print(rankdata(x))

>> array([1, 5, 2, 4, 3])
```

As you can see, ranking data puts it in order from smallest to largest and simply returns the number, one-indexed, of the ordering for each value.

### Wilcoxon-signed Rank Test

The first test we are going to consider is analogous to the paired t-test. It is known as the Wilcoxon-signed rank test. To use it, we calculate the test statistic known as $W$. I'm going to go through the steps to calculate it, but ultimately we can use a package from `pingouin` to avoid having to calculate $W$ by hand.

1. Calculate the difference in the two pairs.
2. Take the absolute value of the differences
3. Rank-order the absolute value of differences using `scipy.stats.rankdata`.
4. Calculate the test statistic by finding `T_minus` and `T_plus`. `T_minus` is the sum of the ranks of all negatively signed differences, and `T_plus` is the sum of the ranks of all positively signed differences. Then take the minimum of these two values by calling `np.min([T_minus, T_plus])`.

Now for the easy way.

```
import pingouin
alpha = your_alpha_here

pingouin.wilcoxon(
    x=data['x'],
    y=data['y'],
    alternative=['less', 'greater', 'two-sided']
    )
```

This function will return the W-value but also the p-value. At this point you can decide whether to reject the null or not depending on the comparison of the p-value to your alpha. Note that you don't have to pass `paired=True` to the `wilcoxon` function since this test is only for paired values. We will go into the non-parametric test for unpaired values next.

## 3. Wilcoxon-Mann-Whitney Test and Kruskal-Wallis Test

### Wilcoxon-Mann-Whitney Test

The Wilcoxon-Mann-Whitney test, also known as the Mann Whitney U test, is the analogous version of unpaired t-tests for non-parametric tests. It's essentially a t-test on ranked data. To use it, we need to change our data into wide format by using `pivot`. For example, if we want to compare compensation between the two groups categorizing when a Stack Overflow user began coding, we would do the following:

```
age_vs_comp = stack_overflow[['compensation', 'age_first_coded']]
age_vs_comp_wide = age_vs_comp.pivot(
    columns='age_first_coded',
    values='compensation'
    )
```

We would then have two columns, one for people's income who started coding as children, and one for people who started coding as adults. Each row would show compensation in one column and `nan` in another column, since a person can either belong to one category or the other. The following code will run a Wilcoxon-Mann-Whitney test on this data:

```
import pingouin
alpha = 0.01

pingouin.mwu(
    x=age_vs_comp_wide['child'],
    y=age_vs_comp_wide['adult'],
    alternative='greater'
    )
```

It's that easy!

### Kruskal-Wallis Test

Just as ANOVA extends t-tests to more than two groups, the Kruskal-Wallis test extends Wilcoxon-Mann-Whitney to more than two groups. Its code is pretty similar, too. Can you guess it? Using the example of compensation across job satisfaction categgories, we have:

```
import pingouin
pingouin.kruskal(
    data=stack_overflow,
    dv='compensation',
    between='job_satisfaction'
    )
```
## 4. Closing and Takeaways

Well, we've gone over quite a bit in the last few days! In <a href="http://emily-hk.com/testing-proportions/">Part 1</a> we were introduced to hypothesis tests through proportion tests and took a look at type I (false positive) and type II (false negative) errors.

In <a href="http://emily-hk.com/t-tests-and-more/">Part 2</a>, we extended our knowledge of hypothesis testing to t-tests, paired t-tests and ANOVA, for two samples, two paired samples, and more than two groups of samples, respectively.

<a href="http://emily-hk.com/chi-squared/">Part 3</a> brought us back to proportion tests, but this time eliminated the need for bootstrapping to find the standard error based on the assumption that $H_0$ is true. It also introduced us to chi-square tests of independence and the chi-square goodness-of-fit test. The test of independence tests whether there is independence among two variables where there is more than two groups in one of the variables, and the chi-square goodness of fit test evaluates a proportion distribution to a hypothesized distribution.

Finally, in this section, we go beyond parametric tests to understand their underlying assumptions, and what to do for the paired t-test, regular t-test, and ANOVA cases when those assumptions are not met.

I've learned a lot and feel a lot more prepared for Google and just interviewing in general, and I hope those of you reading have learned a lot too. The next steps for me is going to be a review of basic probability, including expectation, variance, and conditional probability, but also diving in to the Central Limit Theorem again, the law of large numbers, as well as Bernoulli trials and the binomial distribution, normal, Poisson, and geometric distributions. It's a lot to cover but I expect that it will be a bit easier than what we've just done, mostly because some of those concepts are actually foundational to the work we've done here. Looking forward to a nice breather and review of some fun probability topics!

Until next time!

--Em