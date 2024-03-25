# itp

## Joe

## Midterm Phase 4 Documentation

### Preliminary Things
This phase was definitely the hardest, and used the most code, but after the pyramid assignment I feel like anything else using for loops is easier in comparison.
The hints given in the class repository guided my thinking throughout this phase. (You can multiply the cell width with the current x position in the nested for-loop to position your object in the x-axis. For the y-axis, this will be the cell height multiplied by the current y position.)

### Coding Process
I began by using my phase 3 code as a starting point, deleting the prior test drawings before advancing.
I then tried to execute a for loop for only the x-axis using i for the iteration amount within a range of 0 to g (g representing what grid size the user defined).
Initially I had defined a step value within the range, but I then realized I could simply multiply i by the cell size (cell size being represented by c in my code).
After this for loop worked I nested another for the y-axis, using j as the iteration amount within the same range (0, g).
The process was almost identical, only subbing out y for x and j for i.
After this my program tiled a 4x4 grid flawlessly.

### Issues/Questions
After I tiled a 4x4 I was unsure if I needed to request user input and make the tile amount adjustable, or if we were only required to tile a specifc amount once.
In order to make my program adjustable I added some simple operators before the first for loop. Firstly defining grid size, then doing computations to this number to derive cell size and object size.
For any size less than or equal to 4 my program runs fine, but when trying values higher than 5 the canvas prints blank.
I added a print function to see if the math section was wrong, and size value would refuse to print when it was a float. I'm unsure what the root cause of my problem is. My current theory is that Processing itself doesn't do well with floating points, but any advice on the subject would be appreciated.
As mentioned earlier the program can tile to any size if the values are manually inserted.
