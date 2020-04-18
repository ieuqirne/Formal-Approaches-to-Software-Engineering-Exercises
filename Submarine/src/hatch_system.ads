package Hatch_System with SPARK_Mode
is
  type Hatch is record
    Closed: Boolean;
    Locked: Boolean;
  end record;  
  
  type Hatch_Index is range 0..1; 
  type Hatches is array (Hatch_Index) of Hatch;
  
  type Status is (Sealed, Open);
  
  type Hatch_System is tagged private;
  
  function Get_Hatches(Self: Hatch_System) return Hatches;
  
  function Get_Status(Self: Hatch_System) return Status;
  
  function At_Least_One_Hatch_Is_Closed(Self: Hatch_System) return Boolean
  is
    (for some I in Self.Get_Hatches'Range => 
      Self.Get_Hatches(I).Closed = True);
      
  function Is_Sealed(Self: Hatch_System) return Boolean
    is (Self.Get_Status = Sealed);
    
  function More_Than_One_Hatches_Are_Closed(Self: Hatch_System) return Boolean;
      
  function Create return Hatch_System;
  
  procedure Open_Hatch(Self: in out Hatch_System; Index: Hatch_Index) with
    Pre'Class => Self.Is_Sealed = False and then 
      Self.Get_Hatches(Index).Locked = False and then 
      More_Than_One_Hatches_Are_Closed(Self);
    
  procedure Close_Hatch(Self: in out Hatch_System; Index: Hatch_Index) with
    Post => Self.Get_Hatches(Index).Closed = True;
    
  procedure Lock_Hatch(Self: in out Hatch_System; Index: Hatch_Index) with
    Pre'Class => Self.Get_Hatches(Index).Closed = True,
    Post => Self.Get_Hatches(Index).Closed = True and then Self.Get_Hatches(Index).Locked = True;
    
  procedure Unlock_Hatch(Self: in out Hatch_System; Index: Hatch_Index) with
    Pre'Class => Is_Sealed(Self) = False,
    Post => Self.Get_Hatches(Index).Locked = False;
    
  procedure Seal(Self: in out Hatch_System) with
    Post => ((for all I in Self.Get_Hatches'Range => 
               Self.Get_Hatches(I).Closed = True and then Self.Get_Hatches(I).Locked = True)
            and then Self.Is_Sealed);
    
  procedure Unseal(Self: in out Hatch_System) with
    Post => ((for all I in Self.Get_Hatches'Range => 
               Self.Get_Hatches(I).Locked = False)
            and then Self.Is_Sealed = False);
            
private
  type Hatch_System is tagged record
    H: Hatches;
    S: Status;
  end record;

end Hatch_System;
