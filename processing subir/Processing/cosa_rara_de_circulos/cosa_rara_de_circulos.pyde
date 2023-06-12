#x = z = y = w = c = 0
t = 0
import copy

def setup():
             
             size(800,800)
             
             background(0)
             
             colorMode(HSB)
             
             frameRate(60)

def draw():
    
    #global x,y,z,c,w
    #background(0)
    global t
    if(mousePressed):
        background(0)
    #pos2.set(width/2+150*cos(t),height/2 + 150*sin(t))
    #pos3.set(width/2+150*cos(t)+75*cos(width/2+150*cos(t)),height/2 + 150*sin(t) + 75*sin(height/2 + 150*sin(t)))
        stroke(255)
        strokeWeight(3)
        noFill()
        line(width/2, height/2,width/2 + 150*cos(t),height/2 + 150*sin(t))
        ellipse(width/2,height/2,300,300)
        line(width/2 + 150*cos(t),height/2 + 150*sin(t),width/2+150*cos(t)+75*cos(t*PI),height/2 + 150*sin(t) + 75*sin(t*PI))
        ellipse(width/2 + 150*cos(t),height/2 + 150*sin(t),150,150)
        line(width/2+150*cos(t)+75*cos(t*PI),height/2 + 150*sin(t) + 75*sin(t*PI), width/2+150*cos(t)+75*cos(t*PI)+37.5*cos(t*TWO_PI), height/2 + 150*sin(t) + 75*sin(t*PI)+37.5*sin(t*TWO_PI))
        ellipse( width/2+150*cos(t)+75*cos(t*PI)+37.5*cos(t*TWO_PI), height/2 + 150*sin(t) + 75*sin(t*PI)+37.5*sin(t*TWO_PI),75,75)
        line(width/2+150*cos(t)+75*cos(t*PI)+37.5*cos(t*TWO_PI), height/2 + 150*sin(t) + 75*sin(t*PI)+37.5*sin(t*TWO_PI), width/2+150*cos(t)+75*cos(t*PI)+37.5*cos(t*TWO_PI)+18.75*cos(t*4*PI), height/2 + 150*sin(t) + 75*sin(t*PI)+37.5*sin(t*TWO_PI)+18.75*sin(t*4*PI))
        stroke(0,255,255)
        strokeWeight(7)
        point(width/2+150*cos(t)+75*cos(t*PI)+37.5*cos(t*TWO_PI)+18.75*cos(t*4*PI), height/2 + 150*sin(t) + 75*sin(t*PI)+37.5*sin(t*TWO_PI)+18.75*sin(t*4*PI))
    else:
        stroke(0,255,255)
        strokeWeight(7)
        point(width/2+150*cos(t)+75*cos(t*PI)+37.5*cos(t*TWO_PI)+18.75*cos(t*4*PI), height/2 + 150*sin(t) + 75*sin(t*PI)+37.5*sin(t*TWO_PI)+18.75*sin(t*4*PI))
    

    #point(width/2+150*cos(t)+75*cos(t*PI),height/2 + 150*sin(t) + 75*sin(t*PI))
    #line(width/2,height/2,width/2+75,height/2+75)
    #line(width/2,height/2,pos1.x+75,pos1.y+75)
    #print(width/2)
   # print(pos1.x)
    t += 0.005
def mouseReleased():
    background(0)
    #line(pos2.x,pos2.y,pos3.x,pos3.y)
    
    #c = map(height/2+75*sin(y*6/5), height/2-75, height/2+75, 0,150 )
    
    #stroke(c,255,255)
    
    #point(width/2+75*cos(x), height/2+75*sin(2*x))
    #point(width/2+75*cos(y), height/2+75*sin(y))
    #point(width/2+75*cos(y), height/2+75*sin(y*6/5))
    #x += 0.01
    #y = z = x
    
        
             
