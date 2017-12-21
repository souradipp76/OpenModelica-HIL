
int refPin = A0;    // select the input pin for the function generator
int refValue = 0;  // variable to store the value coming from the function generator
double Kp=9;

void setup()
{
  Serial.begin(115200); //serial begin
}

void loop()
{
  String readStr = ""; //some variables
  String readVal = "";
  double inVal, outVal;
  
  if (Serial.available()){ //when serial data comes from modelica
  while(Serial.available()){
    char readChar = (char)Serial.read();
    readStr+=readChar; 
    if(readChar == '\n'||readChar == '\0') break;
  } 
    readVal=readStr;
    //Serial.println(readStr);
    inVal = readVal.toDouble(); //extract value

    //controller function
    double omega_actual=inVal;
    double refValue=5;
    //double refValue = analogRead(refPin);
    double omega_ref=refValue;

    
    double output=Kp*(omega_actual-omega_ref);
    String outputStr=String(output);
    
    //output
    Serial.println(outputStr);
  } 
}
