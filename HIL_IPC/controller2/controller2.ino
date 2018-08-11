
const int SW_pin = 2; // digital pin connected to switch output
const int X_pin = 0; // analog pin connected to X output
const int Y_pin = 1; // analog pin connected to Y output
//const int Y_pin = 2; // analog pin connected to Y output

double Kp = 9.0, Ki = 1.8, Kd = 0.45, Error = 0.0, lastError, Integral = 0.0, Derivative, controlValue, processValue; //variable for PID with default values
double setPoint = 10.0;

void setup()
{
  pinMode(SW_pin, INPUT);
  digitalWrite(SW_pin, HIGH);
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
    setPoint=(analogRead(Y_pin)*10)/1024;
    Error = setPoint - processValue;
    Integral = Integral + Error;
    Derivative = Error - lastError;
    controlValue = (Kp * Error) + (Ki * Integral) + (Kd * Derivative); //simple PID algorithm

    Serial.print(readAddr + ',' + String(controlValue) + '\n'); //send result serially in the same format as received
    delay(1);

  }
}
