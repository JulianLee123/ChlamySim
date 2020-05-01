void setLight(){
  if(!start){//base light off toggle
    isDirected = switchOn;
  }
  else{//base light off predesignated on and off times
    if(currOn){
      if(millis() - lastReset > onTimeFinal){//time to switch light
        currOn = !currOn;
        lastReset = millis();
      }
      isDirected = true;
    }
    else{
      if(millis() - lastReset > offTimeFinal){
        currOn = !currOn;
        lastReset = millis();
      }
      isDirected = false;
    }
  }
}
