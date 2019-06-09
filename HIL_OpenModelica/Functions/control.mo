within HIL_OpenModelica.Functions;
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
