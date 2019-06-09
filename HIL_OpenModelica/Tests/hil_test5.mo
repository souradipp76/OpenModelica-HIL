within HIL_OpenModelica.Tests;
model hil_test5
  extends Modelica.Icons.Example;
  Servomechanisms.Electrical.SignalDCMotor signalDCMotor1(J = 10) annotation(
    Placement(visible = true, transformation(origin = {0, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.Communication.SharedMemoryRead sharedMemoryRead1(autoBufferSize = true, memoryID = "1", sampleTime = 0.05, startTime = 0, userBufferSize = 10 * 32) annotation(
    Placement(visible = true, transformation(origin = {-56, 78}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.AddReal addReal1(n = 1, nu = 1) annotation(
    Placement(visible = true, transformation(origin = {60, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.AddInteger addInteger1(n = 1, nu = 1) annotation(
    Placement(visible = true, transformation(origin = {60, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.AddString addString1(bufferSize = 2, data = ",", nu = 1) annotation(
    Placement(visible = true, transformation(origin = {60, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.AddString addString2(bufferSize = 2, data = "\n", nu = 1) annotation(
    Placement(visible = true, transformation(origin = {60, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.GetInteger getInteger1(n = 1, nu = 1, y(each fixed = true, each start = 0)) annotation(
    Placement(visible = true, transformation(origin = {-56, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.GetReal getReal1(n = 1, nu = 1) annotation(
    Placement(visible = true, transformation(origin = {-56, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.GetString getString1(bufferSize = 2, nu = 1) annotation(
    Placement(visible = true, transformation(origin = {-56, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.GetString getString2(bufferSize = 2, nu = 0) annotation(
    Placement(visible = true, transformation(origin = {-56, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.Communication.SharedMemoryWrite sharedMemoryWrite1(autoBufferSize = true, memoryID = "1", sampleTime = 0.05, startTime = 0, userBufferSize = 10 * 32) annotation(
    Placement(visible = true, transformation(origin = {60, -84}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.Packager packager1 annotation(
    Placement(visible = true, transformation(origin = {60, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(sharedMemoryWrite1.pkgIn, addString2.pkgOut[1]) annotation(
    Line(points = {{60, -73}, {60, -64}}));
  connect(getInteger1.pkgIn, sharedMemoryRead1.pkgOut) annotation(
    Line(points = {{-56, 42}, {-56, 67}}));
  connect(getInteger1.y[1], addInteger1.u[1]) annotation(
    Line(points = {{-44, 32}, {46, 32}, {46, 32}, {48, 32}}, color = {255, 127, 0}, thickness = 0.5));
  connect(signalDCMotor1.u, getReal1.y[1]) annotation(
    Line(points = {{-10, 6}, {-28, 6}, {-28, -24}, {-44, -24}, {-44, -24}}, color = {0, 0, 127}));
  connect(packager1.pkgOut, addInteger1.pkgIn) annotation(
    Line(points = {{60, 54}, {60, 54}, {60, 42}, {60, 42}}));
  connect(getReal1.pkgOut[1], getString2.pkgIn) annotation(
    Line(points = {{-56, -34}, {-56, -34}, {-56, -42}, {-56, -42}}, thickness = 0.5));
  connect(getString1.pkgOut[1], getReal1.pkgIn) annotation(
    Line(points = {{-56, -7}, {-56, -13}}, thickness = 0.5));
  connect(getInteger1.pkgOut[1], getString1.pkgIn) annotation(
    Line(points = {{-56, 22}, {-56, 15}}, thickness = 0.5));
  connect(addReal1.pkgOut[1], addString2.pkgIn) annotation(
    Line(points = {{60, -38}, {60, -38}, {60, -44}, {60, -44}}, thickness = 0.5));
  connect(addString1.pkgOut[1], addReal1.pkgIn) annotation(
    Line(points = {{60, -8}, {60, -8}, {60, -18}, {60, -18}}, thickness = 0.5));
  connect(addInteger1.pkgOut[1], addString1.pkgIn) annotation(
    Line(points = {{60, 22}, {60, 22}, {60, 12}, {60, 12}}, thickness = 0.5));
  connect(signalDCMotor1.speed, addReal1.u[1]) annotation(
    Line(points = {{6, -4}, {27, -4}, {27, -28}, {48, -28}}, color = {0, 0, 127}));
end hil_test5;

