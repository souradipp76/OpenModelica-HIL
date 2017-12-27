package Arduino_HIL
  extends Modelica.Icons.Package;

  package Tests
  extends Modelica.Icons.ExamplesPackage;
  model hil_test
    extends Modelica.Icons.Example;
    Arduino_HIL.Blocks.Controller controller1 annotation(
      Placement(visible = true, transformation(origin = {-74, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Sources.Torque torque1 annotation(
      Placement(visible = true, transformation(origin = {-34, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia1(J = 1, a(fixed = true, start = 0), phi(fixed = true, start = 0), w(fixed = false, start = 0)) annotation(
      Placement(visible = true, transformation(origin = {-2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor1 annotation(
      Placement(visible = true, transformation(origin = {-16, 46}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque1(tau_constant = 10) annotation(
      Placement(visible = true, transformation(origin = {84, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia2(J = 2, a(start = 0), phi(start = 0), w(start = 1)) annotation(
      Placement(visible = true, transformation(origin = {60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Components.SpringDamper springDamper1(c = 1e4, d = 100, phi_rel(fixed = false), w_rel(fixed = true))  annotation(
      Placement(visible = true, transformation(origin = {28, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step1(height = 10)  annotation(
      Placement(visible = true, transformation(origin = {-82, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(step1.y, controller1.setpoint) annotation(
      Line(points = {{-70, -36}, {-66, -36}, {-66, -16}, {-96, -16}, {-96, -4}, {-86, -4}, {-86, -4}}, color = {0, 0, 127}));
    connect(inertia1.flange_b, speedSensor1.flange) annotation(
      Line(points = {{8, 0}, {14, 0}, {14, 46}, {-6, 46}}));
    connect(inertia1.flange_b, springDamper1.flange_a) annotation(
      Line(points = {{8, 0}, {18, 0}, {18, 0}, {18, 0}}));
    connect(springDamper1.flange_b, inertia2.flange_a) annotation(
      Line(points = {{38, 0}, {50, 0}, {50, 0}, {50, 0}}));
    connect(inertia2.flange_b, constantTorque1.flange) annotation(
      Line(points = {{70, 0}, {74, 0}}));
    connect(torque1.flange, inertia1.flange_a) annotation(
      Line(points = {{-24, 0}, {-12, 0}, {-12, 0}, {-12, 0}}));
    connect(speedSensor1.w, controller1.feedback) annotation(
      Line(points = {{-28, 46}, {-90, 46}, {-90, 5}, {-86, 5}}, color = {0, 0, 127}));
    connect(controller1.signal_out, torque1.tau) annotation(
      Line(points = {{-63, 0}, {-46, 0}}, color = {0, 0, 127}));
    annotation(
      Diagram(graphics = {Rectangle(origin = {21, 22}, extent = {{-77, 42}, {77, -42}}), Text(origin = {14, 70}, extent = {{-32, 4}, {32, -4}}, textString = "Plant")}));
  end hil_test;


  model hil_test2
    extends Modelica.Icons.Example;
    Servomechanisms.Electrical.SignalDCMotor signalDCMotor1(J = 10, b = 0.1)  annotation(
      Placement(visible = true, transformation(origin = {42, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Arduino_HIL.Blocks.Controller controller1 annotation(
      Placement(visible = true, transformation(origin = {-8, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step1(height = 10, offset = 0)  annotation(
      Placement(visible = true, transformation(origin = {-60, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(step1.y, controller1.setpoint) annotation(
      Line(points = {{-48, -4}, {-20, -4}, {-20, -4}, {-20, -4}}, color = {0, 0, 127}));
    connect(signalDCMotor1.speed, controller1.feedback) annotation(
      Line(points = {{48, -10}, {66, -10}, {66, 28}, {-38, 28}, {-38, 4}, {-20, 4}, {-20, 6}}, color = {0, 0, 127}));
    connect(controller1.signal_out, signalDCMotor1.u) annotation(
      Line(points = {{3, 0}, {32, 0}}, color = {0, 0, 127}));
  protected
  end hil_test2;


  model hil_test3
    extends Modelica.Icons.Example;
    import strm = Modelica.Utilities.Streams;
    Modelica.Mechanics.Rotational.Components.Inertia load(J = 10, phi(fixed = true, start = 0), w(fixed = true, start = 0)) annotation(
      Placement(transformation(extent = {{67, 0}, {87, 20}})));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor speed annotation(
      Placement(transformation(extent = {{-10, -10}, {6, 6}}, rotation = -90, origin = {94, -7})));
    Modelica.Mechanics.Rotational.Sources.Torque torque annotation(
      Placement(transformation(extent = {{40, 0}, {60, 20}})));
    Real motorInputValue;
    Real motorOutputValue;
    parameter Integer motorInputIndex = 1;
    parameter Integer motorOutputIndex = 1;
    Real motorOutputDummy;
    Real pidOutputDummy(start = 0);
    Real pidInputDummy(start = 0);
  equation
    connect(speed.flange, load.flange_b) annotation(
      Line(points = {{92, 3}, {92, 10}, {87, 10}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(torque.flange, load.flange_a) annotation(
      Line(points = {{60, 10}, {67, 10}}, color = {0, 0, 0}, smooth = Smooth.None));
    torque.tau = motorInputValue;
    motorOutputValue = speed.w;
    when sample(0, 0.05) then
      pidOutputDummy = HIL_ArduinoIPC.Functions.SerialToShm(0, 115200);
      motorInputValue = InterProcessCommunication.SharedMemory.SharedMemoryRead(motorInputIndex);
      motorOutputDummy = InterProcessCommunication.SharedMemory.SharedMemoryWrite(motorOutputIndex, motorOutputValue);
      pidInputDummy = HIL_ArduinoIPC.Functions.ShmToSerial(0, 115200);
      strm.print(String(speed.w));
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
  end hil_test3;

  model testIPC
    Real dummy1;
    Real dummy2;
  algorithm
    dummy1 := HIL_ArduinoIPC.Functions.SerialToShm(0, 115200);
    dummy2 := HIL_ArduinoIPC.Functions.ShmToSerial(0, 115200);
  end testIPC;
end Tests;

  package Functions
    extends Modelica.Icons.FunctionsPackage;
      function control
      extends Modelica.Icons.Function;
      input Real setpoint;
      input Real feedback;
      output Real signal_out;
    
      external "C" signal_out = control(setpoint, feedback) annotation(
        Include = "#include \"MDDAVRControl.h\"");
      annotation(
        Documentation(info = "<html>
    <h4>Syntax</h4>
    <blockquote><pre>
    Arduino_HIL.<b>control</b>(setpoint,feedback);
    </pre></blockquote>
    <h4>Description</h4>
    <p>
    </p>
    </html>"));
    end control;
  end Functions;

  package Blocks
    extends Modelica.Icons.Package;
      model Controller
      extends Modelica.Blocks.Interfaces.BlockIcon;
      import Arduino_HIL;
      Modelica.Blocks.Interfaces.RealInput feedback(final unit = "Volts") annotation(
        Placement(visible = true, transformation(origin = {-120, 48}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput setpoint(final unit = "Volts") annotation(
        Placement(visible = true, transformation(origin = {-120, -36}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -44}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput signal_out(start = 0, fixed = true) annotation(
        Placement(visible = true, transformation(origin = {110, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      signal_out = Arduino_HIL.Functions.control(setpoint, feedback);
      annotation(
        defaultComponentName = "controller",
        Icon(graphics = {Text(origin = {-123, 81}, extent = {{-17, 11}, {17, -11}}, textString = "Feedback", fontName = "Arial"), Text(origin = {-122, -14}, extent = {{-20, 18}, {20, -18}}, textString = "Setpoint", fontName = "Arial"), Text(origin = {117, 23}, extent = {{-17, 7}, {17, -7}}, textString = "Signal_Out", fontName = "Arial")}));
    end Controller;

  end Blocks;

  annotation(
    uses(Modelica(version = "3.2.2"), Modelica_DeviceDrivers(version = "1.5.0")));
end Arduino_HIL;