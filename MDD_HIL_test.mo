model MDD_HIL_test
  extends Modelica.Icons.Example;
  inner Modelica_DeviceDrivers.EmbeddedTargets.AVR.Blocks.Microcontroller mcu(desiredPeriod = 0.002, platform = Modelica_DeviceDrivers.EmbeddedTargets.AVR.Types.Platform.ATmega328P)  annotation(
    Placement(visible = true, transformation(origin = {-60, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.EmbeddedTargets.AVR.Blocks.ADC adc(analogPort = Modelica_DeviceDrivers.EmbeddedTargets.AVR.Types.AnalogPort.A1, prescaler = Modelica_DeviceDrivers.EmbeddedTargets.AVR.Types.AnalogPrescaler.'1/128', voltageReference = 5, voltageReferenceSelect = Modelica_DeviceDrivers.EmbeddedTargets.AVR.Types.VRefSelect.Internal)  annotation(
    Placement(visible = true, transformation(origin = {-72, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.EmbeddedTargets.AVR.Blocks.SynchronizeRealtime synchronizeRealtime1(timer = Modelica_DeviceDrivers.EmbeddedTargets.AVR.Types.TimerSelect.Timer0)  annotation(
    Placement(visible = true, transformation(origin = {-30, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.EmbeddedTargets.AVR.Blocks.PWM pwm(fastPWM = true, initialValues = {0}, prescaler = Modelica_DeviceDrivers.EmbeddedTargets.AVR.Types.TimerPrescaler.'1/1024', timer = Modelica_DeviceDrivers.EmbeddedTargets.AVR.Types.TimerSelect.Timer2, timerNumbers = {Modelica_DeviceDrivers.EmbeddedTargets.AVR.Types.TimerNumber.A})  annotation(
    Placement(visible = true, transformation(origin = {84, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.EmbeddedTargets.AVR.Blocks.PWM pwm1(fastPWM = true, initialValues = {0}, prescaler = Modelica_DeviceDrivers.EmbeddedTargets.AVR.Types.TimerPrescaler.'1/1024', timer = Modelica_DeviceDrivers.EmbeddedTargets.AVR.Types.TimerSelect.Timer2, timerNumbers = {Modelica_DeviceDrivers.EmbeddedTargets.AVR.Types.TimerNumber.B})  annotation(
    Placement(visible = true, transformation(origin = {84, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Greater greater1 annotation(
    Placement(visible = true, transformation(origin = {10, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression1 annotation(
    Placement(visible = true, transformation(origin = {-24, -64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch1 annotation(
    Placement(visible = true, transformation(origin = {50, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch11 annotation(
    Placement(visible = true, transformation(origin = {50, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression2 annotation(
    Placement(visible = true, transformation(origin = {50, -40}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Arduino.SerialCommunication.Blocks.RealToInt realToInt1 annotation(
    Placement(visible = true, transformation(origin = {66, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Arduino.SerialCommunication.Blocks.RealToInt realToInt2 annotation(
    Placement(visible = true, transformation(origin = {68, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.LimPID PID(Ni = 0.1, controllerType = Modelica.Blocks.Types.SimpleController.P, initType = Modelica.Blocks.Types.InitPID.SteadyState, k = 1, limitsAtInit = false)  annotation(
    Placement(visible = true, transformation(origin = {-32, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(realToInt2.y, pwm.u[1]) annotation(
    Line(points = {{79, 20}, {88, 20}, {88, -2}, {68, -2}, {68, -22}, {72, -22}}, color = {255, 127, 0}));
  connect(realToInt1.y, pwm1.u[1]) annotation(
    Line(points = {{78, -90}, {84, -90}, {84, -78}, {68, -78}, {68, -50}, {72, -50}}, color = {255, 127, 0}));
  connect(PID.y, switch11.u3) annotation(
    Line(points = {{-20, -28}, {-14, -28}, {-14, -50}, {-44, -50}, {-44, -74}, {38, -74}, {38, -74}}, color = {0, 0, 127}));
  connect(PID.y, switch1.u1) annotation(
    Line(points = {{-20, -28}, {-10, -28}, {-10, -6}, {38, -6}, {38, -6}}, color = {0, 0, 127}));
  connect(PID.y, greater1.u1) annotation(
    Line(points = {{-20, -28}, {-4, -28}, {-4, -28}, {-2, -28}}, color = {0, 0, 127}));
  connect(adc.y, PID.u_s) annotation(
    Line(points = {{-61, -28}, {-44, -28}}, color = {0, 0, 127}));
  connect(switch1.y, realToInt2.u) annotation(
    Line(points = {{62, -14}, {64, -14}, {64, -2}, {48, -2}, {48, 20}, {56, 20}}, color = {0, 0, 127}));
  connect(switch11.y, realToInt1.u) annotation(
    Line(points = {{62, -66}, {64, -66}, {64, -78}, {44, -78}, {44, -90}, {54, -90}, {54, -90}}, color = {0, 0, 127}));
  connect(switch11.u1, realExpression2.y) annotation(
    Line(points = {{38, -58}, {30, -58}, {30, -40}, {40, -40}, {40, -40}}, color = {0, 0, 127}));
  connect(realExpression2.y, switch1.u3) annotation(
    Line(points = {{40, -40}, {30, -40}, {30, -22}, {38, -22}, {38, -22}}, color = {0, 0, 127}));
  connect(realExpression1.y, greater1.u2) annotation(
    Line(points = {{-13, -64}, {-8, -64}, {-8, -36}, {-2, -36}}, color = {0, 0, 127}));
  connect(greater1.y, switch1.u2) annotation(
    Line(points = {{22, -28}, {26, -28}, {26, -14}, {38, -14}}, color = {255, 0, 255}));
  connect(greater1.y, switch11.u2) annotation(
    Line(points = {{22, -28}, {26, -28}, {26, -66}, {38, -66}}, color = {255, 0, 255}));
  annotation(
    uses(Modelica_DeviceDrivers(version = "1.5.0"), Modelica(version = "3.2.2")));
end MDD_HIL_test;