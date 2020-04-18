package body Oxygen_System with SPARK_Mode
is
  function Create return Oxygen_System
  is
    Self: Oxygen_System;
    Sensor: Tank_Sensor;
  begin
    Sensor.Value := Oxygen_Percentage'Last;
    Self.Sensor := Sensor;
    Self.S := Stable;
    Self.Oxygen_Count := Oxygen_Percentage'Last;
    
    Self.Update;
    
    return Self;
  end Create;
  
  function Get_Oxygen_Level(Self: Oxygen_System) return Oxygen_Percentage
  is
  begin
    return Self.Oxygen_Count;
  end Get_Oxygen_Level;
  
  function Get_Status(Self: Oxygen_System) return Status
  is
  begin
    return Self.S;
  end Get_Status;
  
  procedure Update(Self: in out Oxygen_System) is
  begin
    Update_Oxygen_Level(Self);
    Update_Status(Self);
  end Update;
  
  procedure Update_Oxygen_Level(Self: in out Oxygen_System) is
  begin
    Self.Oxygen_Count := Read_Oxygen_Level(Self.Sensor);
  end Update_Oxygen_Level;
  
  procedure Update_Status(Self: in out Oxygen_System) is
  begin
    if Self.Oxygen_Count > Oxygen_Threshold then
      Self.S := Stable;
    elsif Self.Oxygen_Count > Oxygen_Critical then
      Self.S := Warning;
    else
      Self.S := Critical;
    end if;
  end Update_Status;
  
  function Read_Oxygen_Level(Sensor: Tank_Sensor) return Oxygen_Percentage
  is
  begin
    return Sensor.Value;
  end Read_Oxygen_Level;

end Oxygen_System;