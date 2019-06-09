within HIL_OpenModelica.Tests;
model testIPC
     Real dummy1;
     Real dummy2;
   algorithm
     dummy1 := Arduino_HIL.Functions.SerialToShm(0, 115200);
     dummy2 := Arduino_HIL.Functions.ShmToSerial(0, 115200);
   end testIPC;

