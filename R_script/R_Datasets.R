# Vector Data Sets

## Create a vector 

## Numerical Vector

## Create a vector 

n_vec <- c(3,5,8,10,12,4) # normal method 

n_vec1 <- c(1:100) # regular run numbers

n_vec2 <- c(seq(from = 1, to = 100, by = 1)) # regular numbers with seq function.

n_vec3 <- c(seq(from = 1, to = 100, by = 3)) # irregular numbers with certain gap

# now using sample function
set.seed(12)
sam_vec <- sample(x = c(1:100), size = 20,replace = TRUE)
print(sam_vec)
sam_vec

## Repeat vector

rep_vec <- rep(c(1,2,3), each = 4)
rep_vec

rep_vec1 <- rep(c(1,2,3), times = 4)
rep_vec1

rep_vec2 <- rep(c(1,2,3), times = c(2,3,4))
rep_vec2

rep_vec3 <- rep(c(1,2,3), times = 2:4)
rep_vec3

## Character Vector

ch_vec <- c("a", "e","i","o","u")
set.seed(123)
sam_ch_vec <- sample(x = ch_vec, size = 20, replace = T)
sam_ch_vec

rep(ch_vec,times = 3)

## Access or locate items in vector

ch_vec[2]

ch_vec[c(2,4)]

## modify

ch_vec[2] <- "m"

ch_vec[c(2,4)] <- c("e","n")


# Delete 

ch_vec <- ch_vec[-2]

ch_vec[-c(2,4)]
class(ch_vec)
## Matrix / Metrics

## Matrix is a two dimensional data sets / array

mat1 <- matrix(data = rep_vec, nrow = 4, ncol = 3, byrow = TRUE)
class(mat1)

m1 <- matrix(data = c(1:12), ncol = 4, nrow = 3, byrow = TRUE)
m1

## Access any item in a matrix
m1

m1[2,]

## adding data in Matrix

## Add rows 

m1
m2 <- rbind(m1,c(13:16))
m2
m1
rbind(m1,m2)

## Adding columns 

m1
m3 <- matrix(data = c(1:12), nrow = 3, byrow = FALSE)
m1
m3

cbind(m1,m3)

m1
m3


### check dimension of the data

dim(m1)
nrow(m1)
ncol(m1)

### Check length of the data
length(m1)

# check members of matrix

m1

15 %in% m1
12 %in% m1

## 

mat2 <- matrix(1:4,nrow = 2, byrow = FALSE)
det(mat2)

solve(mat2) # calculates inverse matrix

adj_mat2 <- matrix(c(mat2[2,2],-mat2[1,2],-mat2[2,1],mat2[1,1]),ncol = 2,byrow = TRUE)

inv_mat2 <- (1/det(mat2)) * adj_mat2

## modify matrix

m1
m1[c(2,3),2] <- c(5,7)

m1[c(2,3),2] <- NA

# create a three dimensional array

array_3D <- array(data = c(1:24),dim =c(3,4,2))

## access in 3D array 

array_3D[c(1,3),c(2,4),2]


## List data

fruits <- list("apple","banana","cherry",23)

mixed_datasets <- list(adj_mat2,fruits,ch_vec, n_vec)

# Access items 

mixed_datasets[1]

mixed_datasets[[1]][2,2]

### 

# Create vectors of unequal lengths
s.n <- c(1, 2, 3, 4)
fruits <- c("apple", "banana", "cherry")
tasty <- c(TRUE, FALSE)

# Create a list and assign names to the vectors inside the list
ls1 <- list(s.n,fruits,tasty)

my_list <- list(SN = s.n, fruits = fruits, tasty = tasty)

my_list$fruits[2]

my_list[[2]][2] <- "jackfruits"

my_list$fruits[1:2]

my_list$fruits[c(1,3)]

## Data frame

## create a data-frame in R 

## function = data.frame()
set.seed(50)
df <- data.frame(s.n = 1:26,
                 code = LETTERS[1:26],
                 sex = sample(x = c("Male","Female"), size = 26, replace = TRUE),
                 salary = runif(n = 26, min = 30000, max = 50000),
                 points = rnorm(n = 26, mean = 60, sd = 20))
df


# Access the data from Dataframe
# from location
df[5,4]
df[c(4,5),c(2,3)]
df[4:5,2:3]

## column access

## By name
df[["code"]]

df$code

## Row access

df[12,]

df[c(12,13,14,20,26),]

df[1:10,]

df[seq(from = 1, to = 26, by = 2),c(1,3,5)]

nr <-c(1:nrow(df))

df[which(nr %% 2 != 0),]

## Access data by logical statement

df[which(df$points > 60 & df$salary > 40000 & df$sex == "Female"),c(2,4)]

df[which(df$sex  == "Male"),]

# Sorting
df[order(df$points,decreasing = FALSE),]

## Modify

df[which(df$sex == "Male"),3] <- "M"
df[which(df$sex == "Female"),3] <- "F"
df

df[which(df$salary > 40000),4] <- 40000

df[which.max(df$points),]
df[which.min(df$points),]

## Delete data

df[-which(df$salary > 35000),-c(2,4)]













