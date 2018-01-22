within InterProcessCommunication.Examples.CombinedExamples;

model SinPIDandMotor"PID and Motor combine model with Sine input"
extends Modelica.Icons.Example;
 Modelica.Blocks.Continuous.PID PID(Td = 0.05, Ti = 5, k = 9)  annotation(
    Placement(visible = true, transformation(origin = {-30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback1 annotation(
    Placement(visible = true, transformation(origin = {-62, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Filter filter1(f_cut = 0.8, order = 3)  annotation(
    Placement(visible = true, transformation(origin = {-28, -50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.Torque torque1 annotation(
    Placement(visible = true, transformation(origin = {30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia1(J = 100)  annotation(
    Placement(visible = true, transformation(origin = {70, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor1 annotation(
    Placement(visible = true, transformation(origin = {90, -28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Sine sine1(amplitude = 10, freqHz = 1, startTime = 5)  annotation(
    Placement(visible = true, transformation(origin = {-90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(sine1.y, feedback1.u1) annotation(
    Line(points = {{-78, 10}, {-70, 10}, {-70, 10}, {-70, 10}}, color = {0, 0, 127}));
  connect(filter1.y, feedback1.u2) annotation(
    Line(points = {{-40, -50}, {-62, -50}, {-62, 2}, {-62, 2}}, color = {0, 0, 127}));
  connect(speedSensor1.w, filter1.u) annotation(
    Line(points = {{90, -40}, {90, -40}, {90, -50}, {-16, -50}, {-16, -50}}, color = {0, 0, 127}));
  connect(inertia1.flange_b, speedSensor1.flange) annotation(
    Line(points = {{80, 10}, {90, 10}, {90, -18}, {90, -18}}));
  connect(torque1.flange, inertia1.flange_a) annotation(
    Line(points = {{40, 10}, {60, 10}, {60, 10}, {60, 10}}));
  connect(PID.y, torque1.tau) annotation(
    Line(points = {{-18, 10}, {16, 10}, {16, 10}, {18, 10}}, color = {0, 0, 127}));
  connect(feedback1.y, PID.u) annotation(
    Line(points = {{-52, 10}, {-44, 10}, {-44, 10}, {-42, 10}}, color = {0, 0, 127}));
  annotation (Documentation(info= "<html>
<p>
<b>Inter Process Communication Library V1.0</b><br /><br />
This is a combined model for PID and Motor model with sinusoidal input.
</p>
<p>
<b>License:</b> OSMC-PL v1.2 2017<br /><br />
<b>Credits:</b> ModeliCon Infotech Team <br />Ankur Gajjar <br />Shubham Patne <br />Jal Panchal <br />Ritesh Sharma <br />Pavan P <br /> 
</p>
</html>"));

end SinPIDandMotor;