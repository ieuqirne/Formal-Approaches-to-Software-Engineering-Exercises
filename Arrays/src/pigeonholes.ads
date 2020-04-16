package PigeonHoles with SPARK_Mode
is
   type Box is (Pigeon, Dove);

   type PH_Index is range 1..5;

   type PigeonHole is array (PH_Index) of Box;

   procedure PigeonBeGone (d : in out PigeonHole) with
     Post => (for all J in d'Range => d(J) /= Pigeon);

   function CountBirds (d : PigeonHole ; b : Box) return Integer
     with
       Post => CountBirds'Result >= 0 and CountBirds'Result <= d'Length;

   procedure SubstituteBirds (d : in out PigeonHole; n : PH_Index ; b: Box) with
     Post => d(n) = b and (for all I in d'Range => (if I /= n then d(I) = d'Old(I)));

--     procedure DoveBeGone (d : in out PigeonHole) with
--     Post => (for some J in d'Range => d(J) /= Dove);



end PigeonHoles;
