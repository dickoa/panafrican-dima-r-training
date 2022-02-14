####### PanAfrica R training
####### 15 Feb 2022
####### 1. Understanding basics

#############################################################################
##### Objects

### single number (atomic vector, numeric)
vec_a <- 56.3

### atomic vector (numeric) with length >= 1
vec_b <- c(1, 35, 2.6, 0, NA)
vec_b

### atomic vector (character)
vec_c <- c("weekend", "school", "apple")
#vec_c <- c("weekend", "school", 1, "apple")
vec_c
str(vec_c)

### types of vectors
vec_d <- c(1, "weekend", 10, "school", "apple")

### list
list_a <- list(vec_a, matrix_a)
list_a

#############################################################################
##### Basic code writing

### Add notes with #
# Hello World

### Easier to organise codes in chunks
#############################################################################
# chunk 1

#############################################################################
# chunk 2

#############################################################################

### Assign objects with <-
a <- "x"
## a <- x gives you an error message since there is no x
b <- c(3, 5)

### Access to element (Indexing system)
b[2]
