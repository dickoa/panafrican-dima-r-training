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
is.vector(vec_b)

### atomic vector (character)
vec_c <- c("weekend", "school", "apple")
#vec_c <- c("weekend", "school", 1, "apple")
vec_c
str(vec_c)

### matrix
matrix_a <- matrix(c(3, 0.3, 2,
                     5, 9, 2),
                   ncol = 2)
matrix_a

### list
list_a <- list(vec_a, matrix_a)
list_a

#############################################################################
##### Basic code writing

### Add notes with #

### Easier to organise codes in chunks
#############################################################################
# chunk 1

#############################################################################
# chunk 2

#############################################################################

### Assign objects with <-
a <- "x"
b <- c(3, 5)

### Access to element (Indexing system)
b[2]

### & and | like + and -
a <- 3
b <- 5
c <- 7

(a == 2 & b == 4) | c == 7
a == 2 & (b == 4 | c == 7)

