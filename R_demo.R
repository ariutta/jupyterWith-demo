# ---
# jupyter:
#   jupytext:
#     formats: ipynb,R:light
#     text_representation:
#       extension: .R
#       format_name: light
#       format_version: '1.4'
#       jupytext_version: 1.2.4
#   kernelspec:
#     display_name: R - JuniperKernel
#     language: R
#     name: juniper_juniperkernel
# ---

# # R Demo
#
# This file is an example of using R, based on some of the [RStudio Cheat Sheets](https://rstudio.com/resources/cheatsheets/).
#
# Note is is necessary to specify `update = FALSE` when calling `p_load` below.

# +
# Set to your own local working directory
#setwd("~/Documents/mydir")

# Libraries
load.libs <- c(
    "readr",
    "tidyr",
    "dplyr",
    "purrr",
    "stringr",
    "ggplot2",
    "knitr"
)
options(install.packages.check.source = "no")
options(install.packages.compile.from.source = "never")
if (!require("pacman")) install.packages("pacman"); library(pacman)
p_load(load.libs, update = FALSE, character.only = TRUE)
status <- sapply(load.libs,require,character.only = TRUE)
if(all(status)){
  print("SUCCESS: You have successfully installed and loaded all required libraries.")
} else{
  cat("ERROR: One or more libraries failed to install correctly. Check the following list for FALSE cases and try again...\n\n")
  status
}
# -

f <- "file.csv"
write_file(x = "a,b,c\n1,2,3\n4,5,NA", path = f)
my_table <- read_csv(f)
print(my_table)
if (file.exists(f)) 
  file.remove(f)


