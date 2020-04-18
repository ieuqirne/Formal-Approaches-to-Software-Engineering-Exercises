package body Reactor_System with SPARK_Mode
is
  function Create return Reactor_System
  is
    Self: Reactor_System;
    Sensor: Temp_Sensor;
  begin
    Sensor.Value := Temp_Percentage'Last;
    Self.Status := Stable;
    Self.Temp_Level := Temp_Percentage'Last;
    
    Self.Update;
    
    return Self;
  end Create;
  
  function Get_Temp_Level(Self: Reactor_System) return Temp_Percentage
  is
  begin
    return Self.Temp_Level;
  end Get_Temp_Level;
  
  function Get_Status(Self: Reactor_System) return Core_Status
  is
  begin
    return Self.Status;
  end Get_Status;
  
  procedure Update(Self: in out Reactor_System) is
  begin
    Self.Temp_Level := Read_Temp(Self.Sensor);
    Update_Status(Self);
  end Update;
  
  procedure Update_Status(Self: in out Reactor_System) is
  begin
    if Self.Temp_Level > Temp_Critical then
      Self.Status := Stable;
    else
      Self.Status := Critical;
    end if;
  end Update_Status;
  
  function Read_Temp(Sensor: Temp_Sensor) return Temp_Percentage
  is
  begin
    return Sensor.Value;
  end Read_Temp;
   
end Reactor_System;