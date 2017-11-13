package Arduino_HIL
  extends Modelica.Icons.ExamplesPackage;

  model Controller
    extends Modelica.Blocks.Interfaces.BlockIcon;
    import Arduino_HIL;
    Modelica.Blocks.Interfaces.RealInput feedback(final unit="Volts") annotation(Placement(visible = true, transformation(origin = {-120, 48}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput setpoint(final unit="Volts") annotation(Placement(visible = true, transformation(origin = {-120, -36}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -44}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput signal_out(start=0, fixed=true) annotation(Placement(visible = true, transformation(origin = {110, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    signal_out=Arduino_HIL.control(setpoint,feedback); 
  annotation(Icon(graphics = {
      Text(origin = {-123, 81}, extent = {{-17, 11}, {17, -11}}, textString = "Feedback", fontName = "Arial"), Text(origin = {-122, -14}, extent = {{-20, 18}, {20, -18}}, textString = "Setpoint", fontName = "Arial"),
      Text(origin = {117, 23}, extent = {{-17, 7}, {17, -7}}, textString = "Signal_Out", fontName = "Arial")
    }));  
  end Controller;



  function control
    extends Modelica.Icons.Function;
    input Real setpoint;
    input Real feedback;
    output Real signal_out; 
    external "C" signal_out = control(setpoint,feedback) annotation  (Library = "Controller");
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

  model hil_test
    extends Modelica.Icons.Example;
    Arduino_HIL.Controller controller1 annotation(
      Placement(visible = true, transformation(origin = {-74, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Sources.Torque torque1 annotation(
      Placement(visible = true, transformation(origin = {-34, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia1(J = 1)  annotation(
      Placement(visible = true, transformation(origin = {-2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor1 annotation(
      Placement(visible = true, transformation(origin = {-16, 46}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  analog_in analog_in1 annotation(
      Placement(visible = true, transformation(origin = {-80, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque1(tau_constant = 10)  annotation(
      Placement(visible = true, transformation(origin = {84, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia2(J = 2) annotation(
      Placement(visible = true, transformation(origin = {60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.SpringDamper springDamper1 annotation(
      Placement(visible = true, transformation(origin = {28, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
  connect(inertia1.flange_b, speedSensor1.flange) annotation(
      Line(points = {{8, 0}, {14, 0}, {14, 46}, {-6, 46}}));
    connect(analog_in1.y, controller1.setpoint) annotation(
      Line(points = {{-68, -42}, {-60, -42}, {-60, -24}, {-92, -24}, {-92, -4}, {-86, -4}}, color = {0, 0, 127}));
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
      Diagram(graphics = {Rectangle(origin = {21, 22}, extent = {{-77, 42}, {77, -42}}), Text(origin = {14, 70}, extent = {{-32, 4}, {32, -4}}, textString = "Plant")}));end hil_test;

  block analog_in
    extends Modelica.Blocks.Interfaces.SO;
    import sComm=Arduino.SerialCommunication.Functions;
    import strm = Modelica.Utilities.Streams;
    protected
      Integer OK(fixed=false);
    equation
      OK =sComm.open_serial(1, 0, 115200);
      y=sComm.cmd_analog_in(1, 2);
  end analog_in;





  annotation(
    uses(Modelica(version = "3.2.2")));

















  

end Arduino_HIL;