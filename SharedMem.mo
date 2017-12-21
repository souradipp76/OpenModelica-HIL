model SharedMem
  //extends Modelica.Blocks.Icons.Block;
  parameter Integer pidInputIndex = 1;
  parameter Integer pidOutputIndex = 1;
  Real pidOutputDummy;
  Real pidInputDummy;
  
  algorithm
  when sample(0, 0.05) then
    pidOutputDummy := HIL_ArduinoIPC.Functions.SerialToShm(pidOutputIndex,0,115200) ; 
    pidInputDummy := HIL_ArduinoIPC.Functions.ShmToSerial(pidInputIndex,0,115200) ;
  end when;
end SharedMem;