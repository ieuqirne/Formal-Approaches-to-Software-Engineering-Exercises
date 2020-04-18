package Oxygen_System with SPARK_Mode
is
  type Oxygen_Percentage is range 0..1000;
  Oxygen_Threshold: constant Oxygen_Percentage := 200;
  Oxygen_Critical: constant Oxygen_Percentage := 10;

  type Status is (Critical, Warning, Stable);

  type Oxygen_System is tagged private;

  type Tank_Sensor is private;

  function Get_Oxygen_Level(Self: Oxygen_System) return Oxygen_Percentage;

  function Get_Status(Self: Oxygen_System) return Status;

  function Create return Oxygen_System;

  procedure Update(Self: in out Oxygen_System);

private
  type Oxygen_System is tagged record
    Oxygen_Count: Oxygen_Percentage;
    S: Status;
    Sensor: Tank_Sensor;
  end record;

  type Tank_Sensor is record
    Value: Oxygen_Percentage;
  end record;

  procedure Update_Oxygen_Level(Self: in out Oxygen_System);

  procedure Update_Status(Self: in out Oxygen_System) with
    Contract_Cases =>
      (Self.Oxygen_Count > Oxygen_Threshold => Self.S = Stable,
      Self.Oxygen_Count > Oxygen_Critical and Self.Oxygen_Count <= Oxygen_Threshold => Self.S = Warning,
      Self.Oxygen_Count <= Oxygen_Critical => Self.S = Critical);

  function Read_Oxygen_Level(Sensor: Tank_Sensor) return Oxygen_Percentage;

end Oxygen_System;