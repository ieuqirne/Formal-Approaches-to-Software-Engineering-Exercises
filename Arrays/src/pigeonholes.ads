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

   function birdExist (d : PigeonHole; b : Box) return Boolean is
     (for some I in d'Range => d(I) = b);

   function birdIndex (d : PigeonHole; b : Box) return PH_Index with
     Pre => birdExist(d,b),
     Post => d(birdIndex'Result) = b,
     Contract_Cases =>
       (d(1) = b and then (for some J in 2..d'Last => d(J) = b) => birdIndex'Result = 1,
       d(1) /= b => birdIndex'Result > 1);



--     procedure DoveBeGone (d : in out PigeonHole) with
--     Post => (for some J in d'Range => d(J) /= Dove);



end PigeonHoles;
