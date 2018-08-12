within InterProcessCommunication.Examples.InterProcessExamples;

model ArduinoIPC
  Real ModelicaInput;
  Real ModelicaOutput;
  Real OutputDummy;
  
  equation
    ModelicaOutput = time;
    when sample(0, 0.05) then
      ModelicaInput = InterProcessCommunication.SharedMemory.SharedMemoryRead(1);
      OutputDummy = InterProcessCommunication.SharedMemory.SharedMemoryWrite(1, ModelicaOutput);      
    end when;
end ArduinoIPC;