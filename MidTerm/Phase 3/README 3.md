# itp

## Joe

### Midterm Phase 3 Documentation
This phase of the midterm was a little tricky, but didn't take me long to wrap my head around.
I began by increaing my canvas size, so I could test the scaling of my object later on.
After the setup was complete I moved to defining my drawObject function with 3 variables: x position, y position, and size. (x, y, s)
After the first line was done I inserted a push fucntion to preserve the following code, assuring it wouldn't get affected by the first function call. 
The next line was my translate function, enabling the user to move the face around using x, y coordinates in the first fuicntion call.
After translate came size. The size of the face is full scale at 1, with smaller sizes requiring the use of floats.
After the size function was inserted I pasted in my phase 2 code, and closed the drawObject function with a pop to pair with the earlier push.
Once the code was written I began testing it by calling the draw object function at two different coordinates and sizes. This test went flawlessly so I then moved to phase 4.
