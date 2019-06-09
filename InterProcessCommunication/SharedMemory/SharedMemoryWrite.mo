within InterProcessCommunication.SharedMemory;

function SharedMemoryWrite"function to write to shared memory"
extends Modelica.Icons.Function;
  input Integer tagIndex;
  input Real tagValue;
  output Real read;

  external "C" read = shmWrite(tagIndex, tagValue);
  annotation(
    Include = "#include \"ShmMI.c\"", Library="rt", Documentation(info = "<html>
<p>
<b>Inter Process Communication Library V1.0</b><br /><br />
<b>SharedMemoryWrite</b> Function writes data into the shared memory using external C function shmWrite(). The shmWrite(tagIndex, tagValue) function writes tagValue into the location of the shared memory determined by tagIndex. tagIndex value can be any integer between 0 to 10. <br />
<b>tagIndex</b> of shmWrite on system 1 must match the value of tagIndex of shmRead on system 2 and vice versa. e.g if SharedMemoryWrite(1, pidValue) on system 1 then on system 2 must have Torque1.u = SharedMemoryRead(1) to ensure that output of system1 is read at input of system2 correctly.
</p>
 
<p>
<b>License:</b> OSMC-PL v1.2 2017<br /><br />
<b>Credits:</b> ModeliCon Infotech Team <br />Ankur Gajjar <br />Shubham Patne <br />Jal Panchal <br />Ritesh Sharma <br />Pavan P <br /> 
</p>
</html>"));

end SharedMemoryWrite;
