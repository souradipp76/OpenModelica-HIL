within HIL_ArduinoIPC.Functions;
function ShmToSerial
  extends Modelica.Icons.Function;
  input Integer Index;
  input Integer port;
  input Integer baudrate;
  output Real dummy;
  external "C" dummy = ShmToSerial(Index,port,baudrate);
  annotation(
     Library="SerialSHM");

end ShmToSerial;
