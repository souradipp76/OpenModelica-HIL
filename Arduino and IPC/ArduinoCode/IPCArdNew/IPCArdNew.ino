  double Kp = 9.0, Ki = 1.8, Kd = 0.45, Error = 0.0, lastError, Integral = 0.0, Derivative, controlValue, processValue, setPoint = 10.0; //variable for PID with default values
  void setup()
  {
    Serial.begin(115200); //serial begin
  }

void loop()
{
  String readAddr = ""; //address String
  String readVal = ""; //value String


  if (Serial.available()) { //when serial data comes from modelica
    readAddr = Serial.readStringUntil(','); //read Address
    char readComma = Serial.read(); 
    readVal = Serial.readStringUntil('\n'); //read value

    processValue = readVal.toDouble(); //change value datatype from string to double

    lastError = Error;
    Error = setPoint - processValue;
    Integral = Integral + Error;
    Derivative = Error - lastError;
    controlValue = (Kp * Error) + (Ki * Integral) + (Kd * Derivative); //simple PID algorithm

    Serial.print(readAddr + ',' + String(controlValue) + '\n'); //send result serially in the same format as received
    delay(1);

  }
}
