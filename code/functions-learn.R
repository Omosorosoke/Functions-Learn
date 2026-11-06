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
