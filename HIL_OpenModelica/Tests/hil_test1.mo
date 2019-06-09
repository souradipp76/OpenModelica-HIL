within HIL_OpenModelica.Tests;
model hil_test1
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
  HIL_OpenModelica.Blocks.Controller controller annotation(
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
end hil_test1;

