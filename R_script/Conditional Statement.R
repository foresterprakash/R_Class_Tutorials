## If statement

marks <- 80

if(marks > 40){
  print("Pass")
}

## If else statement

if(marks > 40){
  print("Congratulations you have passed your exam")
} else {
  print("Sorry ! Please try another time.")
}

set.seed(12)

passedsn <- sample(x = 200:400, size = 100, replace = FALSE)

my_sym <- 250

if(my_sym %in% passedsn) {
  print("Pass")
} else {
  print("Fail")
}

## Nested if statement

marks <- 85

if(marks > 80){
  print("Distinction")
} else if(marks > 60){
  print("First Division")
} else if(marks > 50){
  print("Second Division")
} else if(marks > 40){
  print("Pass")
} else{
  print("Fail")
}


## if-else function
ifelse(marks > 80,"Dinstinction",
       ifelse(marks > 60,"First Division",
              ifelse(marks > 50,"Second Division",
                     ifelse(marks > 40,"Pass","Fail"))))

## Function

sq <- function(x){
  print(x^2)
}

sq(3)

addition <- function(x,y) {
  print(x+y)
}

addition(10,4)
addition(10)

# Function with default arguments

vol <- function(length=5, breadth=10, height=15) {
  print(length * breadth* height)
}

vol <- function(length, breadth,radius, height, type = "cyl") {
  if(type == "cube"){
    volume <- print(length * breadth * height)
  } else if(type == "cyl"){
    volume <- print(pi * radius ^2 * height)
  } else if(type == "cone"){
    volume <- print(1 / 3 * pi *radius^2 * height)
  } else {
    print("Name of the object error")
  }
}

vol(length = 10, breadth = 5, height = 10, type = "cube")

vol(radius = 5, height = 10, type = "cyl")

vol(radius = 10, height = 5, type = "cone")












