package Torpedo_System with SPARK_Mode
is
  type Torpedo_Tube is (Empty, Loaded);
  type Tube_Index is range 0..3;
  type Torpedo_Tubes is array(Tube_Index) of Torpedo_Tube;
  
  type Torpedo_Index is range 0..23;
  
  type Torpedo_System is tagged private;
  
  function Create return Torpedo_System;
  
  function Get_Torpedo_Count(Self: Torpedo_System) return Torpedo_Index;
  
  function Get_Tubes(Self: Torpedo_System) return Torpedo_Tubes;
  
  procedure Load(Self: in out Torpedo_System; Index: Tube_Index) with
    Pre'Class => Self.Get_Torpedo_Count > 0 and then Self.Get_Tubes(Index) = Empty,
    Contract_Cases => 
      (Self.Get_Tubes(Index) = Loaded => Self.Get_Torpedo_Count'Old = Self.Get_Torpedo_Count,
      Self.Get_Torpedo_Count > 0 => Self.Get_Tubes(Index)'Old = Self.Get_Tubes(Index));
      
  procedure Unload(Self: in out Torpedo_System; Index: Tube_Index) with
    Pre'Class => Self.Get_Tubes(Index) = Loaded,
    Contract_Cases =>
      (Self.Get_Tubes(Index) = Empty => Self.Get_Tubes(Index) = Empty,
      Self.Get_Torpedo_Count = Torpedo_Index'Last => Self.Get_Tubes(Index)'Old = Self.Get_Tubes(Index),
      Self.Get_Tubes(Index) = Loaded and then Self.Get_Torpedo_Count < Torpedo_Index'Last => 
        Self.Get_Tubes(Index) = Empty);
        
  procedure Fire(Self: in out Torpedo_System; Index: Tube_Index) with
    Post => Self.Get_Tubes(Index) = Empty;
    
private
  type Torpedo_System is tagged record
    Remaining_Torpedoes: Torpedo_Index;
    Tubes: Torpedo_Tubes;
  end record;
      
end Torpedo_System;