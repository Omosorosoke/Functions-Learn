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
