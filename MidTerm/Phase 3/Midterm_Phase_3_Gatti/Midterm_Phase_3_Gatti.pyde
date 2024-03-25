def setup():
    size (400, 400)

def drawObject(x, y, s):
    push()
    translate(x, y)
    scale(s)
    circle(100, 100, 100)
    arc(100, 100, 75, 75, 0.3, 2.81)
    ellipse(85, 87, 10, 25)
    ellipse(115, 87, 10, 25)
    triangle(100, 100, 95, 115, 105, 115)
    pop()
    
def draw():
    drawObject(0, 0, 1)
    drawObject(10, 10, 2)
    
    


    
    
    
