//data starts recording when start button pressed

import java.util.Collections;


particleSystem ps;
PGraphics pg;

final int numPart = 150; 
boolean isDirected = false, switchOn = false;
Bar onTimeBar, offTimeBar;
boolean onBarPressed, offBarPressed;
int onTime = 250, offTime = 250, minOnTime = 0, maxOnTime = 1000, minOffTime = 0, maxOffTime = 1000;//in millis
boolean start = false, currOn = false;//start button not pressed yet; these variables are for predesignated times
int onTimeFinal, offTimeFinal;//set when start button pressed
int lastReset = 0;//last time light toggled 

//
//for drawing
//
int RAD = 10;//radius of algae
color backgroundColor = color(255,255,255);
int border = 50, xMin = border, yMin = 250 + border, xMax, yMax;
int toggleX = 100, toggleY = 110;//top left hand corner of toggle
int barWidth = 16, barEdge = 15;//for rounding edges
int bX = 390,bY = 220,bW = 120,bH = 50;
color blueGray = color(124,169,215), navy = color(46,59,101);

//
//for recording data
//
PrintWriter output;
ArrayList<Double> XPOS, YPOS;//stores particle positions to be printed

void setup() {
  size(800, 800);
  xMax = width - border;
  yMax = height - border;
  pg = createGraphics(width, height);
  background(backgroundColor);
  ps = new particleSystem(numPart, xMin, yMin, xMax, yMax);
  onTimeBar = new Bar(100,260,width - 140,(onTime-minOnTime)/(float)maxOnTime);
  offTimeBar = new Bar(180,260,width - 140,(offTime-minOffTime)/(float)maxOffTime);
  XPOS = new ArrayList<Double>();
  YPOS = new ArrayList<Double>();
  for(int i = 0; i < numPart; i++){
    double temp = 0;
    XPOS.add(0,temp);
    YPOS.add(0,temp);
  }
}

void draw() {
  setLight();
  pg.beginDraw(); 
  pg.clear();
  pg.background(backgroundColor);
  ps.next();
  ps.draw();
  drawToggles();
  writeText();
  pg.endDraw();
  image(pg, 0, 0);
  noFill();
  strokeWeight(3);
  rect(xMin, yMin, xMax - xMin, yMax - yMin);
}

void mouseReleased() {
  onBarPressed = false;
  offBarPressed = false;
}
void mousePressed() {
  if(mouseX > bX && mouseX < bX + bW && mouseY > bY && mouseY < bY + bH){//if button clicked
    if(!start){//now starting
       output = createWriter("positions.csv"); 
    }
    else{
      output.flush(); // Writes the remaining data to the file
      output.close(); // Finishes the file
    }
    start = !start;
    lastReset = millis();
    onTimeFinal = onTime;
    offTimeFinal = offTime;
  }
  if(mouseX > toggleX && mouseX < toggleX + 40 && mouseY > toggleY && mouseY < toggleY + 80){//if switch clicked
    switchOn = !switchOn;
  }
  if(onTimeBar.clicked(mouseX,mouseY))
    onBarPressed = true;
  if(offTimeBar.clicked(mouseX,mouseY))
    offBarPressed = true;
}
