package body Torpedo_System with SPARK_Mode
is
  function Create return Torpedo_System
  is
    Self: Torpedo_System;
  begin
    Self.Remaining_Torpedoes := Torpedo_Index'Last;
    -- Can't call Load in the loop because SPARK is stupid, but SPARKS gets MARKS
    for I in Torpedo_Tubes'Range loop
      Self.Tubes(I) := Loaded;
      Self.Remaining_Torpedoes := Self.Remaining_Torpedoes - 1;
    end loop;
    
    return Self;
  end Create;
  
  function Get_Torpedo_Count(Self: Torpedo_System) return Torpedo_Index
  is
  begin
    return Self.Remaining_Torpedoes;
  end Get_Torpedo_Count;
  
  function Get_Tubes(Self: Torpedo_System) return Torpedo_Tubes
  is
  begin
    return Self.Tubes;
  end Get_Tubes;
  
  procedure Load(Self: in out Torpedo_System; Index: Tube_Index) is
  begin
    if Self.Remaining_Torpedoes > Torpedo_Index'First or Self.Tubes(Index) = Loaded then
      return;
    end if;
    
    Self.Tubes(Index) := Loaded;
    Self.Remaining_Torpedoes := Self.Remaining_Torpedoes - 1;
  end Load;
  
  procedure Unload(Self: in out Torpedo_System; Index: Tube_Index) is
  begin
    if Self.Remaining_Torpedoes = Torpedo_Index'Last or Self.Tubes(Index) = Empty then
      return;
    end if;
    
    Self.Tubes(Index) := Empty;
    Self.Remaining_Torpedoes := Self.Remaining_Torpedoes + 1;
  end Unload;
   
  procedure Fire(Self: in out Torpedo_System; Index: Tube_Index) is
  begin
    Self.Tubes(Index) := Empty;
  end Fire;
  
end Torpedo_System;