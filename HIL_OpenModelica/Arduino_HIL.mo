package Arduino_HIL
  extends Modelica.Icons.Package;

  package Tests
    extends Modelica.Icons.ExamplesPackage;

    model hil_test
      extends Modelica.Icons.Example;
      Modelica.Mechanics.Rotational.Sources.Torque torque1 annotation(
        Placement(visible = true, transformation(origin = {-34, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia1(J = 10, a(fixed = true, start = 0), phi(fixed = true, start = 0), w(fixed = false, start = 0)) annotation(
        Placement(visible = true, transformation(origin = {-2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor1 annotation(
        Placement(visible = true, transformation(origin = {-16, 46}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque1(tau_constant = 10) annotation(
        Placement(visible = true, transformation(origin = {84, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia2(J = 2, a(start = 0), phi(start = 0), w(start = 1)) annotation(
        Placement(visible = true, transformation(origin = {60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Mechanics.Rotational.Components.SpringDamper springDamper1(c = 1e4, d = 100, phi_rel(fixed = false), w_rel(fixed = true)) annotation(
        Placement(visible = true, transformation(origin = {28, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Step step1(height = 10, offset = 0) annotation(
        Placement(visible = true, transformation(origin = {-82, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Arduino_HIL.Blocks.Controller controller annotation(
        Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
    equation
      connect(controller.u_s, step1.y) annotation(
        Line(points = {{-92, 0}, {-96, 0}, {-96, -18}, {-62, -18}, {-62, -36}, {-70, -36}, {-70, -36}}, color = {0, 0, 127}));
      connect(speedSensor1.w, controller.u_m) annotation(
        Line(points = {{-26, 46}, {-80, 46}, {-80, 12}, {-80, 12}}, color = {0, 0, 127}));
      connect(controller.y, torque1.tau) annotation(
        Line(points = {{-68, 0}, {-46, 0}, {-46, 0}, {-46, 0}}, color = {0, 0, 127}));
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
      annotation(
        Diagram(graphics = {Rectangle(origin = {21, 22}, extent = {{-77, 42}, {77, -42}}), Text(origin = {14, 70}, extent = {{-32, 4}, {32, -4}}, textString = "Plant")}));
    end hil_test;



    model hil_test2
      extends Modelica.Icons.Example;
      Servomechanisms.Electrical.SignalDCMotor signalDCMotor1(J = 10) annotation(
        Placement(visible = true, transformation(origin = {42, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Blocks.Controller controller annotation(
        Placement(visible = true, transformation(origin = {-6, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Step step1(height = 10, offset = 0) annotation(
        Placement(visible = true, transformation(origin = {-54, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(step1.y, controller.u_s) annotation(
        Line(points = {{-42, 0}, {-18, 0}, {-18, 0}, {-18, 0}}, color = {0, 0, 127}));
      connect(signalDCMotor1.speed, controller.u_m) annotation(
        Line(points = {{48, -10}, {44, -10}, {44, -28}, {-6, -28}, {-6, -12}, {-6, -12}}, color = {0, 0, 127}));
      connect(controller.y, signalDCMotor1.u) annotation(
        Line(points = {{6, 0}, {32, 0}, {32, 0}, {32, 0}}, color = {0, 0, 127}));
    protected
    end hil_test2;

    model hil_test4
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
        pidOutputDummy = Arduino_HIL.Functions.SerialToShm(0, 115200);
        motorInputValue = InterProcessCommunication.SharedMemory.SharedMemoryRead(motorInputIndex);
        motorOutputDummy = InterProcessCommunication.SharedMemory.SharedMemoryWrite(motorOutputIndex, motorOutputValue);
        pidInputDummy = Arduino_HIL.Functions.ShmToSerial(0, 115200);
      end when;
//strm.print(String(speed.w));
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
        experiment(StopTime = 50, StartTime = 0, Tolerance = 1e-06, Interval = 0.01),
        __OpenModelica_simulationFlags(jacobian = "coloredNumerical", s = "dassl", lv = "LOG_STATS", nls = "homotopy", clock = "RT"));
    end hil_test4;



    model hil_test5
      extends Modelica.Icons.Example;
      Servomechanisms.Electrical.SignalDCMotor signalDCMotor1(J = 10) annotation(
        Placement(visible = true, transformation(origin = {0, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica_DeviceDrivers.Blocks.Communication.SharedMemoryRead sharedMemoryRead1(autoBufferSize = true, memoryID = "1", sampleTime = 0.05, startTime = 0, userBufferSize = 10 * 32) annotation(
        Placement(visible = true, transformation(origin = {-56, 78}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.AddReal addReal1(n = 1, nu = 1) annotation(
        Placement(visible = true, transformation(origin = {60, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.AddInteger addInteger1(n = 1, nu = 1) annotation(
        Placement(visible = true, transformation(origin = {60, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.AddString addString1(bufferSize = 2, data = ",", nu = 1) annotation(
        Placement(visible = true, transformation(origin = {60, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.AddString addString2(bufferSize = 2, data = "\n", nu = 1) annotation(
        Placement(visible = true, transformation(origin = {60, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.GetInteger getInteger1(n = 1, nu = 1, y(each fixed = true, each start = 0)) annotation(
        Placement(visible = true, transformation(origin = {-56, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.GetReal getReal1(n = 1, nu = 1) annotation(
        Placement(visible = true, transformation(origin = {-56, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.GetString getString1(bufferSize = 2, nu = 1) annotation(
        Placement(visible = true, transformation(origin = {-56, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.GetString getString2(bufferSize = 2, nu = 0) annotation(
        Placement(visible = true, transformation(origin = {-56, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica_DeviceDrivers.Blocks.Communication.SharedMemoryWrite sharedMemoryWrite1(autoBufferSize = true, memoryID = "1", sampleTime = 0.05, startTime = 0, userBufferSize = 10 * 32) annotation(
        Placement(visible = true, transformation(origin = {60, -84}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.Packager packager1 annotation(
        Placement(visible = true, transformation(origin = {60, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(sharedMemoryWrite1.pkgIn, addString2.pkgOut[1]) annotation(
        Line(points = {{60, -73}, {60, -64}}));
      connect(getInteger1.pkgIn, sharedMemoryRead1.pkgOut) annotation(
        Line(points = {{-56, 42}, {-56, 67}}));
      connect(getInteger1.y[1], addInteger1.u[1]) annotation(
        Line(points = {{-44, 32}, {46, 32}, {46, 32}, {48, 32}}, color = {255, 127, 0}, thickness = 0.5));
      connect(signalDCMotor1.u, getReal1.y[1]) annotation(
        Line(points = {{-10, 6}, {-28, 6}, {-28, -24}, {-44, -24}, {-44, -24}}, color = {0, 0, 127}));
      connect(packager1.pkgOut, addInteger1.pkgIn) annotation(
        Line(points = {{60, 54}, {60, 54}, {60, 42}, {60, 42}}));
      connect(getReal1.pkgOut[1], getString2.pkgIn) annotation(
        Line(points = {{-56, -34}, {-56, -34}, {-56, -42}, {-56, -42}}, thickness = 0.5));
      connect(getString1.pkgOut[1], getReal1.pkgIn) annotation(
        Line(points = {{-56, -7}, {-56, -13}}, thickness = 0.5));
      connect(getInteger1.pkgOut[1], getString1.pkgIn) annotation(
        Line(points = {{-56, 22}, {-56, 15}}, thickness = 0.5));
      connect(addReal1.pkgOut[1], addString2.pkgIn) annotation(
        Line(points = {{60, -38}, {60, -38}, {60, -44}, {60, -44}}, thickness = 0.5));
      connect(addString1.pkgOut[1], addReal1.pkgIn) annotation(
        Line(points = {{60, -8}, {60, -8}, {60, -18}, {60, -18}}, thickness = 0.5));
      connect(addInteger1.pkgOut[1], addString1.pkgIn) annotation(
        Line(points = {{60, 22}, {60, 22}, {60, 12}, {60, 12}}, thickness = 0.5));
      connect(signalDCMotor1.speed, addReal1.u[1]) annotation(
        Line(points = {{6, -4}, {27, -4}, {27, -28}, {48, -28}}, color = {0, 0, 127}));
    end hil_test5;

  
    model hil_test3
      extends Modelica.Icons.Example;
       //extends Modelica.Mechanics.Rotational.Components;
      Modelica.Mechanics.Rotational.Components.Inertia load(J = 10, phi(fixed = true, start = 0), w(fixed = true, start = 0)) annotation(
        Placement(transformation(extent = {{67, 0}, {87, 20}})));
      Modelica.Mechanics.Rotational.Sensors.SpeedSensor speed annotation(
        Placement(transformation(extent = {{-10, -10}, {6, 6}}, rotation = -90, origin = {94, -7})));
      Modelica.Mechanics.Rotational.Sources.Torque torque annotation(
        Placement(transformation(extent = {{40, 0}, {60, 20}})));
     
      Arduino_HIL.Blocks.Controller controller  annotation(
        Placement(visible = true, transformation(origin = {-12, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step1(height = 10, offset = 0)  annotation(
        Placement(visible = true, transformation(origin = {-48, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(step1.y, controller.u_s) annotation(
        Line(points = {{-36, 10}, {-24, 10}, {-24, 10}, {-24, 10}, {-24, 10}}, color = {0, 0, 127}));
      connect(controller.y, torque.tau) annotation(
        Line(points = {{-1, 10}, {38, 10}}, color = {0, 0, 127}));
      connect(speed.w, controller.u_m) annotation(
        Line(points = {{92, -14}, {92, -52}, {-12, -52}, {-12, -2}}, color = {0, 0, 127}));
      connect(speed.flange, load.flange_b) annotation(
        Line(points = {{92, 3}, {92, 10}, {87, 10}}, color = {0, 0, 0}, smooth = Smooth.None));
      connect(torque.flange, load.flange_a) annotation(
        Line(points = {{60, 10}, {67, 10}}, color = {0, 0, 0}, smooth = Smooth.None));
     
      annotation(
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-140, -100}, {140, 100}}, initialScale = 0.1), graphics = {Text(lineColor = {255, 0, 0}, extent = {{40, 37}, {90, 31}}, textString = "plant"), Rectangle(lineColor = {255, 0, 0}, extent = {{32, 40}, {104, -40}})}),
        Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {2, 2})),
        Documentation(info = "<html>
    
    <p>
    <b></b><br /><br />
    The <b>DCMotor</b> model contains the DC motor, which reads the control signal(given by discrete PID controller) and the speed sensor measures the resulting rotation.
    </p>
    </html>"),
        experiment(StopTime = 30, StartTime = 0, Tolerance = 1e-06, Interval = 0.01),
        __OpenModelica_simulationFlags(jacobian = "coloredNumerical", s = "dassl", lv = "LOG_STATS", nls = "homotopy", clock = "RT"));
    
    end hil_test3;





 model testIPC
      Real dummy1;
      Real dummy2;
    algorithm
      dummy1 := Arduino_HIL.Functions.SerialToShm(0, 115200);
      dummy2 := Arduino_HIL.Functions.ShmToSerial(0, 115200);
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
        Include = "#include \"Control.h\"");
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








    function SerialToShm
      extends Modelica.Icons.Function;
      input Integer port;
      input Integer baudrate;
      output Real dummy;
    
      external "C" dummy = SerialToShm(port, baudrate);
      annotation(
        Include = "#include \"SerialSHM_Exchange.h\"");
    end SerialToShm;

    function ShmToSerial
      extends Modelica.Icons.Function;
      input Integer port;
      input Integer baudrate;
      output Real dummy;
    
      external "C" dummy = ShmToSerial(port, baudrate);
      annotation(
        Include = "#include \"SerialSHM_Exchange.h\"");
    end ShmToSerial;
  end Functions;

  package Blocks
    extends Modelica.Icons.Package;

block Controller
  extends Modelica.Blocks.Interfaces.SVcontrol;
  import Arduino_HIL;
algorithm
when sample(0,0.05) then
  y := Arduino_HIL.Functions.control(u_s, u_m);  
end when;
  annotation(
    defaultComponentName = "controller",
    Icon(graphics = {Text(origin = {-123, 81}, extent = {{-17, 11}, {17, -11}}, textString = "Feedback", fontName = "Arial"), Text(origin = {-122, -14}, extent = {{-20, 18}, {20, -18}}, textString = "Setpoint", fontName = "Arial"), Text(origin = {117, 23}, extent = {{-17, 7}, {17, -7}}, textString = "Signal_Out", fontName = "Arial")}));
end Controller;











    
    
    
    
    
    
    
    







  end Blocks;
  annotation(
    uses(Modelica(version = "3.2.2"), Modelica_DeviceDrivers(version = "1.5.0")));
end Arduino_HIL;
