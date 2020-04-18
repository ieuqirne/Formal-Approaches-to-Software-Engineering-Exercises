with Submarine; use Submarine;
with Hatch_System; use Hatch_System;
with Oxygen_System; use Oxygen_System;
with Torpedo_System; use Torpedo_System;

with Ada.Text_IO; use Ada.Text_IO;

procedure Main is
  Sub: Submarine.Submarine := Submarine.Create;
  Hatch_Sys: Hatch_System.Hatch_System := Sub.Get_Hatch_System;
begin
  null;
end Main;