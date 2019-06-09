within HIL_OpenModelica.Tests;
model hil_test3
  extends Modelica.Icons.Example;
   //extends Modelica.Mechanics.Rotational.Components;
  Modelica.Mechanics.Rotational.Components.Inertia load(J = 10, phi(fixed = true, start = 0), w(fixed = true, start = 0)) annotation(
    Placement(transformation(extent = {{67, 0}, {87, 20}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speed annotation(
    Placement(transformation(extent = {{-10, -10}, {6, 6}}, rotation = -90, origin = {94, -7})));
  Modelica.Mechanics.Rotational.Sources.Torque torque annotation(
    Placement(transformation(extent = {{40, 0}, {60, 20}})));
 
  HIL_OpenModelica.Blocks.Controller controller  annotation(
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

