within InterProcessCommunication.info.Tutorial;

class Advanced
extends Modelica.Icons.Information;
annotation( Documentation(info="<html>
<p>
<b>Inter Process Communication Library V1.0</b><br /><br />
You can make and execute new models using <a href=\"modelica://InterProcessCommunication\">InterProcessCommunication</a> library in few steps. Essentials in this library that you must include in your model are the functions <a href=\"modelica://InterProcessCommunication.SharedMemory.SharedMemoryRead\">SharedMemoryRead</a> and <a href=\"modelica://InterProcessCommunication.SharedMemory.SharedMemoryWrite\">SharedMemoryWrite</a> in the package SharedMemory and the files in directory (InterProcessCommunication/Resources).  <br />
Also the Serial_SHM executable should be running in the background refer to <a href=\"modelica://InterProcessCommunication.info.Tutorial.GettingStarted\">GettingStarted</a> tutorial for modifying, compiling and running Serial_SHM executable.
</p>

<p>
<b>Steps:</b><br />
1). Build a combined model for your application.<br />
2). Compile and run it as described in <a href=\"modelica://InterProcessCommunication.info.Tutorial.GettingStarted\">GettingStarted</a> tutorial for CombinedExamples. <br />
3). Divide the model into two parts as per the requirements e.g. into controller and actuator etc. <br />
4). Use <a href=\"modelica://InterProcessCommunication.SharedMemory.SharedMemoryRead\">SharedMemoryRead</a> function for reading data from shared memory and <a href=\"modelica://InterProcessCommunication.SharedMemory.SharedMemoryWrite\">SharedMemoryWrite</a> function for writng data into the shared memory.<br />
5). Follow the steps as described for InterProcessExamples in <a href=\"modelica://InterProcessCommunication.info.Tutorial.GettingStarted\">GettingStarted</a> tutorial. <br />
</p>

<p>
<b>License:</b> OSMC-PL v1.2 2017<br /><br />
<b>Credits:</b> ModeliCon Infotech Team <br />Ankur Gajjar <br />Shubham Patne <br />Jal Panchal <br />Ritesh Sharma <br />Pavan P <br /> 
</p>

</html>"));
end Advanced;