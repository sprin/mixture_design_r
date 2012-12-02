# install.packages("/path/to/AlgDesign_1.1-7.tar.gz", repos = NULL, type="source")
library(AlgDesign)

# Mixture Design 1
#
# Three variables: x1, x2, x3
#
# Constraints on minimums:
# x1 >= 0.85 (l1)
# x2 >= 0.10 (l2)
l1 = 0.85
l2 = 0.10
# We can create pseudo-components which represent normalizing the 
# minimum values to 0.
#
# Define pseudo-components as:
# xpsi = (xi - li)/(1 - l_sum)
# where l_sum = sum(l1, l2...)
#
# Then, we can rewrite the real values in terms of the pseudo-components:
# xi = li + (1 - l_sum) * xpsi
l_sum = l1 + l2

x1fn <- function(x1) l1 + (1 - l_sum) * x1
x2fn <- function(x2) l2 + (1 - l_sum) * x2
x3fn <- function(x3) l3 + (1 - l_sum) * x3

# Now, using the AlgDesign package, we can create a level 3 mixture matrix for
# the pseudo-components.
pmix <- gen.mixture(3, c("x1", "x2", "x3"))

# To get the real component values, we can split the matrix, apply the
# conversion functions to each column, then recombine the columns.
real_mix <- cbind(
                  apply(pmix[1], 2, x1fn),
                  apply(pmix[2], 2, x2fn),
                  apply(pmix[3], 2, x3fn))


# Mixture Design 2
#
# Same as Mixture Design 1, but now with a maximum constraint.
# x1 >= 0.85 (l1)
# x2 >= 0.10 (l2)
# x3 <= 0.025
n = 3
l1 = 0.85
l2 = 0.10
m3 = 0.025

# How do we do this?
