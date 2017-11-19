model MDD_HIL_test
  extends Modelica.Icons.Example;
  inner Modelica_DeviceDrivers.EmbeddedTargets.AVR.Blocks.Microcontroller mcu(desiredPeriod = 0.002, platform = Modelica_DeviceDrivers.EmbeddedTargets.AVR.Types.Platform.ATmega328P)  annotation(
    Placement(visible = true, transformation(origin = {-60, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.EmbeddedTargets.AVR.Blocks.ADC adc(analogPort = Modelica_DeviceDrivers.EmbeddedTargets.AVR.Types.AnalogPort.A1, prescaler = Modelica_DeviceDrivers.EmbeddedTargets.AVR.Types.AnalogPrescaler.'1/128', voltageReference = 5, voltageReferenceSelect = Modelica_DeviceDrivers.EmbeddedTargets.AVR.Types.VRefSelect.Internal)  annotation(
    Placement(visible = true, transformation(origin = {-78, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.EmbeddedTargets.AVR.Blocks.SynchronizeRealtime synchronizeRealtime1(timer = Modelica_DeviceDrivers.EmbeddedTargets.AVR.Types.TimerSelect.Timer0)  annotation(
    Placement(visible = true, transformation(origin = {-30, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.EmbeddedTargets.AVR.Blocks.PWM pwm(fastPWM = true, initialValues = {0}, prescaler = Modelica_DeviceDrivers.EmbeddedTargets.AVR.Types.TimerPrescaler.'1/1024', timer = Modelica_DeviceDrivers.EmbeddedTargets.AVR.Types.TimerSelect.Timer2, timerNumbers = {Modelica_DeviceDrivers.EmbeddedTargets.AVR.Types.TimerNumber.A})  annotation(
    Placement(visible = true, transformation(origin = {88, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.EmbeddedTargets.AVR.Blocks.PWM pwm1(fastPWM = true, initialValues = {0}, prescaler = Modelica_DeviceDrivers.EmbeddedTargets.AVR.Types.TimerPrescaler.'1/1024', timer = Modelica_DeviceDrivers.EmbeddedTargets.AVR.Types.TimerSelect.Timer2, timerNumbers = {Modelica_DeviceDrivers.EmbeddedTargets.AVR.Types.TimerNumber.B})  annotation(
    Placement(visible = true, transformation(origin = {86, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Greater greater1 annotation(
    Placement(visible = true, transformation(origin = {12, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression1 annotation(
    Placement(visible = true, transformation(origin = {6, -14}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch1 annotation(
    Placement(visible = true, transformation(origin = {48, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch11 annotation(
    Placement(visible = true, transformation(origin = {48, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression2 annotation(
    Placement(visible = true, transformation(origin = {52, -8}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Arduino.SerialCommunication.Blocks.RealToInt realToInt1 annotation(
    Placement(visible = true, transformation(origin = {66, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Arduino.SerialCommunication.Blocks.RealToInt realToInt2 annotation(
    Placement(visible = true, transformation(origin = {66, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.LimPID PID(Ni = 0.1, controllerType = Modelica.Blocks.Types.SimpleController.P, initType = Modelica.Blocks.Types.InitPID.SteadyState, k = 1, limitsAtInit = false)  annotation(
    Placement(visible = true, transformation(origin = {-36, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Servomechanisms.Electrical.SignalDCMotor signalDCMotor1 annotation(
    Placement(visible = true, transformation(origin = {-56, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1(k1 = 1, k2 = -1)  annotation(
    Placement(visible = true, transformation(origin = {84, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(signalDCMotor1.speed, PID.u_m) annotation(
    Line(points = {{-51, -72}, {-36, -72}, {-36, 20}}, color = {0, 0, 127}));
  connect(add1.y, signalDCMotor1.u) annotation(
    Line(points = {{96, -10}, {98, -10}, {98, -92}, {-76, -92}, {-76, -62}, {-66, -62}}, color = {0, 0, 127}));
  connect(switch11.y, add1.u2) annotation(
    Line(points = {{60, -34}, {66, -34}, {66, -16}, {72, -16}, {72, -16}}, color = {0, 0, 127}));
  connect(switch1.y, add1.u1) annotation(
    Line(points = {{60, 24}, {64, 24}, {64, -4}, {72, -4}, {72, -4}}, color = {0, 0, 127}));
  connect(adc.y, PID.u_s) annotation(
    Line(points = {{-67, 46}, {-54.5, 46}, {-54.5, 32}, {-48, 32}}, color = {0, 0, 127}));
  connect(switch11.y, realToInt1.u) annotation(
    Line(points = {{59, -34}, {64, -34}, {64, -54}, {44, -54}, {44, -80}, {54, -80}}, color = {0, 0, 127}));
  connect(realToInt1.y, pwm1.u[1]) annotation(
    Line(points = {{77, -80}, {82, -80}, {82, -66}, {68, -66}, {68, -50}, {74, -50}}, color = {255, 127, 0}));
  connect(realExpression1.y, greater1.u2) annotation(
    Line(points = {{17, -14}, {-8, -14}, {-8, 10}, {0, 10}}, color = {0, 0, 127}));
  connect(greater1.y, switch11.u2) annotation(
    Line(points = {{23, 18}, {26, 18}, {26, -34}, {36, -34}}, color = {255, 0, 255}));
  connect(switch11.u1, realExpression2.y) annotation(
    Line(points = {{36, -26}, {30, -26}, {30, -8}, {41, -8}}, color = {0, 0, 127}));
  connect(PID.y, switch11.u3) annotation(
    Line(points = {{-25, 32}, {-14, 32}, {-14, -42}, {36, -42}}, color = {0, 0, 127}));
  connect(realExpression2.y, switch1.u3) annotation(
    Line(points = {{41, -8}, {30, -8}, {30, 16}, {36, 16}}, color = {0, 0, 127}));
  connect(greater1.y, switch1.u2) annotation(
    Line(points = {{23, 18}, {30.5, 18}, {30.5, 24}, {36, 24}}, color = {255, 0, 255}));
  connect(PID.y, greater1.u1) annotation(
    Line(points = {{-25, 32}, {-9.5, 32}, {-9.5, 18}, {0, 18}}, color = {0, 0, 127}));
  connect(realToInt2.y, pwm.u[1]) annotation(
    Line(points = {{77, 54}, {88, 54}, {88, 40}, {68, 40}, {68, 20}, {76, 20}}, color = {255, 127, 0}));
  connect(switch1.y, realToInt2.u) annotation(
    Line(points = {{59, 24}, {64, 24}, {64, 40}, {42, 40}, {42, 54}, {54, 54}}, color = {0, 0, 127}));
  connect(PID.y, switch1.u1) annotation(
    Line(points = {{-25, 32}, {36, 32}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica_DeviceDrivers(version = "1.5.0"), Modelica(version = "3.2.2")));
end MDD_HIL_test;