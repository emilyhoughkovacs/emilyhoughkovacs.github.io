---
layout: post
title: "Hypothesis Testing: Assumptions and Non-Parametric Tests"
date: 2022-06-28 16:27:00
---

###### This post is part of a series on <a href="http://emily-hk.com/welcome-back/">Prepping for the Google Product Analyst Interview.</a>
###### This post is the fourth of a four-part series on Hypothesis Testing. <a href="http://emily-hk.com/testing-proportions/">Part 1 here</a>. <a href="http://emily-hk.com/t-tests-and-more/">Part 2 here.</a> <a href="http://emily-hk.com/chi-squared/">Part 3 here</a>.

Welcome back to my journey through prepping for the Google Product Analyst interview! Today we are going to go back to the <a href="http://emily-hk.com/testing-proportions/">proportion testing we did in part 1</a>, but use a workaround to avoid having to bootstrap. Then, we'll extend our proportion tests to more than two groups using the Chi-Square test of independence. Finally, we'll use the Chi-Square goodness-of-fit test to compare a distribution of proportions to a hypothesized distribution.

As with the last two posts in this series, this blog post is a review of the DataCamp course <a href="https://campus.datacamp.com/courses/hypothesis-testing-in-python">Hypothesis Testing in Python</a> taught by James Chapman. However, you don't need to have DataCamp access in order to follow along with the concepts presented here.