#Logistic Regression  


Logistic regression is used to predict the class (or category) of
individuals based on one or multiple predictor variables (x). It is used
to model a binary outcome that is a variable, which can have only two
possible values: 0 or 1, yes or no, diseased or non-diseased. ther
synonyms are binary logistic regression, binomial logistic regression
and logit model.

The class of observations is not directly returned by logistic
regression. We can calculate the probability (p) of class membership.
There will be a 0--1 probability range. The threshold probability at
which the category changes from one to the other must be chosen.

**Logistic function**

The standard logistic regression function, for predicting the outcome of
an observation given a predictor variable (x), is an s-shaped curve
defined as  

**p = exp(y) / 1 + exp(*y*)** (James et al. 2014).  


This can be also simply written as p = 1/ 1 + exp(-y), where:

-   y = b~0~ + b~1~ *x*,

-   exp() is the exponential and

-   p is the probability of event to occur (1) given *x*.
    Mathematically, this is written as p(event=1\|*x*) and abbreviated
    as p(*x*), so p(*x*) =  1/1 + exp(-(b~0~ + b~1~ x))

It can be derived from above equation

**p/(1-p) = exp(b~0~ + b~1~ *x*)**  


By taking the logarithm of both sides, the formula becomes a linear
combination of predictors:

log (p/(1-p)) = b~0~ + b~1~ *x*.

When you have multiple predictor variables, the logistic function looks
like: log (p/(1-p)) = b~0~ + b~1~ x~1~ + b~2~ x~2~ + \... + b~n~ x~n~

b~0~ and b~1~ are the regression beta coefficients. A positive b~1~
indicates that increasing *x* will be associated with increasing p.
Conversely, a negative b~1~ indicates that increasing *x* will be
associated with decreasing p.

Odds ratio

The quantity log (p/(1-p)) is called the logarithm of the odd, also
known as log-odd or logit.

The odds reflect the likelihood that the event will occur. It can be
seen as the ratio of "successes" to "non-successes". Technically, odds
are the probability of an event divided by the probability that the
event will not take place (P. Bruce and Bruce 2017). For example, if the
probability of being diabetes-positive is 0.5, the probability of "won't
be" is 1-0.5 = 0.5, and the odds are 1.0.

Note that, the probability can be calculated from the odds as

p = Odds/(1 + Odds).
