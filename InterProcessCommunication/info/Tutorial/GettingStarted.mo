within InterProcessCommunication.info.Tutorial;

class GettingStarted
extends Modelica.Icons.Information;
annotation( Documentation(info="<html>

<p>
<b>Inter Process Communication Library V1.0</b><br /><br />
The <a href=\"modelica://InterProcessCommunication.Examples.InterProcessExamples\">InterProcessExamples</a> package contains two models. First is a discretized PID controller with filter and the second one is a DC Motor with speed sensor, both models being sampled at a every 0.05s. The <a href=\"modelica://InterProcessCommunication.Examples.InterProcessExamples.DiscretePID\">DiscretePID</a> model demonstrates how the components of DiscretePID package can be used to establish InterProcess Communication (IPC)using shared memory with <a href=\"modelica://InterProcessCommunication.Examples.InterProcessExamples.DCMotor\"> DCMotor</a> model and vice versa.
</p>

<img src=\"modelica://InterProcessCommunication/Images/DiscretePID.png\" style=\"width:300px;height:150px;\">

<img src=\"modelica://InterProcessCommunication/Images/DCMotor.png\" style=\"width:300px;height:150px;\">
<p>
For intersystem communication run <a href=\"modelica://InterProcessCommunication.Examples.InterProcessExamples.DiscretePID\">DiscretePID</a> model on PC-1 and <a href=\"modelica://InterProcessCommunication.Examples.InterProcessExamples.DCMotor\"> DCMotor</a> model on PC-2.<br /> 
Connect the two systems via two serial devices such as PL2303 as follows:
</p>

<table style=\"width:100%\">
  <tr>
    <th>PL2303 PC-1</th>
    <th>PL2303 PC-2</th> 
  </tr>
  <tr>
    <td>GND</td>
    <td>GND</td>
  </tr>
  <tr>
    <td>RXD</td>
    <td>TXD</td>
  </tr>
  <tr>
    <td>TXD</td>
    <td>RXD</td>
  </tr>
</table>

<p>
<b>For running the <a href=\"modelica://InterProcessCommunication.Examples.InterProcessExamples\">InterProcessExamples</a> models follow those steps:</b><br />
1). Open OpenModelica on both PC’s using command (sudo OMEdit).<br />
2). Select DiscretePID model on one PC and DCMotor model on the other.<br />
3). Connect both PC’s to each other using serial device in a configuration mentioned above.<br />
4). Go to the directory (Linux/InterProcessCommunication/Resources/Include/) and open file Serial_SHM.c.<br /> 
5). Check for the port name given to the serial device by your system by using command (ls /dev/). It is generally ttyUSB0.<br /> 
6). Create executable for Serial_SHM.c using command (gcc -o Serial_SHM Serial_SHM.c -lrt) and execute it using command (./Serial_SHM).<br /> 
7). Fill in the device ID (e.g. /dev/ttyUSB0) and baud rate (e.g. 115200) when prompted to do so. It will establish the connection.<br />
7). Now search for librt.so and librt.a files in system files of your PC’s and copy them.<br /> 
8). Open directory containing the model and go to the directory (Linux/InterProcessCommunication/Resources/Library/linux64/). Paste librt.so and librt.a files there replacing the existing files. <i><u>This is an important step, do not skip this</u></i>.<br />
9). Go to simulation setup in OpenModelica and change Stop Time to a value equal to or greater than 30 on both PC’s. <br />
10). Click on Simulation Flags tab and write -rt=1 in column for Additional Simulation Flags and simulate on both PC’s simultaneously.
</p>

<p>
<b>For running the <a href=\"modelica://InterProcessCommunication.Examples.CombinedExamples\">CombinedExamples</a> models follow those steps:</b><br />
1). This model is for verifying the results obtained by InterProcessExamples models.<br />
2). Only one system is required. <br />
3). Compile and run it like any other model, no settings required except for the stop time.<br />
4). Superimpose results for validating results obtained by InterProcessExamples models.<br />
</p>

<p>
<b>License:</b> OSMC-PL v1.2 2017<br /><br />
<b>Credits:</b> ModeliCon Infotech Team <br />Ankur Gajjar <br />Shubham Patne <br />Jal Panchal <br />Ritesh Sharma <br />Pavan P <br /> 
</p>

</html>"));
end GettingStarted;