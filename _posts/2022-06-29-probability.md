---
layout: post
title: "Probability: Expectation, Variance, and Conditional Probability"
date: 2022-06-29 17:22:00
---

Welcome back to my journey through prepping for the Google Product Analyst interview! Today we'll dive into some basic probability concepts, like expectation and variance, and explore conditional probability. I'll probably write further on more probability concepts in another post, but for now we'll start with this since those were the topics explicitly called out in the recruiter's email for prepping for this interview.

## 1. Expectation

The expectation of a random variable, $X$, formally written as $E[X]$, is the theoretical mean of the random variable. This means it's a _population parameter_, not a statistic. To calculate it, you need to know the values in your sample and the probability that each of those values will occur. Let's start with a simple example, where the probability is evenly distributed. Consider rolling a die. What is the average roll?

$$ E[X] = \sum\limits^{n}_ {i=1} {x_i p(x_i)}$$

Since the probability of rolling a fair die is $1/6$ for each side, the calculation is as follows:
$$ E[X] = x_1p_1 + x_2p_2 + x_3p_3 + x_4p_4 + x_5p_5 + x_6p_6$$
$$ E[X] = 1 * \frac{1}{6} + 2 * \frac{1}{6} + 3 * \frac{1}{6} + 4 * \frac{1}{6} + 5 * \frac{1}{6} + 6 * \frac{1}{6} = 3.5$$

This was a pretty easy scenario, and it assumes the probability of each outcome is exactly the same. <a href="https://en.wikipedia.org/wiki/Expected_value">Wikipedia</a> goes on to offer a second example, using the game of roulette. In the game of roulette, there's a small ball and 38 numbered pockets. A player can place a \$1 bet that the ball will fall in a specific number. If it does, they win \$35. If not, they lose their dollar. What is the expected payout?

$$E[gain from \$1 bet] = -\$1 * \frac{37}{38} + \$35 * \frac{1}{38} = -\frac{1}{19}$$

Repeating this bet 190 times would yield an expected payout of \$-10. Not a very good deal!

Let's try one more example. Suppose the approval rating for the president is 60%. You take a sample of two Americans and want to know the expected value for the number that approve of the president. The probability of 0, 1, or both sampled adults approving is given by the following table, given that we know that the approval rating is 60%.

| $x$    | $0$    | $1$    | $2$    |
|--------|--------|--------|--------|
| $p(x)$ | $0.16$ | $0.48$ | $0.36$ |

Thus, our expectation would be

$$ E[X] = \sum\limits^{2}_ {i=0} {x_i p(x_i)} = 0 * 0.16 + 1 * 0.48 + 2 * 0.36 = 1.2$$

Pretty simple, right? In the next section, we'll explore _variance_, a concept closely related to standard deviation, and see how it's related to the mean, or expectation.

## 2. Variance

The variance of $X$ is the average squared distance from the mean, $\mu$. Written formally, this is given by the following equation:

$$Var(X) = E[(X-\mu)^2] = \sum\limits^{n}_ {i=1}{(x-\mu)^2 * p(x)}$$

Variance is also sometimes written as $\sigma^2$, because the square root of variance is equal to the standard deviation, normally given by $\sigma$.

A handy relationship is given below:

$$ E[(X-\mu)^2] = E[X^2] - [E[X]]^2 = E[X^2] - \mu^2$$

Let's take the example of the distribution over $[0, 1, 2]$ for presidential approval rating and calculate the variance. Recall that $E[X] = 1.2$ for that probability distribution. Now let's calculate $E[X^2]$.

$$E[X^2] = \sum{x^2 * p(x)}$$
$$ = 0^2 * 0.16 + 1^2 * 0.48 + 2^2 * 0.36 = 1.92$$

Using our second equation, we can now easily calculate that
$$ \sigma^2 = E[X^2] - [E[X]]^2 = 1.92 - 1.2^2 = 1.92 - 1.44 = 0.48$$

To prove this to ourselves, we can calculate it out the "hard way":

$$ \sigma^2 = E[(X-\mu)^2] = (0-1.2)^2 * 0.16 + (1-1.2)^2 * 0.48 + (2-1.2)^2 * 0.36 = 0.48$$

Again, if we want to calculate the _standard deviation_ of this data, we would simply take the square root of the variance, so 

$$\sigma = \sqrt{var(x)} = \sqrt{0.48} \approx 0.69$$

The most important thing you need to know about variance is that it's a measure of the spread of the data. It's the square of the standard deviation, and it's calculated using the expectation of the difference of each value from the mean, squared.

I found <a href="https://www.youtube.com/watch?v=OvTEhNL96v0">this video</a> on Youtube from jbstatistics extremely useful in refreshing the concepts of expectation and variance.

## 3. Conditional Probability

The third topic mentioned regarding probability theory is conditional probability. For conditional probability, we want to know the probability of one thing occurring, given that another thing has occured. The most important thing to remember about conditional probability is Bayes' Theorem, which allows us to find $P(A|B)$ (the probability of A, given B) when we already know $P(B|A)$ (the probability of B, given A). Bayes' Theorem is pretty simple to memorize, and is given as follows:

$$ P(A|B) = \frac{P(B|A) * P(A)}{P(B)}$$

Let's do an example. You have two coins, one that is typical with heads and tails on either side. The other coin is rigged, with tails on both sides. You flip a coin without looking at which one it is, and you get tails. What is the probability that the coin is rigged?

Let's first set up our $P(A)$ and $P(B)$. We want to know $P(\text{coin is rigged})$ given $P(\text{tails})$ so 

$$P(A) = P(\text{coin is rigged})$$
$$P(B) = P(\text{tails})$$

Now we need the probability of both of these things, as well as $P(B|A)$, or the probability that you get tails given that the coin is rigged. Thankfully, these are super easy to work out.

$$P(B|A) = P(\text{tails|coin is rigged}) = 1$$
$$P(A) = P(\text{coin is rigged}) = 0.5$$
$$P(B) = P(\text{tails}) = 0.75$$

Hopefully these probabilities are fairly intuitive. Then, all you need to do is multiply them according to Bayes' Theorem:

$$P(A|B) = \frac{P(B|A) * P(A)}{P(B)} = \frac{1 * 0.5}{0.75} = \frac{2}{3} = 0.667$$

Awesome! As long as you commit Bayes' Theorem to memory, you should be good to go on conditional proabability. I think the tricky part is just remembering which goes on top and which goes on bottom out of $P(A)$ and $P(B)$ but I may have just gotten a stroke of brilliance... $P(A)$ goes _above_ so it's in the numerator and $P(B)$ goes _below_ so it's the denominator. Amazing!

Well, I think this was quite a bit easier than hypothesis testing. Definitely not everything I want to study regarding probability theory but it's a good start, so I think next I'll move on to linear and logistic regressions and then circle back to some more advanced probability topics if there's time, what do you think?

Until next time!

--Em

###### This post is part of a series on <a href="http://emily-hk.com/welcome-back/">Prepping for the Google Product Analyst Interview.</a>