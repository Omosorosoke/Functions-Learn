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
