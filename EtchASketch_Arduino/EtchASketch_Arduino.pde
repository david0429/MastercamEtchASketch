#include <Stepper.h>

Stepper LeftStepper(48, 8, 9);
Stepper RightStepper(48, 10, 11);

int XLErrorComp = 5;
int XRErrorComp = 5;
int YUErrorComp = 7;
int YDErrorComp = 7;

int started = 0;
int XPoint = 0;
int YPoint = 0;
int PrevXPoint = 0;
int PrevYPoint = 0;
int XSteps = 0;
int YSteps = 0;
int PrevXSteps = 0;
int PrevYSteps = 0;
int temp = 0;

void setup(){
  Serial.begin(115200);
  LeftStepper.setSpeed(60);
  RightStepper.setSpeed(60);
}

void loop(){
  
  while(1){
    if (started == 1){
      break;
    }
    
    
    if(Serial.read()=='a'){
      Serial.write("b");
      started = 1;
      Serial.write("N");
      break;
    }}
    
  if(Serial.available()>=8){
  XPoint = (Serial.read() - 48) * 1000;
  XPoint = XPoint + (Serial.read() - 48) * 100;
  XPoint = XPoint + (Serial.read() - 48) * 10;
  XPoint = XPoint + (Serial.read() - 48);
  
  YPoint = (Serial.read() - 48) * 1000;
  YPoint = YPoint + (Serial.read() - 48) * 100;
  YPoint = YPoint + (Serial.read() - 48) * 10;
  YPoint = YPoint + (Serial.read() - 48);
  
  XSteps = XPoint - PrevXPoint;
  YSteps = YPoint - PrevYPoint;
  
  if(XSteps < 0 && PrevXSteps > 0){
    LeftStepper.step(XLErrorComp * (-1));
  }
  
  if(XSteps > 0 && PrevXSteps < 0){
    LeftStepper.step(XRErrorComp);
  }
  
  if(YSteps < 0 && PrevYSteps > 0){
    RightStepper.step(YDErrorComp * (-1));
  }
  if(YSteps > 0 && PrevYSteps < 0){
    RightStepper.step(YUErrorComp);
  }
  
  LeftStepper.step(XSteps);
  RightStepper.step(YSteps);

  PrevXPoint = XPoint;
  PrevYPoint = YPoint;
  
  if(XSteps != 0){
  PrevXSteps = XSteps;
  }
  
  if(YSteps != 0){
  PrevYSteps = YSteps;
  }
  
  Serial.print("N");
  }
}
