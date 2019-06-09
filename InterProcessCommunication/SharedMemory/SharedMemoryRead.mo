within InterProcessCommunication.SharedMemory;

function SharedMemoryRead"Function to read from shared memory"
extends Modelica.Icons.Function;
  input Integer tagIndex;
  output Real tagValue;

  external "C" tagValue = shmRead(tagIndex);
  annotation(
    Include = "#include \"ShmMI.c\"", Library="rt", Documentation(info = "<html>
<p>
<b>Inter Process Communication Library V1.0</b><br /><br />
<b>SharedMemoryRead</b> Function reads data from the shared memory using external C function shmRead(). The shmRead(tagIndex) function reads tagValue from the structure of the shared memory and tagIndex determines that from which location of the memory the tagValue is supposed to be read. tagValue can be any integer ranging  from 1 to 10.<br />
<b>tagIndex</b> of shmWrite on system 1 must match the value of tagIndex of shmRead on system 2 and vice versa. e.g if SharedMemoryWrite(1, pidValue) on system 1 then on system 2 must have Torque1.u = SharedMemoryRead(1) to ensure that output of system1 is read at input of system2 correctly.
</p>
 
<p>
<b>License:</b> OSMC-PL v1.2 2017<br /><br />
<b>Credits:</b> ModeliCon Infotech Team <br />Ankur Gajjar <br />Shubham Patne <br />Jal Panchal <br />Ritesh Sharma <br />Pavan P <br /> 
</p>
</html>"),
    Diagram(graphics = {Bitmap(extent = {{-62, 66}, {-62, 66}})}));

end SharedMemoryRead;