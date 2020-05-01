//draws toggle from directed to undirected motility
void drawToggles(){
  //draw the button
  pg.noStroke();
  if(!start){//has not started yet
    if(mouseX > bX && mouseX < bX + bW && mouseY > bY && mouseY < bY + bH)//if hovering over button
          pg.fill(color(58,81,156));
        else
          pg.fill(navy);
  }
  else{
    if(mouseX > bX && mouseX < bX + bW && mouseY > bY && mouseY < bY + bH)//if hovering over button
      pg.fill(color(250,129,129));
    else
      pg.fill(color(247,60,60));
  }
  pg.rect(bX,bY,bW,bH,barEdge,barEdge,barEdge,barEdge);
  //draw the bars
  if(onBarPressed){
     onTimeBar.update(mouseX);
     onTime = (int)(onTimeBar.knobLoc*(maxOnTime-minOnTime)+minOnTime);
  }
  if(offBarPressed){
     offTimeBar.update(mouseX);
     offTime = (int)(offTimeBar.knobLoc*(maxOffTime-minOffTime)+minOffTime);
  }
  onTimeBar.drawBar(blueGray);
  offTimeBar.drawBar(blueGray);
  //draw the switch
  pg.pushMatrix();
  pg.translate(toggleX,toggleY+20);
  pg.noStroke();
  if(switchOn)
    pg.fill(color(0,128,0));
  else
    pg.fill(125);
  pg.rect(0, 0, 40, 30);
  pg.ellipse(20, 0, 40, 40);
  pg.ellipse(20, 30, 40, 40);
  pg.fill(255);
  if(switchOn)
    pg.ellipse(20, 00, 35, 35);
  else
    pg.ellipse(20, 30, 35, 35);
  pg.popMatrix();
}

void writeText(){
  pg.fill(0);
  pg.textSize(22);
  pg.text("On Time: " + onTime + "ms", 270, 72);
  pg.text("Off Time: " + offTime + "ms", 270, 152);
  pg.textSize(25);
  if(start){
    pg.text("End",427,253);
  }
  else{
    pg.fill(255);
    pg.text("Start",420,253);
  }
}
