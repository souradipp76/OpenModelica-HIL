within HIL_OpenModelica.Tests;
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

