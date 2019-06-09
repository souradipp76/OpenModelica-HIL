within HIL_ArduinoIPC.Tests;
model HIL_Arduino_servomech
  extends Modelica.Icons.Example;
  import strm = Modelica.Utilities.Streams;
  Servomechanisms.Electrical.SignalDCMotor signalDCMotor1(J = 10) annotation(
    Placement(visible = true, transformation(origin = {0, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Real motorInputValue;
  Real motorOutputValue;
  parameter Integer motorInputIndex = 1;
  parameter Integer motorOutputIndex = 1;
  Real motorOutputDummy;
equation
  signalDCMotor1.u = motorInputValue;
  motorOutputValue = signalDCMotor1.speed;
  when sample(0, 0.05) then
    motorInputValue = InterProcessCommunication.SharedMemory.SharedMemoryRead(motorInputIndex);
    motorOutputDummy = InterProcessCommunication.SharedMemory.SharedMemoryWrite(motorOutputIndex, motorOutputValue);
    //strm.print(String(motorOutputValue));
  end when;
   annotation(Documentation(info = "<html>

<p>
<b></b><br /><br />
This test contains the <b>DCMotor</b> model from the <a href=\"modelica://Servomechanisms\">Servomechanisms</a> Modelica Library, which reads the control signal from shared memory (given by discrete PID controller in Arduino) and the speed sensor measures the resulting rotation. The measured speed from speed sensor is written into the shared memory.
 
 </p>
 
 <p>
The values of control signal and speed of the DC motor are read from and written into the shared memory at sampling interval of 0.05 seconds.  <a href=\"modelica://InterProcessCommunication.SharedMemory.SharedMemoryRead\"> SharedMemoryRead </a> and <a href=\"modelica://InterProcessCommunication.SharedMemory.SharedMemoryWrite\"> SharedMemoryWrite </a> functions are used to read the control signal from the shared memory and write the measured speed into the shared memory respectively. The motorOutputIndex and motorInputIndex variables serve as index of the tag i.e. motorInputIndex points to the value of control signal and motorOutputIndex points to the value of speed of the DC motor. The value of the control signal, returned by the <a href=\"modelica://InterProcessCommunication.SharedMemory.SharedMemoryRead\"> SharedMemoryRead </a> function is stored in the motorInputValue variable. The value of the motorInputValue is in turn assigned to the input signal to the DC motor. Similarly, the value of the measured speed is  assigned to motorOutputvalue variable. Therefore, the value of the motorOutputvalue is written into shared memory using <a href=\"modelica://InterProcessCommunication.SharedMemory.SharedMemoryWrite\"> SharedMemoryWrite </a> function. 
</p>

</html>"),experiment(StopTime = 100, StartTime = 0, Tolerance = 1e-06, Interval = 0.01),
    __OpenModelica_simulationFlags(jacobian = "coloredNumerical", s = "dassl", lv = "LOG_STATS", nls = "homotopy", clock = "RT"));
end HIL_Arduino_servomech;
