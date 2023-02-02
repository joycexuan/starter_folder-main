#2020 assaults stuff
runif(n = 140, min = 1, max = 900) |> floor() 

#2021 assaults stuff
sample(x = 1:900, size = 140, replace = TRUE) 

#length tests
runif(n = 140, min = 1, max = 900) |> floor() |> length()
sample(x = 1:900, size = 140, replace = TRUE) |> length()

#checking the min of each, should be whatever the lowest digit is. lowest is 1
runif(n = 140, min = 1, max = 900) |> floor() |> min()
sample(x = 1:900, size = 140, replace = TRUE) |> min()

#checking the max of each, should be whatever the highest digit is. highest is 900
runif(n = 140, min = 1, max = 900) |> floor() |> max()
sample(x = 1:900, size = 140, replace = TRUE) |> max()

