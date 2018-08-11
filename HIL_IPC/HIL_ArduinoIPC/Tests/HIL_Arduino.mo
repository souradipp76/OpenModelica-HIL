within HIL_ArduinoIPC.Tests;
model HIL_Arduino
  extends Modelica.Icons.Example;
  
  //extends Modelica.Mechanics.Rotational.Components;
  Modelica.Mechanics.Rotational.Components.Inertia load(J = 10, phi(fixed = true, start = 0), w(fixed = true, start = 0)) annotation(
    Placement(transformation(extent = {{67, 0}, {87, 20}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speed annotation(
    Placement(transformation(extent = {{-10, -10}, {6, 6}}, rotation = -90, origin = {94, -7})));
  Modelica.Mechanics.Rotational.Sources.Torque torque annotation(
    Placement(transformation(extent = {{40, 0}, {60, 20}})));
 
  // Declaration of variables and constants

  Real motorInputValue "Value of input from the  Discrete PID Controller" ;
  Real motorOutputValue  "Value of output to Discrete PID Controller" ;
  parameter Integer motorInputIndex = 1;//Address from where to read, can be any number between 0 to 10
  parameter Integer motorOutputIndex = 1;//Address where to write, can be any number between 0 to 10
  Real motorOutputDummy "Dummy value to be returned by the SharedMemoryWrite function";
  
  
  parameter Integer pidInputIndex = 1;//Address from where to read, can be any number between 0 to 10
  parameter Integer pidOutputIndex = 1;//Address where to write, can be any number between 0 to 10
  

equation
  connect(speed.flange, load.flange_b) annotation(
    Line(points = {{92, 3}, {92, 10}, {87, 10}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(torque.flange, load.flange_a) annotation(
    Line(points = {{60, 10}, {67, 10}}, color = {0, 0, 0}, smooth = Smooth.None));
 
  torque.tau = motorInputValue "The value of control signal (pidOutputValue) is acquired by the SharedMemoryRead function and it is assigned to the input of the DC motor";
  motorOutputValue = speed.w "The measured speed of the DC motor is assigned to pidInputValue, which is written into the shared memory using SharedMemoryWrite Function";

algorithm 
  when sample(0, 0.05) then
    motorInputValue := InterProcessCommunication.SharedMemory.SharedMemoryRead(motorInputIndex)         "SharedMemoryRead Function reads the value from the shared memory, pointed by pidOutputIndex tag and assigns it to the input of the DC motor";
    motorOutputDummy := InterProcessCommunication.SharedMemory.SharedMemoryWrite(motorOutputIndex, motorOutputValue) "SharedMemoryWrite Function writes the value of measured speed into the shared memory, pointed by pidInputIndex tag" ;
  end when;
  
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-140, -100}, {140, 100}}, initialScale = 0.1), graphics = {Text(lineColor = {255, 0, 0}, extent = {{40, 37}, {90, 31}}, textString = "plant"), Rectangle(lineColor = {255, 0, 0}, extent = {{32, 40}, {104, -40}})}),
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {2, 2})),
    Documentation(info = "<html>

<p>
<b></b><br /><br />
The <b>DCMotor</b> model contains the DC motor, which reads the control signal from shared memory (given by discrete PID controller) and the speed sensor measures the resulting rotation. The measured speed from speed sensor is written into the shared memory.
 
 </p>
 
 <p>
The values of control signal and speed of the DC motor are read from and written into the shared memory at sampling interval of 0.05 seconds.  <a href=\"modelica://InterProcessCommunication.SharedMemory.SharedMemoryRead\"> SharedMemoryRead </a> and <a href=\"modelica://InterProcessCommunication.SharedMemory.SharedMemoryWrite\"> SharedMemoryWrite </a> functions are used to read the control signal from the shared memory and write the measured speed into the shared memory respectively. The motorOutputIndex and motorInputIndex variables serve as index of the tag i.e. motorInputIndex points to the value of control signal and motorOutputIndex points to the value of speed of the DC motor. The value of the control signal, returned by the <a href=\"modelica://InterProcessCommunication.SharedMemory.SharedMemoryRead\"> SharedMemoryRead </a> function is stored in the motorInputValue variable. The value of the motorInputValue is in turn assigned to the torque.tau variable, which serves as an input to the DC motor. Similarly, the value of the measured speed is  assigned to motorOutputvalue variable. Therefore, the value of the motorOutputvalue is written into shared memory using <a href=\"modelica://InterProcessCommunication.SharedMemory.SharedMemoryWrite\"> SharedMemoryWrite </a> function. 
</p>

</html>"),
    experiment(StopTime = 30, StartTime = 0, Tolerance = 1e-06, Interval = 0.01),
    __OpenModelica_simulationFlags(jacobian = "coloredNumerical", s = "dassl", lv = "LOG_STATS", nls = "homotopy", clock = "RT"));

end HIL_Arduino;
