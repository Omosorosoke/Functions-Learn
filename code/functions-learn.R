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
  round(mean(x, na.rm = TRUE), digits)
} # The dot ... argument takes everything else. You should name arguments that comes after ... when defining them.

rounded_mean(c(3, 5, 7, 8, NA))

# Lazy evaluation

# The value of an argument is not automatically used when you call a function 
# but only when it is needed in the body of that function.


\(x) mean(x)


show_first <- function(x, y) {
  cat('starting\n')
  x + y
} 

show_first(2, undefined)

stop('boom')



describe(x, digits = 2, na.rm = TRUE)


describe(x, digits = 2, na.rm = TRUE) {
   answer <- c()
  answer <- c(answer, mean(x, na.rm = TRUE) )
  answer <- (mean(x, na.rm = TRUE), median(x, na.rm = TRUE),sd(x, na.rm = TRUE)), 
} 