within HIL_OpenModelica.Functions;
function ShmToSerial
  extends Modelica.Icons.Function;
  input Integer port;
  input Integer baudrate;
  output Real dummy;

  external "C" dummy = ShmToSerial(port, baudrate);
  annotation(
    Library = "Serial2SHM");
end ShmToSerial;

