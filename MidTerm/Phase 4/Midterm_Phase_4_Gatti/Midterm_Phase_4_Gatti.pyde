def setup():
    size (400, 400)

def drawObject(x, y, s):
    push()
    translate(x, y)
    scale(s)
    circle(50, 50, 100)
    arc(50, 50, 75, 75, 0.3, 2.81)
    ellipse(35, 37, 10, 25)
    ellipse(65, 37, 10, 25)
    triangle(50, 50, 45, 65, 55, 65)
    pop()
    
def draw():
    g=4
    c=400/g
    s=c/100
    for i in range(0, g):
        x=i*c
        for j in range(0, g):
            y=j*c
            drawObject(x, y, s)
            print(g, c, s)
 

       
    

    
    


    
    
    
