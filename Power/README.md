# itp

## Joe

### Power
This assignment was much easier than I originally thought it was going to be. This is probably because everything seems easier in comparison to the pyramid assignment.
My first issue, and realization, with writing this program was realizing that, even though n is used twice in the template, it doesn't mean that the variable is global. I was wondering how to print asterisks equal to my result of get_power without printing 2, since n was used as the exponent in the latter function.
Once I experimented with declaring n as being equal to a few other integers to test if it applied to either function I came to the conclusion that each function's argument was independent, even if they shared a symbol.
Print_graph was easy to get working: print a number of "*" equal to the argument.
After that I moved to get_power, which at first didn't run how I needed it to, until I remembered return exists.
Then all I needed to do was apply the program to a range of numbers (-8, 8), so I had the for loop execute print_graph, using the return of the get_power function for numbers within the range, i, squared (n=2).
