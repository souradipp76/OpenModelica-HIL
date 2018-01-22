within InterProcessCommunication.Examples.InterProcessExamples;

model DiscretePID
  extends Modelica.Icons.Example;
  parameter Real sampleTime = 0.05;
  parameter Integer pidInputIndex = 1;//Address from where to read, can be any number between 0 to 10, it must match the address given to output value in second model i.e. DCMotor_SM_Example in this case
  parameter Integer pidOutputIndex = 1;//Address where to write, can be any number between 0 to 10
  Real MotorSpeed;//motor speed sensed by speed sensor and received as feedback
  Real pidOutputDummy;//dummy return value from shared memory
  Real pidInputValue;//value read from shared memory
  Real pidOutputValue;//value written to shared memory
  Modelica.Blocks.Continuous.PID PID(Td = 0.05, Ti = 5, k = 9)  annotation(
    Placement(visible = true, transformation(origin = {48, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback1 annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Filter filter1(f_cut = 0.8, order = 3)  annotation(
    Placement(visible = true, transformation(origin = {24, -32}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step1(height = 20, startTime = 5)  annotation(
    Placement(visible = true, transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
algorithm
  when sample(0, sampleTime) then
    pidInputValue := InterProcessCommunication.SharedMemory.SharedMemoryRead(pidInputIndex) "SharedMemoryRead Function reads the value from the shared memory, pointed by pidOutputIndex tag and assigns it to the input of the DC motor";
    filter1.u := pidInputValue;
    feedback1.u2 := filter1.y;
    MotorSpeed := feedback1.u2;
    pidOutputValue := PID.y;
    pidOutputDummy := InterProcessCommunication.SharedMemory.SharedMemoryWrite(pidOutputIndex, pidOutputValue) "SharedMemoryWrite Function writes the value of measured speed into the shared memory, pointed by pidInputIndex tag";
  end when;
equation
  connect(feedback1.y, PID.u) annotation(
    Line(points = {{10, 0}, {36, 0}}, color = {0, 0, 127}));
  connect(step1.y, feedback1.u1) annotation(
    Line(points = {{-38, 0}, {-10, 0}, {-10, 0}, {-8, 0}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 30, Tolerance = 1e-06, Interval = 0.01),
    __OpenModelica_simulationFlags(jacobian = "coloredNumerical", s = "dassl", lv = "LOG_STATS", nls = "homotopy", clock = "RT"), Documentation(info="<html>

<p>
<b>Inter Process Communication Library V1.0</b><br /><br />
The <b>DiscretePID</b> model contains the discretized PID controller with the step signal with 20 amplitude and 5s start time as a reference signal. The measured speed of the DC motor is read from the shared memory and given to the feedback of the discrete PID controller. Based on the difference between setpoint and measured speed, the discrete PID controller provides a control signal, which is written into the shared memory.
</p>

<p>
The values of control signal and speed of the DC motor are written into and read from the shared memory at sampling interval of 0.05 seconds respectively. <a href=\"modelica://InterProcessCommunication.SharedMemory_Functions.SharedMemoryRead\"> SharedMemoryRead </a> and <a href=\"modelica://InterProcessCommunication.SharedMemory.SharedMemoryWrite\"> SharedMemoryWrite </a> functions are used to read the speed of the DC motor from the shared memory and write the control signal into the shared memory respectively. The pidOutputIndex and pidInputIndex variables serve as index of the tag i.e. pidOutputIndex points to the value of control signal and pidInputIndex points to the value of speed of the DC motor. The value of the speed of the DC motor, returned by the <a href=\"modelica://InterProcessCommunication.SharedMemory.SharedMemoryRead\"> SharedMemoryRead </a> function is stored in the pidIutputValue variable. The value of the pidIutputValue is in turn assigned to the filter1.u variable, which serves as an input to the feedback of the discrete PID controller. Similarly, the value of control signal is  assigned to pidOutputvalue variable. Therefore, the value of the pidOutputvalue is written into shared memory using <a href=\"modelica://InterProcessCommunication.SharedMemory.SharedMemoryWrite\"> SharedMemoryWrite </a> function.
</p>

<p>
<b>License:</b> OSMC-PL v1.2 2017<br /><br />
<b>Credits:</b> ModeliCon Infotech Team <br />Ankur Gajjar <br />Shubham Patne <br />Jal Panchal <br />Ritesh Sharma <br />Pavan P <br /> 
</p>

</html>"),
  Diagram(graphics = {Rectangle(origin = {0, -10}, extent = {{-68, 50}, {68, -50}}), Text(origin = {0, 36}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, extent = {{-26, -6}, {26, 6}}, textString = "Controller Package")}));

end DiscretePID;