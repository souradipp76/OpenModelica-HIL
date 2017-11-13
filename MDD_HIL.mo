package MDD_HIL
  extends Modelica.Icons.ExamplesPackage;

  model Controller
    extends Modelica.Blocks.Interfaces.BlockIcon;
    import sComm = Arduino.SerialCommunication.Functions;
    Modelica.Blocks.Interfaces.RealInput feedback(final unit="Volts") annotation(Placement(visible = true, transformation(origin = {-120, 48}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput setpoint(final unit="Volts") annotation(Placement(visible = true, transformation(origin = {-120, -36}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -44}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput signal_out(start=0, fixed=true) annotation(Placement(visible = true, transformation(origin = {110, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    signal_out=control(setpoint,feedback); 
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
















  

end MDD_HIL;
