within HIL_ArduinoIPC.Functions;

function SerialToShm
  extends Modelica.Icons.Function;
  input Integer Index;
  input Integer port;
  input Integer baudrate;
  output Real dummy;
  external "C" dummy = SerialToShm(Index,port,baudrate);
  annotation(
    Library="SerialSHM");
end SerialToShm;
