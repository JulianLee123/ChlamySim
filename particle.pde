class particle implements Comparable< particle >{
  int speed, r;//speed and radius of particle hardcoded
  int minX, maxX, minY, maxY;//border
  PVector position;
  float dir;
  ArrayList<PVector> path;//store all previous positions for data collection; actually didn't need to use it 
  int id;//just to number all the particles
  
  particle(int id, int xMinBorder, int yMinBorder, int xMaxBorder, int yMaxBorder){
    this.id = id;
    r = RAD;
    speed = 3;
    minX = xMinBorder;
    maxX = xMaxBorder;
    minY = yMinBorder;
    maxY = yMaxBorder;
    position = new PVector(random(maxX-minX)+minX,random(maxY-minY)+minY);
    dir = random(2*PI);
    path = new ArrayList<PVector>();
    path.add(position);
  }
  void next(){
    //store/collect last position to
    XPOS.set(id, (double)position.x);
    YPOS.set(id, (double)position.y);
    //update position
    if(isDirected)
      directedMovement();
    else
      randomMovement();
    path.add(position);
  }
  void directedMovement(){//CHANGE
    position = new PVector(min(position.x+speed,maxX),position.y);
  }
  void randomMovement(){
    //wall bounce: if hit wall, change the direction accordingly 
    PVector newPos = new PVector(cos(dir)*speed+position.x,-sin(dir)*speed+position.y);
    if(newPos.y - r < minY){
      if(dir > 0 && dir < PI*0.5){//Q1
        dir = 2*PI - dir;
      }
      else if(dir > PI*0.5 && dir < PI){//Q2
        dir = 2*PI - dir;
      }
    }
    else if(newPos.x - r < minX){
      if(dir > PI*0.5 && dir < PI){//Q2
        dir = PI - dir;
      }
      else if(dir > PI && dir < PI*1.5){//Q3
        dir = PI*2-(dir-PI);
      }
    }
    else if(newPos.y + r > maxY){
      if(dir > PI && dir < PI*1.5){//Q3
        dir = PI*2 - dir;
      }
      else if(dir > PI*1.5 && dir < PI*2){//Q4
        dir = PI*2-dir;
      }
    }
    else if(newPos.x + r > maxX){
      if(dir > 0 && dir < PI*0.5){//Q1
        dir = PI - dir;
      }
      else if(dir > PI*1.5 && dir < PI*2){//Q4
       dir = 3*PI - dir;
      }
    }
    if(dir > 2*PI)
      dir -= 2*PI;
    if(dir < 0)
      dir += 2*PI;
    position.add(new PVector(cos(dir)*speed,-sin(dir)*speed));
  }
  PVector getPosition(){
    return position; 
  }
  void collide(particle otherPart){
    float init = dir, diff;//diff b/t initial direction and calculated direction
    PVector otherPos = otherPart.getPosition();
    if(position.x > otherPos.x){
      dir = atan((position.y-otherPos.y)/(position.x-otherPos.x)); 
      if(dir < 0){
        dir = 2*PI+dir;
      }
    }
    else{
      dir = atan((position.y-otherPos.y)/(position.x-otherPos.x)); 
      if(dir > 0){
        dir = PI + dir;
      }
      else{
        dir = PI + dir;
      }
    }
    //dir points in the direction of the line that goes through the centers of both circles
    if(abs(init - dir) < PI)
      diff = abs(init - dir);
    else
      diff = 2*PI - abs(init - dir);
    dir = diff + dir;
  }
  void draw(){
    color c = color(0,128,0);
    pg.fill(c);
    pg.noStroke();
    pg.ellipse(position.x,position.y,r,r);
  }
  public int compareTo(particle p) {
    if(this.position.x > p.position.x)
       return 1;
    return -1;
  }
}
