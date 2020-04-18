with Hatch_System; use Hatch_System;
with Oxygen_System; use Oxygen_System;
with Torpedo_System; use Torpedo_System;
with Reactor_System; use Reactor_System;

package Submarine with SPARK_Mode
is 
  type Dive_Depth is range 0..1300;
  
  type Submarine is tagged private;

  function Create return Submarine;
  
  function Get_Current_Depth(Self: Submarine) return Dive_Depth;
  
  function Get_Hatch_System(Self: Submarine) return Hatch_System.Hatch_System;
  function Get_Oxygen_System(Self: Submarine) return Oxygen_System.Oxygen_System;
  function Get_Torpedo_System(Self: Submarine) return Torpedo_System.Torpedo_System;
  function Get_Reactor_System(Self: Submarine) return Reactor_System.Reactor_System;
  
  procedure Commit_Changes(Self: in out Submarine; State: Hatch_System.Hatch_System);
  procedure Commit_Changes(Self: in out Submarine; State: Torpedo_System.Torpedo_System);
  
  function Can_Operate(Self: Submarine) return Boolean;
  
  procedure Update(Self: in out Submarine) with
    Contract_Cases =>
      (Self.Get_Oxygen_System.Get_Status = Critical => Self.Get_Current_Depth = 0,
      Self.Get_Reactor_System.Get_Status = Critical => Self.Get_Current_Depth = 0);
      
  procedure Change_Depth(Self: in out Submarine; Distance: Dive_Depth) with
    Pre'Class => Self.Can_Operate,
    Post => Self.Get_Current_Depth'Old /= Self.Get_Current_Depth;
    
  procedure Emerge(Self: in out Submarine) with
    Pre'Class => Self.Can_Operate,
    Post => Self.Get_Current_Depth = 0;
    
private
  type Submarine is tagged record
    Hatch_Sys: Hatch_System.Hatch_System;
    Torpedo_Sys: Torpedo_System.Torpedo_System;
    Oxygen_Sys: Oxygen_System.Oxygen_System;
    Reactor_Sys: Reactor_System.Reactor_System;
    Depth: Dive_Depth;
  end record;
  
end Submarine;