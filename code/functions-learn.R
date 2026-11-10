library(pointblank)
library(tidyverse)
library(scales)
library(fs)

dir_create("code")

c_to_f <- function(celsius) {
  celsius * 9 / 5 + 32
}

c_to_f(0)
c_to_f(100)
c_to_f(c(-40, 37))


bmi <- function(weight_kg, height_m) {
  weight_kg / height_m^2
}

bmi(c(89, 7), c(67, 4))

percent_score <- function(mark, total) {
  round(mark / total * 100, 1)
}


# Recycling and vectorization --------------------------------------------

percent_score(c(45, 30, 18), 60) # The single value of the second argument is reused for each of the element in the vector
squart_it <- function(n) {
  n^2
}

squart_it() # Calling this with no argument would return a error


# Working with arguments -------------------------------------------------

# Passing extra arguments with the "..." argument.
rounded_mean <- function(x, ..., digits = 2) {
  round(mean(x, na.rm = TRUE), digits) # Any unnamed value goes into ... everythingelse
} # The dot ... argument takes everything else. You should name arguments that comes after ... when defining them.

rounded_mean(c(3, 5, 7, 8, NA))

# Lazy evaluation

# The value of an argument is not automatically used when you call a function
# but only when it is needed in the body of that function. Hence, the code below evaluates with no error.

show_first <- function(x, y) {
  cat('starting\n')
  x + y
}

show_first(2, undefined)


# Working

describe <- function(x, digits = 2, na.rm = TRUE) {
  answer <- c(
    mean = mean(x, na.rm = na.rm),
    median = median(x, na.rm = na.rm),
    sd = sd(x, na.rm = na.rm)
  )
  answer <- round(answer, digits)
  answer
} #  When you provide a value for a default argument, you still need to restate in the body to give the caller a preference for the value of the argument

# Exercises
describe(c(4, 8, 15, 16, 23, 42))

describe(c(4, 8, NA, 16), digits = 1)
describe(c(4, 8, NA, 16), na.rm = FALSE)

data.frame()

make_label <- function(..., sep = '|') {
  paste(...)
}

make_label(
  "R",
  "functions"
)

make_label(
  'a',
  'b',
  sep = "-"
) # An argument of my function is not automatically passed to the functions I call inside it, even if it has the same name. I have to pass it on myself.
# Each function has its own separate set of arguments. Your sep and paste()’s sep just share a name. They aren’t connected until you link them.

make_label <- function(..., sep = " | ") {
  paste(...) # paste() uses its own default sep, " "
}

make_label <- function(..., sep = " | ") {
  paste(..., sep = sep) # now paste() uses your sep
} #  So your argument can control the inner function. That only happens when you pass it on explicitly, with sep = sep or na.rm = na.rm. If you don’t, the inner function falls back to its own default.


# Module 3 - Return values and scope -------------------------------------

# This module answers two questions: what comes out of a function, and where a function looks for the variables it uses.

#  Return
##  Explicit return ()
safe_divide <- function(a, b) {
  if (b == 0) {
    return(NA) # leave now, and skip the rest
  }
  a / b
}

safe_divide(10, 2)
safe_divide(10, 0)

##  To return multiple values with a list

totals <- function(x) {
  list(
    total = sum(x),
    count = length(x),
    values = x
  )
}

result <- totals(c(4, 7, 9))
result$total
result[["count"]]
result$count

##  Return a value without printing it

log_note <- function(text) {
  cat("Note:", text, "\n")
  invisible(text)
}

log_note("data loaded")
saved <- log_note("model fitted")
saved


# Scope and lexical scoping --------------------------------------------------------
## Scope
### At every function call, R creates a new and unique workspace called an environment that houses its arguments and every other variables inside it. Each environment is recreated with a new call and nothing is carried forward.

## lexical scoping
#  Where a variable is needed by a function, the function looks at where the function was defined and not where it was called.
#  Two environment global environment and function environment. You can check a function environment with this syntax  ; environment()
#  Execustion environment, enclosing environment and parent environment

#  When a function uses a name it didn’t create itself, R searches in this order: the function call’s own workspace, holding its arguments and any variables the body creates, then in the workspace around where the function was written, then outward from there until it reaches the global workspace and finally the packages.
rate <- 0.1

add_tax <- function(price) {
  price * (1 + rate) # rate isn't an argument, so R looks outside
}

add_tax(100)
#> [1] 110

rate <- 0.2
add_tax(100)
#> [1] 120      # same call, different answer

#  Good practice: Do not rely on global environment; pass everything a function needs as an argument .
add_tax <- function(price, rate = 0.1) {
  price * (1 + rate)
}

invisible('Kola')

range_info(c(3, 9, 4, 12))

range_info <- function(x) {
  list(
    min = min(x),
    max = max(x),
    width = max(x) - min(x)
  )
}

check <- range_info(c(3, 9, 4, 12))
check$width
check[['width']]

scale_01 <- function(x) {
  if (max(x) == min(x)) {
    return(
      rep(0, 3)
    )
  }
  (x - min(x)) / (max(x) - min(x))
}

scale_01(c(2, 4, 6))
scale_01(c(5, 5, 5))
