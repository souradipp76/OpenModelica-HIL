within HIL_OpenModelica.Functions;
function SerialToShm
  extends Modelica.Icons.Function;
  input Integer port;
  input Integer baudrate;
  output Real dummy;

  external "C" dummy = SerialToShm(port, baudrate);
  annotation(
    Library = "Serial2SHM");
end SerialToShm;

