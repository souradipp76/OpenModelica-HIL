package InterProcessCommunication
extends Modelica.Icons.Library;
annotation( Documentation(info = "<html>

<p>
<b>Inter Process Communication Library V1.0</b><br /><br />
A library to communicate between two OpenModelica Models executing on two separate systems in real time using shared memory and serial communication.<br />
For demo a <a href=\"modelica://InterProcessCommunication.Examples.CombinedExamples.PIDandMotor\">PIDandMotor</a> model is divided into two parts. One is <a href=\"modelica://InterProcessCommunication.Examples.InterProcessExamples.DiscretePID\">DiscretePID</a> model and other one is <a href=\"modelica://InterProcessCommunication.Examples.InterProcessExamples.DCMotor\"> DCMotor</a> model. Each model is run on two different systems simultaneously say Sys1 and Sys2. <br />
Therefore PID model running on Sys1 generates a signal for the motor to regulate its speed at an amplitude given by step signal and writes the values to Sys1's shared memory, those values are then read and transmitted accross the channel using serial communication and are written to the Sys2's shared memory, DCMotor model running on Sys2 reads those values from its shared memory and regulates motor speed. This speed is then measured using speedSensor model and measured value is written to the shared memory and sent back to the Sys1 via serial channel. PID model running on Sys1 takes it as feedback input changes the ouput. This cycle continues till the end of execution. <br /> 
Results are validated against combined model output.
</p>

<p>
Detailed explanation is given in <a href=\"modelica://InterProcessCommunication.info.Overview\"> Overview</a>.<br />
Steps for execution are given in <a href=\"modelica://InterProcessCommunication.info.Tutorial\"> Tutorial</a>.<br />
</p>

<p>
<b>License:</b> OSMC-PL v1.2 2017<br /><br />
<b>Credits:</b> ModeliCon Infotech Team <br />Ankur Gajjar <br />Shubham Patne <br />Jal Panchal <br />Ritesh Sharma <br />Pavan P <br /> 
</p>

</html>"),
    uses(Modelica(version = "3.2.2")));

end InterProcessCommunication;