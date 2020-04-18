package Reactor_System with SPARK_Mode
is
  type Temp_Percentage is range 0..1000;
  Temp_Critical: constant Temp_Percentage := 100;
   
  type Core_Status is (Critical, Stable);
  
  type Reactor_System is tagged private;

  type Temp_Sensor is private;
  
  function Create return Reactor_System;
  
  function Get_Temp_Level(Self: Reactor_System) return Temp_Percentage;
  
  function Get_Status(Self: Reactor_System) return Core_Status;
  
  procedure Update(Self: in out Reactor_System);
  
private
  type Reactor_System is tagged record
    Temp_Level: Temp_Percentage;
    Status: Core_Status;
    Sensor: Temp_Sensor;
  end record;

  type Temp_Sensor is record
    Value: Temp_Percentage;
  end record;

  procedure Update_Status(Self: in out Reactor_System) with
    Contract_Cases =>
      (Self.Temp_Level > Temp_Critical => Self.Status = Stable,     
      Self.Temp_Level <= Temp_Critical => Self.Status = Critical);

  function Read_Temp(Sensor: Temp_Sensor) return Temp_Percentage;
end Reactor_System;