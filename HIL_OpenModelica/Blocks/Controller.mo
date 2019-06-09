within HIL_OpenModelica.Blocks;
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

