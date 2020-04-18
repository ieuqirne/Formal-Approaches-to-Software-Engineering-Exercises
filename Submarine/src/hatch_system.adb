package body Hatch_System with SPARK_Mode
is
  function Create return Hatch_System
  is
    Self: Hatch_System;
  begin
    Self.H := (others => (Closed => True, Locked => False)); 
    Self.S := Open;
    
    return Self;
  end Create;
  
  function More_Than_One_Hatches_Are_Closed(Self: Hatch_System) return Boolean
  is
    Count: Integer := 0;
  begin
    for I in Self.H'Range loop
      if Count > 1 then
        exit;
      end if;
      
      if Self.H(I).Closed = True then
        Count := Count + 1;
      end if;
    end loop;
    
    return Count > 1;
  end More_Than_One_Hatches_Are_Closed;
  
  function Get_Hatches(Self: Hatch_System) return Hatches
  is
  begin
    return Self.H;
  end Get_Hatches;
  
  function Get_Status(Self: Hatch_System) return Status
  is
  begin
    return Self.S;
  end Get_Status;

  procedure Open_Hatch(Self: in out Hatch_System; Index: Hatch_Index) is
  begin
    if Is_Sealed(Self) or Self.H(Index).Locked = True then 
      return; 
    end if;
       
    if More_Than_One_Hatches_Are_Closed(Self) then
      Self.H(Index).Closed := False;
    end if;
  end Open_Hatch;
  
  procedure Close_Hatch(Self: in out Hatch_System; Index: Hatch_Index) is
  begin
    Self.H(Index).Closed := True;
  end Close_Hatch;
  
  procedure Lock_Hatch(Self: in out Hatch_System; Index: Hatch_Index) is
  begin
    if Self.H(Index).Closed = False then
      return;
    end if;
    
    Self.H(Index).Locked := True;
  end Lock_Hatch;
  
  procedure Unlock_Hatch(Self: in out Hatch_System; Index: Hatch_Index) is
  begin
    if Is_Sealed(Self) then
      return;
    end if;
    
    Self.H(Index).Locked := False;
  end Unlock_Hatch;
  
  procedure Seal(Self: in out Hatch_System) is
  begin
    for I in Self.H'Range loop
      Self.H(I).Closed := True;
      Self.H(I).Locked := True;
    end loop;
    
    Self.S := Sealed;
  end Seal;
  
  procedure Unseal(Self: in out Hatch_System) is
  begin
    for I in Self.H'Range loop
      Self.H(I).Locked := False;
    end loop;
  
    Self.S := Open;
  end Unseal;

end Hatch_System;